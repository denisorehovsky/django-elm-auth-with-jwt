module Components.Login exposing
  ( Model
  , initialModel
  , Msg
  , ExternalMsg(..)
  , update
  , view
  )

import Html exposing (..)
import Html.Attributes exposing (class, placeholder, type_)
import Html.Events exposing (onInput, onSubmit)
import Http

import Data.Token as Token exposing (Token)
import Request.Token


-- MODEL


type alias Model =
  { username : String
  , password : String
  }


initialModel : Model
initialModel =
  { username = ""
  , password = ""
  }


-- MESSAGES


type Msg
  = SubmitForm
  | SetUsername String
  | SetPassword String
  | TokenObtained (Result Http.Error Token)


type ExternalMsg
  = NoOp
  | SetToken Token



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg, ExternalMsg )
update msg model =
  case msg of
    SubmitForm ->
      ( model
      , Http.send TokenObtained (Request.Token.obtain model)
      , NoOp
      )

    SetUsername username ->
      ( { model | username = username }, Cmd.none, NoOp )

    SetPassword password ->
      ( { model | password = password }, Cmd.none, NoOp )

    TokenObtained (Ok token) ->
      ( model
      , Token.storeToken token
      , SetToken token
      )

    TokenObtained (Err err) ->
      ( model, Cmd.none, NoOp )



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [ class "title has-text-centered" ] [ text "Log in" ]
    , viewSignInForm
    ]


viewSignInForm : Html Msg
viewSignInForm =
  Html.form [ onSubmit SubmitForm ]
    [ div [ class "field" ]
      [ label [ class "label" ]
        [ text "Username" ]
      , div [ class "control has-icons-left has-icons-right" ]
        [ input
          [ onInput SetUsername
          , class "input"
          , placeholder "Username"
          , type_ "text"
          ]
          []
        , span [ class "icon is-small is-left" ]
          [ i [ class "fa fa-user" ]
            []
          ]
        ]
      ]
    , div [ class "field" ]
      [ label [ class "label" ]
        [ text "Password" ]
      , div [ class "control has-icons-left has-icons-right" ]
        [ input
          [ onInput SetPassword
          , class "input"
          , placeholder "Password"
          , type_ "password"
          ]
          []
        , span [ class "icon is-small is-left" ]
          [ i [ class "fa fa-lock" ]
            []
          ]
        ]
      ]
    , div [ class "control" ]
      [ button [ class "button is-primary" ]
        [ text "Submit" ]
      ]
    ]
