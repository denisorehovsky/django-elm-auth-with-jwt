module Components.Wrapper exposing (wrapper)

import Html exposing (Html, div, section, text)
import Html.Attributes exposing (class)


-- VIEW


wrapper : Html msg -> Html msg
wrapper content =
  section [ class "section" ]
    [ div [ class "container" ]
      [ div [ class "columns" ]
        [ div [ class "column is-one-third" ]
          []
        , div [ class "column is-one-third" ]
          [ content ]
        , div [ class "column is-one-third" ]
          []
        ]
      ]
    ]
