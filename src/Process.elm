module Process (onBeforeExit, onExit, onMessage, exitToInt, intToExit, ExitCode(..), SIGNAL, onSIGNAL, argumentVector, architecture, Architecture(..), isConnected, abort, exit, exitWithCode, currentWorkingDirectory, changeCurrentWorkingDirectory, ChdirError(..), getEffectiveUserId, getEffectiveGroupId, getUserId, getGroups, getGroupId, disconnect, getHighResolutionTime, version, versions, uptime, ProcessNotFound(..), kill, killWithSIGNAL, getTitle, setTitle, modifyTitle, standardIn, standardOut) where

{-|
# Events
@docs onBeforeExit, onExit, onMessage

# Exit Codes
@docs exitToInt, intToExit, ExitCode

# SIGNAL (POSIX) Exits
@docs SIGNAL, onSIGNAL

# Process Info
@docs argumentVector, architecture, Architecture, isConnected, version, versions, uptime, getTitle, setTitle, modifyTitle

# Exit Methods
@docs abort, exit, exitWithCode, disconnect, kill, killWithSIGNAL, ProcessNotFound

# Working Directory
@docs currentWorkingDirectory, changeCurrentWorkingDirectory, ChdirError

# User Info
@docs getEffectiveUserId, getEffectiveGroupId, getUserId, getGroupId, getGroups

# Utils
@docs getHighResolutionTime

# Streams
@docs standardIn, standardOut
-}

import Foreign.Types exposing (JSRaw)
import Foreign.Pattern.Method as Method
import Foreign.Pattern.Read as Read
import Foreign.Pattern.Get as Get
import Foreign.Pattern.Set as Set
import Foreign.Marshall as Marshall
import Emitter.Unsafe as Emitter
import Task exposing (Task)
import Json.Decode as Json
import Time exposing (Time)
import Streams.Types as Streams


process : JSRaw
process =
    Marshall.unsafeGetGlobalConstant "process"


{-|
Event: 'beforeExit'
This event is emitted when Node.js empties its event loop and has nothing else
to schedule. Normally, Node.js exits when there is no work scheduled, but a
listener for 'beforeExit' can make asynchronous calls, and cause Node.js to continue.

'beforeExit' is not emitted for conditions causing explicit termination,
such as process.exit() or uncaught exceptions, and should not be used as an
alternative to the 'exit' event unless the intention is to schedule more work.
-}
onBeforeExit : Task x () -> Task x (Task x ())
onBeforeExit =
    Emitter.on0 "beforeExit" process


{-|
Event: 'exit'
Emitted when the process is about to exit. There is no way to prevent the exiting of the event loop at this point, and once all 'exit' listeners have finished running the process will exit. Therefore you must only perform synchronous operations in this handler. This is a good hook to perform checks on the module's state (like for unit tests). The callback takes one argument, the code the process is exiting with.

This event is only emitted when Node.js exits explicitly by process.exit() or implicitly by the event loop draining.
-}
onExit : (Maybe ExitCode -> Task x ()) -> Task x (Task x ())
onExit f =
    Emitter.on1 "exit" process (f << intToExit)


{-|
Event: 'message'
message Object a parsed JSON object or primitive value
sendHandle Handle object a net.Socket or net.Server object, or undefined.
Messages sent by ChildProcess.send() are obtained using the 'message' event on the child's process object.
-}
onMessage : (JSRaw -> Task x ()) -> Task x (Task x ())
onMessage =
    Emitter.on1 "message" process


