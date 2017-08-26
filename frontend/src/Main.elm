module Main exposing (..)

import Json.Encode as Encode exposing (Value)

import Html exposing (Html, section, div, button, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)

import Components.Login as Login
import Components.Wrapper exposing (wrapper)
import Data.Token as Token exposing (Token)
import Ports


main : Program Value Model Msg
main =
  Html.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }



-- MODEL


type alias Model =
  { token : Maybe Token
  , loginModel : Login.Model
  }


initialModel : Maybe Token -> Model
initialModel token =
  { token = token
  , loginModel = Login.initialModel
  }


init : Value -> ( Model, Cmd Msg )
init value =
  ( initialModel (Token.decodeTokenFromStore value), Cmd.none )



-- MESSAGES


type Msg
  = NoOp
  | LoginMsg Login.Msg
  | Logout



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )

    LoginMsg subMsg ->
      let
        ( newLoginModel, cmdFromLogin, msgFromLogin ) =
          Login.update subMsg model.loginModel

        newModel =
          case msgFromLogin of
            Login.NoOp ->
              model

            Login.SetToken token ->
              { model | token = Just token }
      in
        ( { newModel | loginModel = newLoginModel }
        , Cmd.map LoginMsg cmdFromLogin
        )

    Logout ->
      ( initialModel Nothing, Ports.storeToken Nothing )



-- VIEW


view : Model -> Html Msg
view model =
  case model.token of
    Nothing ->
      Login.view model.loginModel
        |> Html.map LoginMsg
        |> wrapper

    Just token ->
      viewGreeting token
        |> wrapper


viewGreeting : Token -> Html Msg
viewGreeting token =
  div []
    [ div [ class "notification is-success", style [("word-wrap", "break-word")] ]
      [ text ( "You have been successfully logged in. Your token: " ++ (Token.tokenToString token) ) ]
    , button [ onClick Logout, class "button is-primary" ]
      [ text "Logout" ]
    ]
