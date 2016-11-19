module Info exposing (Msg, Model, init, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Stylesheet exposing (..)

type Msg =
  Noop 

type alias DemoModel =
  { name: String, link: String }

type alias IndexedDemoModel =
  (Int, DemoModel)

type alias Model =
  { title: String
  , descr: String
  , demos: List IndexedDemoModel
  , selectedDeno: Int
  }

init : (Model, Cmd Msg)
init =
  ( Model "A Component" "Some great stuff here" (generateDemos 5) 0
  , Cmd.none
  )

generateDemos : Int -> List (Int, DemoModel)
generateDemos n =
  let
    demoLink = \x -> "http://example.com/demo" ++ (toString x) ++ ".html"
    demoName = \x -> "Demo " ++ toString x
  in
    List.map (\x -> (x, DemoModel (demoName x) (demoLink x))) (List.range 1 n)

renderDemoLink : Styles -> IndexedDemoModel -> Html Msg
renderDemoLink styles (idx, {name, link}) =
  li [ getStyle "demoLinksListItem" styles ] [
    a [href link] [text name]
  ]


view : Styles -> Model -> Html Msg
view stylesheet {title, descr, demos} =
  let
    sectionStyle = getStyle "infoSection" stylesheet
    titleStyle = getStyle "titleSection" stylesheet
    descrStyle = getStyle "descriptionSection" stylesheet
    demoLinksStyle = getStyle "demoLinksSection" stylesheet
    demoLinksListStyle = getStyle "demoLinksList" stylesheet
  in   
    div [ sectionStyle ] [
      section [ titleStyle ] [
        h1 [] [text title]
      ],
      section [ descrStyle ] [text descr],
      section [ demoLinksStyle ] [
          ul [ demoLinksListStyle ] (List.map (renderDemoLink stylesheet) demos)
      ]
    ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Noop -> (model, Cmd.none)