{-|
Exit Codes
Node.js will normally exit with a 0 status code when no more async operations are pending. The following status codes are used in other cases:

1 Uncaught Fatal Exception - There was an uncaught exception, and it was not handled by a domain or an 'uncaughtException' event handler.
2 - Unused (reserved by Bash for builtin misuse)
3 Internal JavaScript Parse Error - The JavaScript source code internal in Node.js's bootstrapping process caused a parse error. This is extremely rare, and generally can only happen during development of Node.js itself.
4 Internal JavaScript Evaluation Failure - The JavaScript source code internal in Node.js's bootstrapping process failed to return a function value when evaluated. This is extremely rare, and generally can only happen during development of Node.js itself.
5 Fatal Error - There was a fatal unrecoverable error in V8. Typically a message will be printed to stderr with the prefix FATAL ERROR.
6 Non-function Internal Exception Handler - There was an uncaught exception, but the internal fatal exception handler function was somehow set to a non-function, and could not be called.
7 Internal Exception Handler Run-Time Failure - There was an uncaught exception, and the internal fatal exception handler function itself threw an error while attempting to handle it. This can happen, for example, if a process.on('uncaughtException') or domain.on('error') handler throws an error.
8 - Unused. In previous versions of Node.js, exit code 8 sometimes indicated an uncaught exception.
9 - Invalid Argument - Either an unknown option was specified, or an option requiring a value was provided without a value.
10 Internal JavaScript Run-Time Failure - The JavaScript source code internal in Node.js's bootstrapping process threw an error when the bootstrapping function was called. This is extremely rare, and generally can only happen during development of Node.js itself.
12 Invalid Debug Argument - The --debug and/or --debug-brk options were set, but an invalid port number was chosen.
>128 Signal Exits - If Node.js receives a fatal signal such as SIGKILL or SIGHUP, then its exit code will be 128 plus the value of the signal code. This is a standard Unix practice, since exit codes are defined to be 7-bit integers, and signal exits set the high-order bit, and then contain the value of the signal code.
-}
type ExitCode
    = Success
    | UncaughtFatalException
    | InternalJavaScriptParseError
    | InternalJavaScriptEvaluationFailure
    | FatalError
    | NonfunctionInternalExceptionHandler
    | InvalidArgument
    | InternalJavaScriptRunTimeFailure
    | InvalidDebugArgument


{-| Convert an `ExitCode` to its C style `Int` representation
-}
exitToInt : ExitCode -> Int
exitToInt code =
    case code of
        Success ->
            0

        UncaughtFatalException ->
            1

        InternalJavaScriptParseError ->
            3

        InternalJavaScriptEvaluationFailure ->
            4

        FatalError ->
            5

        NonfunctionInternalExceptionHandler ->
            6

        InvalidArgument ->
            7

        InternalJavaScriptRunTimeFailure ->
            9

        InvalidDebugArgument ->
            10


{-| Convert a C style `Int` exit code to an `ExitCode` if possible
-}
intToExit : Int -> Maybe ExitCode
intToExit i =
    case i of
        0 ->
            Just Success

        1 ->
            Just UncaughtFatalException

        3 ->
            Just InternalJavaScriptParseError

        4 ->
            Just InternalJavaScriptEvaluationFailure

        5 ->
            Just FatalError

        6 ->
            Just NonfunctionInternalExceptionHandler

        7 ->
            Just InvalidArgument

        9 ->
            Just InternalJavaScriptRunTimeFailure

        10 ->
            Just InvalidDebugArgument

        _ ->
            Nothing


{-|
SIGUSR1 is reserved by Node.js to start the debugger.
It's possible to install a listener but that won't stop the debugger from starting.

SIGTERM and SIGINT have default handlers on non-Windows platforms that resets the
terminal mode before exiting with code 128 + signal number.
If one of these signals has a listener installed, its default behavior will be removed
(Node.js will no longer exit).

SIGPIPE is ignored by default. It can have a listener installed.

SIGHUP is generated on Windows when the console window is closed, and on other platforms
under various similar conditions, see signal(7). It can have a listener installed,
however Node.js will be unconditionally terminated by Windows about 10 seconds later. On
non-Windows platforms, the default behavior of SIGHUP is to terminate Node.js, but once
a listener has been installed its default behavior will be removed.

SIGTERM is not supported on Windows, it can be listened on.

SIGINT from the terminal is supported on all platforms, and can usually be generated
with CTRL+C (though this may be configurable). It is not generated when terminal raw
mode is enabled.

SIGBREAK is delivered on Windows when CTRL+BREAK is pressed, on non-Windows platforms it
can be listened on, but there is no way to send or generate it.

SIGWINCH is delivered when the console has been resized. On Windows, this will only
happen on write to the console when the cursor is being moved, or when a readable tty is
used in raw mode.

SIGKILL cannot have a listener installed, it will unconditionally terminate Node.js on
all platforms.

SIGSTOP cannot have a listener installed.
Note that Windows does not support sending Signals, but Node.js offers some emulation
with process.kill(), and child_process.kill(). Sending signal 0 can be used to test for
the existence of a process. Sending SIGINT, SIGTERM, and SIGKILL cause the unconditional
termination of the target process.
-}
type SIGNAL
    = SIGUSR1
    | SIGTERM
    | SIGINT
    | SIGPIPE
    | SIGHUP
    | SIGBREAK
    | SIGWINCH
    | SIGKILL
    | SIGSTOP


