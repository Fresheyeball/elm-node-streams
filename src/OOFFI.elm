module OOFFI where

import Task exposing (Task)
import Native.OOFFI

method0 : String -> object -> Task x ()
method0 = Native.OOFFI.method0

method1 : String -> object -> a -> Task x ()
method1 = Native.OOFFI.method1

method2 : String -> object -> a -> b -> Task x ()
method2 = Native.OOFFI.method2

method3 : String -> object -> a -> b -> c -> Task x ()
method3 = Native.OOFFI.method3

method4 : String -> object -> a -> b -> c -> d -> Task x ()
method4 = Native.OOFFI.method4

method5 : String -> object -> a -> b -> c -> d -> e -> Task x ()
method5 = Native.OOFFI.method5

method6 : String -> object -> a -> b -> c -> d -> e -> f -> Task x ()
method6 = Native.OOFFI.method6

method7 : String -> object -> a -> b -> c -> d -> e -> f -> g -> Task x ()
method7 = Native.OOFFI.method7

methodAsync0 : String -> object -> Task x ()
methodAsync0 = Native.OOFFI.methodAsync0

methodAsync1 : String -> object -> a -> Task x ()
methodAsync1 = Native.OOFFI.methodAsync1

methodAsync2 : String -> object -> a -> b -> Task x ()
methodAsync2 = Native.OOFFI.methodAsync2

methodAsync3 : String -> object -> a -> b -> c -> Task x ()
methodAsync3 = Native.OOFFI.methodAsync3

methodAsync4 : String -> object -> a -> b -> c -> d -> Task x ()
methodAsync4 = Native.OOFFI.methodAsync4

methodAsync5 : String -> object -> a -> b -> c -> d -> e -> Task x ()
methodAsync5 = Native.OOFFI.methodAsync5

methodAsync6 : String -> object -> a -> b -> c -> d -> e -> f -> Task x ()
methodAsync6 = Native.OOFFI.methodAsync6

methodAsync7 : String -> object -> a -> b -> c -> d -> e -> f -> g -> Task x ()
methodAsync7 = Native.OOFFI.methodAsync7

get0 : String -> object -> Task x a
get0 = Native.OOFFI.get0

get1 : String -> object -> a -> Task x b
get1 = Native.OOFFI.get1

get2 : String -> object -> a -> b -> Task x c
get2 = Native.OOFFI.get2

get3 : String -> object -> a -> b -> c -> Task x d
get3 = Native.OOFFI.get3

get4 : String -> object -> a -> b -> c -> d -> Task x e
get4 = Native.OOFFI.get4

get5 : String -> object -> a -> b -> c -> d -> e -> Task x f
get5 = Native.OOFFI.get5

get6 : String -> object -> a -> b -> c -> d -> e -> f -> Task x g
get6 = Native.OOFFI.get6

get7 : String -> object -> a -> b -> c -> d -> e -> f -> g -> Task x h
get7 = Native.OOFFI.get7

unsafeNull : a
unsafeNull = Native.OOFFI.unsafeNull

unsafeRequire : String -> a
unsafeRequire = Native.OOFFI.unsafeRequire
