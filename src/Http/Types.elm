module Http.Types (..) where

{-|
# Agent
@docs Agent, AgentOptions, defaultAgentOptions

# Method
@docs METHOD, showMethod

# Server
@docs Server, Request, Response

# Error
@docs Error
-}

import Cardinal exposing (Cardinal(PosInfinity, Finite))
import Time exposing (Time)
import Foreign.Types exposing (JSRaw)


{-| Http Error
-}
type Error
    = Error String


{-|
options Object Set of configurable options to set on the agent. Can have the following fields:
keepAlive Boolean Keep sockets around in a pool to be used by other requests in the future.
Default = false
keepAliveMsecs Integer When using HTTP KeepAlive, how often to send TCP KeepAlive packets over sockets
being kept alive. Default = 1000. Only relevant if keepAlive is set to true.
maxSockets Number Maximum number of sockets to allow per host. Default = Infinity.
maxFreeSockets Number Maximum number of sockets to leave open in a free state. Only relevant if keepAlive is set to true. Default = 256.
The default http.globalAgent that is used by http.request() has all of these values set to their respective defaults.
-}
type alias AgentOptions =
    { keepAlive : Bool
    , keepAliveMsecs : Time
    , maxSockets : Cardinal Int
    , maxFreeSockets : Int
    }


{-| -}
defaultAgentOptions : AgentOptions
defaultAgentOptions =
    { keepAlive = False
    , keepAliveMsecs = 1000
    , maxSockets = PosInfinity
    , maxFreeSockets = 256
    }


{-|
Represents a raw instance of Node.js's http.Agent class
-}
type Agent
    = Agent JSRaw


{-|
Represents a raw instance of Node.js's http.Server class
-}
type Server
    = Server JSRaw


{-|
Represents a raw instance of Node.js's http.IncomingMessage class
-}
type Request
    = Request JSRaw


{-|
Represents a raw instance of Node.js's http.ServerResponse class
-}
type Response
    = Response JSRaw


{-|
HTTP methods that are supported by the parser.
-}
type METHOD
    = ACL
    | BIND
    | CHECKOUT
    | CONNECT
    | COPY
    | DELETE
    | GET
    | HEAD
    | LINK
    | LOCK
    | MSEARCH
    | MERGE
    | MKACTIVITY
    | MKCALENDAR
    | MKCOL
    | MOVE
    | NOTIFY
    | OPTIONS
    | PATCH
    | POST
    | PROPFIND
    | PROPPATCH
    | PURGE
    | PUT
    | REBIND
    | REPORT
    | SEARCH
    | SUBSCRIBE
    | TRACE
    | UNBIND
    | UNLINK
    | UNLOCK
    | UNSUBSCRIBE


{-|
To standard human readable string
-}
showMethod : METHOD -> String
showMethod method =
    case method of
        ACL ->
            "ACL"

        BIND ->
            "BIND"

        CHECKOUT ->
            "CHECKOUT"

        CONNECT ->
            "CONNECT"

        COPY ->
            "COPY"

        DELETE ->
            "DELETE"

        GET ->
            "GET"

        HEAD ->
            "HEAD"

        LINK ->
            "LINK"

        LOCK ->
            "LOCK"

        MSEARCH ->
            "M-SEARCH"

        MERGE ->
            "MERGE"

        MKACTIVITY ->
            "MKACTIVITY"

        MKCALENDAR ->
            "MKCALENDAR"

        MKCOL ->
            "MKCOL"

        MOVE ->
            "MOVE"

        NOTIFY ->
            "NOTIFY"

        OPTIONS ->
            "OPTIONS"

        PATCH ->
            "PATCH"

        POST ->
            "POST"

        PROPFIND ->
            "PROPFIND"

        PROPPATCH ->
            "PROPPATCH"

        PURGE ->
            "PURGE"

        PUT ->
            "PUT"

        REBIND ->
            "REBIND"

        REPORT ->
            "REPORT"

        SEARCH ->
            "SEARCH"

        SUBSCRIBE ->
            "SUBSCRIBE"

        TRACE ->
            "TRACE"

        UNBIND ->
            "UNBIND"

        UNLINK ->
            "UNLINK"

        UNLOCK ->
            "UNLOCK"

        UNSUBSCRIBE ->
            "UNSUBSCRIBE"