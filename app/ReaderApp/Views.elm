module ReaderApp.Views exposing (mainApplicationView)

import Html exposing (Html, div, span, a, input, text, img, label, button, br)
import Html.Attributes exposing (id, class, for, src, href, type', checked)
import Html.Events exposing (onClick)

import Routing
import ReaderApp.Models exposing (Model, Banner)
import ReaderApp.Messages exposing (..)
import ReaderApp.NarrationView
import ReaderApp.Views.Banner

notFoundView : Html Msg
notFoundView =
  div []
    [ div [] [ text "404 Not Found" ]
    ]

loadingView : Maybe Banner -> Html Msg
loadingView maybeBanner =
  div [ id "loader" ]
    [ div [ id "spinner" ] [ text "Loading…" ]
    , case maybeBanner of
        Just banner ->
          ReaderApp.Views.Banner.view banner
        Nothing ->
          text ""
    ]

loadedView : Model -> Html Msg
loadedView model =
  div [ id "loader" ]
    [ div [ id "start-ui" ]
        [ button [ onClick StartNarration ]
            [ text "Start" ]
        , br [] []
        , input
            [ id "music"
            , type' "checkbox"
            , checked model.backgroundMusic
            , onClick ToggleBackgroundMusic
            ]
            []
        , label [ for "music" ] [ text "Background music" ]
        ]
    ]

validView : Model -> Html Msg
validView model =
  div []
    [ case model.state of
        ReaderApp.Models.Loader ->
          case model.chapter of
            Just data ->
              loadedView model
            Nothing ->
              loadingView model.banner
        _ ->
          text ""
    , ReaderApp.NarrationView.view model
    ]

mainApplicationView : Model -> Html Msg
mainApplicationView model =
  case model.route of
    Routing.ChapterPage chapterId characterToken ->
      validView model
    Routing.NotFoundRoute ->
      notFoundView