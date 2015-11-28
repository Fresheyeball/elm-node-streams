module FS.Types where

import Streams.Types as T

type alias Encoding = T.Encoding
type alias FilePath = String
type alias Mode     = Int

type Buffer         = Buffer
type FSError        = FSError String
type FileDescriptor = FileDescriptor
type Flags
  = R
  | Rplus
  | RS
  | RSplus
  | W
  | Wplus
  | WX
  | WXplus
  | A
  | AX
  | Aplus
  | AXplus

flagsToString : Flags -> String
flagsToString f = case f of
  R      -> "r"
  Rplus  -> "r+"
  RS     -> "rs"
  RSplus -> "rs+"
  W      -> "w"
  Wplus  -> "w+"
  WX     -> "wx"
  WXplus -> "wx+"
  A      -> "a"
  AX     -> "ax"
  Aplus  -> "a+"
  AXplus -> "ax+"

type alias ReadOptions =
  { flags     : Flags
  , encoding  : Encoding
  , mode      : Mode
  , autoClose : Bool }

type alias ReadOptionsRaw =
  { flags     : String
  , encoding  : String
  , mode      : Mode
  , autoClose : Bool }

defaultReadOptions : ReadOptions
defaultReadOptions =
  { flags          = R
  , mode           = 438 -- 0o666
  , autoClose      = True
  , encoding       = T.Binary }

marshallReadOptions : ReadOptions -> ReadOptionsRaw
marshallReadOptions o =
  { o | flags    = flagsToString   (.flags o)
      , encoding = T.unsafeToNameE (.encoding o) }

type alias ReadFileOptions =
  { flags    : Flags
  , encoding : Encoding }

type alias ReadFileOptionsRaw =
  { flags    : String
  , encoding : String }

defaultReadFileOptions : ReadFileOptions
defaultReadFileOptions =
  { flags    = R
  , encoding = T.Binary}

marshallReadFileOptions : ReadFileOptions -> ReadFileOptionsRaw
marshallReadFileOptions o =
  { o | flags    = flagsToString   (.flags o)
      , encoding = T.unsafeToNameE (.encoding o) }

type alias WriteOptions =
  { flags           : Flags
  , defaultEncoding : Encoding
  , mode            : Mode }

type alias WriteOptionsRaw =
  { flags           : String
  , defaultEncoding : String
  , mode            : Mode }

defaultWriteOptions : WriteOptions
defaultWriteOptions =
  { flags           = W
  , mode            = 438 -- 0o666
  , defaultEncoding = T.Binary }

marshallWriteOptions : WriteOptions -> WriteOptionsRaw
marshallWriteOptions o =
  { o | flags           = flagsToString   (.flags o)
      , defaultEncoding = T.unsafeToNameE (.defaultEncoding o) }

type alias AppendOptions =
  { flags    : Flags
  , encoding : Encoding
  , mode     : Mode }

type alias AppendOptionsRaw =
  { flags    : String
  , encoding : String
  , mode     : Mode }

defaultAppendOptions : AppendOptions
defaultAppendOptions =
  { flags    = A
  , mode     = 438 -- 0o666
  , encoding = T.Binary }

marshallAppendOptions : AppendOptions -> AppendOptionsRaw
marshallAppendOptions o =
  { o | flags    = flagsToString   (.flags o)
      , encoding = T.unsafeToNameE (.encoding o) }

type alias Stats =
  { dev       : Int
  , mode      : Int
  , nlink     : Int
  , uid       : Int
  , gid       : Int
  , rdev      : Int
  , blksize   : Int
  , ino       : Int
  , size      : Int
  , blocks    : Int
  , atime     : String
  , mtime     : String
  , ctime     : String
  , birthtime : String }

type SymType
  = File
  | Dir
  | Junction

symTypeToString : SymType -> String
symTypeToString t =
  case t of
    File -> "file"
    Dir -> "dir"
    Junction -> "junction"

type alias WatchOptions =
  { persistent : Bool
  , recursive  : Bool }

defaultWatchOptions : WatchOptions
defaultWatchOptions =
  { persistent = True
  , recursive  = False }

type FSWatcher = FSWatcher

type WatchEvent
  = Update
  | WatchError

watchEventFromString : String -> Maybe WatchEvent
watchEventFromString s = case s of
  "update" -> Just Update
  "error"  -> Just WatchError
  _ -> Nothing