{-| Execute a task on a process signal
-}
onSIGNAL : SIGNAL -> Task x () -> Task x (Task x ())
onSIGNAL sig =
    Emitter.on0 (toString sig) process


{-|
process.abort()
This causes Node.js to emit an abort. This will cause Node.js to exit and generate a core file.
-}
abort : Task x ()
abort =
    Method.method0 "abort" process


{-|
Possible processor architectures
-}
type Architecture
    = Arm
    | Ia32
    | X64


{-|
process.arch
What processor architecture you're running on: 'arm', 'ia32', or 'x64'.
-}
architecture : Maybe Architecture
architecture =
    case Read.unsafeRead "arch" process of
        "arm" ->
            Just Arm

        "ia32" ->
            Just Ia32

        "x64" ->
            Just X64

        _ ->
            Nothing


{-|
process.argv
An array containing the command line arguments. The first element will be 'node',
the second element will be the name of the JavaScript file.
The next elements will be any additional command line arguments.

```
$ node process-2.js one two=three four
```

will result in

```
argumentVector = [ "node", "process-2.js", "one", "two=three", "four" ]
```
-}
argumentVector : List String
argumentVector =
    Read.unsafeRead "argv" process


{-| An error that changeCurrentWorkingDirectory may throw
-}
type ChdirError
    = ChdirError String


{-|
process.chdir(directory)
Changes the current working directory of the process or throws an
exception if that fails.
-}
changeCurrentWorkingDirectory : String -> Task ChdirError ()
changeCurrentWorkingDirectory =
    Method.method1E ChdirError "chdir" process


{-|
process.connected
Boolean Set to false after process.disconnect() is called
If process.connected is false, it is no longer possible to send messages.
-}
isConnected : Task x Bool
isConnected =
    Read.read "connected" process


{-|
process.cwd()
Returns the current working directory of the process.
-}
currentWorkingDirectory : Task x String
currentWorkingDirectory =
    Get.get0 "cwd" process


{-|
process.disconnect()
Close the IPC channel to the parent process, allowing this child to exit
gracefully once there are no other connections keeping it alive.

Identical to the parent process's ChildProcess.disconnect().

If Node.js was not spawned with an IPC channel, process.disconnect() will be undefined.
-}
disconnect : Task x ()
disconnect =
    Method.method0 "disconnect" process


{-|
process.env
An object containing the user environment. See environ(7).

An example of this object looks like:

{ TERM: 'xterm-256color',
  SHELL: '/usr/local/bin/bash',
  USER: 'maciej',
  PATH: '~/.bin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin',
  PWD: '/Users/maciej',
  EDITOR: 'vim',
  SHLVL: '1',
  HOME: '/Users/maciej',
  LOGNAME: 'maciej',
  _: '/usr/local/bin/node' }
-}
environment : Task x Json.Value
environment =
    Read.read "env" process


{-|
process.exit([code])
Ends the process with the specified code.
-}
exitWithCode : ExitCode -> Task x ()
exitWithCode code =
    Method.method1 "exit" process (exitToInt code)


{-| Exit with exit code `Success` (which is 0 in C speak)
-}
exit : Task x ()
exit =
    Method.method0 "exit" process


getIfFunction : String -> Task x (Maybe a)
getIfFunction methodName =
    if Marshall.truthy (Read.unsafeRead methodName process) then
        Get.get0 methodName process
            |> Task.map Just
    else
        Task.succeed Nothing


{-|
process.getegid()
Note: this function is only available on POSIX platforms (i.e. not Windows, Android)

Gets the effective group identity of the process. (See getegid(2).) This is the numerical group id, not the group name.

if (process.getegid) {
  console.log('Current gid: ' + process.getegid());
}
-}
getEffectiveGroupId : Task x (Maybe Int)
getEffectiveGroupId =
    getIfFunction "getegid"


