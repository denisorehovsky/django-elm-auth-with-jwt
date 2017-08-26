module Data.Token exposing
  ( Token(..)
  , tokenToString
  , decoder
  , encode
  , storeToken
  , decodeTokenFromStore
  )

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)

import Ports


type Token
  = Token String


tokenToString : Token -> String
tokenToString (Token token) =
  token


decoder : Decoder Token
decoder =
  Decode.map Token Decode.string


encode : Token -> Value
encode (Token token) =
  Encode.string token


-- STORAGE


storeToken : Token -> Cmd msg
storeToken token =
  encode token
    |> Encode.encode 0
    |> Just
    |> Ports.storeToken


decodeTokenFromStore : Value -> Maybe Token
decodeTokenFromStore json =
  json
    |> Decode.decodeValue Decode.string
    |> Result.toMaybe
    |> Maybe.andThen (Decode.decodeString decoder >> Result.toMaybe)