{-|
process.geteuid()
Note: this function is only available on POSIX platforms (i.e. not Windows, Android)

Gets the effective user identity of the process. (See geteuid(2).) This is the numerical userid, not the username.

if (process.geteuid) {
  console.log('Current uid: ' + process.geteuid());
}
-}
getEffectiveUserId : Task x (Maybe Int)
getEffectiveUserId =
    getIfFunction "geteuid"


{-|
process.getgid()
Note: this function is only available on POSIX platforms (i.e. not Windows, Android)

Gets the group identity of the process. (See getgid(2).) This is the numerical group id, not the group name.

if (process.getgid) {
  console.log('Current gid: ' + process.getgid());
}
-}
getGroupId : Task x (Maybe Int)
getGroupId =
    getIfFunction "getgid"


{-|
process.getgroups()
Note: this function is only available on POSIX platforms (i.e. not Windows, Android)

Returns an array with the supplementary group IDs. POSIX leaves it unspecified if the effective group ID is included but Node.js ensures it always is.
-}
getGroups : Task x (Maybe (List Int))
getGroups =
    getIfFunction "getgroups"


{-|
process.getuid()
Note: this function is only available on POSIX platforms (i.e. not Windows, Android)

Gets the user identity of the process. (See getuid(2).) This is the numerical userid, not the username.

if (process.getuid) {
  console.log('Current uid: ' + process.getuid());
}
-}
getUserId : Task x (Maybe Int)
getUserId =
    getIfFunction "getuid"


{-|
process.hrtime()
Returns the current high-resolution real time in a [seconds, nanoseconds] tuple Array.
It is relative to an arbitrary time in the past. It is not related to the time of day
and therefore not subject to clock drift. The primary use is for measuring performance between intervals.
-}
getHighResolutionTime : Task x (Maybe ( Time, Time ))
getHighResolutionTime =
    Get.get0 "hrtime" process
        `Task.andThen` \rawTup ->
                        Json.decodeValue (Json.tuple2 (,) Json.float Json.float) rawTup
                            |> Task.fromResult
                            |> Task.toMaybe


{-| Error that may be thrown by `kill`
-}
type ProcessNotFound
    = ProcessNotFound String


{-|
process.kill(pid[, signal])
Send a signal to a process. pid is the process id and signal is the string describing the signal to send.
Signal with be SIGTERM.

Will throw an error if target does not exist, and as a special case, a signal of 0 can be used
to test for the existence of a process. Windows platforms will throw an error if the pid
is used to kill a process group.

Note that even though the name of this function is process.kill, it is really just a signal sender,
like the kill system call. The signal sent may do something other than kill the target process.
-}
kill : Int -> Task ProcessNotFound ()
kill =
    Method.method1E ProcessNotFound "kill" process


{-| same as kill but with a specific SIGNAL
-}
killWithSIGNAL : Int -> SIGNAL -> Task ProcessNotFound ()
killWithSIGNAL i sig =
    Method.method2E ProcessNotFound "kill" process i (toString sig)


type alias MemoryUsage =
    { rss : Int
    , heapTotal : Int
    , heapUsed : Int
    }

{-|
process.memoryUsage()
Returns an object describing the memory usage of the Node.js process measured in bytes.
heapTotal and heapUsed refer to V8's memory usage.
-}
getMemoryUsage : Task x MemoryUsage
getMemoryUsage =
    Get.get0 "memoryUsage" process


{-|
process.pid
The PID of the process.
-}
processId : Int
processId =
    Read.unsafeRead "pid" process

type Platform
    = Darwin
    | FreeBSD
    | Linux
    | SunOS
    | Win32
    | Unknown

{-|
process.platform
What platform you're running on: 'darwin', 'freebsd', 'linux', 'sunos' or 'win32'

console.log('This platform is ' + process.platform);
-}
platform : Platform
platform =
    case Read.unsafeRead "platform" process of
        "darwin" -> Darwin
        "freebsd" -> FreeBSD
        "linux" -> Linux
        "sunos" -> SunOS
        "win32" -> Win32
        _ -> Unknown


{-|
process.send(message[, sendHandle][, callback])
When Node.js is spawned with an IPC channel attached, it can send messages to its parent process using
process.send(). Each will be received as a 'message' event on the parent's ChildProcess object.

If Node.js was not spawned with an IPC channel, process.send() will be undefined.
-}
send : Maybe (String -> Task x ())
send =
    method1IfFunction "send"

{-|
process.setegid(id)
Note: this function is only available on POSIX platforms (i.e. not Windows, Android)
Sets the effective group identity of the process. (See setegid(2).)
-}
setEffectiveGroupId : Maybe (Int -> Task x ())
setEffectiveGroupId =
    method1IfFunction "setegid"

{-|
process.seteuid(id)
Note: this function is only available on POSIX platforms (i.e. not Windows, Android)
Sets the effective user identity of the process. (See seteuid(2).)
-}
setEffectiveUserId : Maybe (Int -> Task x ())
setEffectiveUserId =
    method1IfFunction "seteuid"

{-|
process.setgid(id)
Note: this function is only available on POSIX platforms (i.e. not Windows, Android)
Sets the group identity of the process. (See setgid(2).)
-}
setGroupId : Maybe (Int -> Task x ())
setGroupId =
    method1IfFunction "setgid"

{-|
process.setuid(id)
Note: this function is only available on POSIX platforms (i.e. not Windows, Android)
Sets the user identity of the process. (See setuid(2).)
-}
setUserId : Maybe (Int -> Task x ())
setUserId =
    method1IfFunction "setuid"

method1IfFunction : String -> Maybe (a -> Task x ())
method1IfFunction name =
    if Marshall.truthy <| Read.unsafeRead name process then
        Just <| Method.method1 name process
    else
        Nothing

{-|
process.stderr
A writable stream to stderr (on fd 2).

process.stderr and process.stdout are unlike other streams in Node.js in that they
cannot be closed (end() will throw), they never emit the finish event and that writes
can block when output is redirected to a file (although disks are fast and operating
systems normally employ write-back caching so it should be a very rare occurrence indeed.)
-}
standardError : Streams.Writable
standardError =
    Read.unsafeRead "stderr" process

{-|
process.stdin
A Readable Stream for stdin (on fd 0).
-}
standardIn : Streams.Readable
standardIn =
    Read.unsafeRead "stdin" process

{-|
process.stdout
A Writable Stream to stdout (on fd 1).

process.stderr and process.stdout are unlike other streams in Node.js in that they cannot be closed
(end() will throw), they never emit the 'finish' event and that writes can block when output is
redirected to a file (although disks are fast and operating systems normally employ
write-back caching so it should be a very rare occurrence indeed.)
-}
standardOut : Streams.Writable
standardOut =
    Read.unsafeRead "stdout" process


{-|
process.title
To set what is displayed in `ps`.
-}
getTitle : Task x String
getTitle =
    Read.read "title" process


{-| Sets the process title
The maximum length is platform-specific and probably short.
On Linux and OS X, it's limited to the size of the binary name plus the length of the command line arguments because it overwrites the argv memory.
-}
setTitle : String -> Task x ()
setTitle =
    Set.set "title" process


{-| Same as `setTitle` but lets you read the current title at the same time.
-}
modifyTitle : (String -> String) -> Task x ()
modifyTitle =
    Set.modify "title" process


{-|
process.umask([mask])
Sets the process's file mode creation mask.
Child processes inherit the mask from the parent process.
Returns the old mask.
-}
unmask : Int -> Task x Int
unmask =
    Get.get1 "unmask" process


{-|
process.umask([mask])
Reads the process's file mode creation mask.
Child processes inherit the mask from the parent process.
Returns the current mask.
-}
currentMask : Task x Int
currentMask =
    Get.get0 "unmask" process


{-|
process.uptime()
Number of seconds Node.js has been running.
-}
uptime : Task x Time
uptime =
    Get.get0 "uptime" process


{-|
process.version
A compiled-in property that exposes NODE_VERSION.

console.log('Version: ' + process.version);
-}
version : String
version =
    Read.unsafeRead "version" process


{-|
process.versions
A property exposing version strings of Node.js and its dependencies.

console.log(process.versions);
Will print something like:

{ http_parser: '2.3.0',
  node: '1.1.1',
  v8: '4.1.0.14',
  uv: '1.3.0',
  zlib: '1.2.8',
  ares: '1.10.0-DEV',
  modules: '43',
  icu: '55.1',
  openssl: '1.0.1k' }
-}
versions : Json.Value
versions =
    Read.unsafeRead "versions" process
