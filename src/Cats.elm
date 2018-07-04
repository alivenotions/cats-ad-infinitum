import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)

main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model = String

model : Model
model =
  "Hello World!"

-- UPDATE

type Msg = HelloToBD

update : Msg -> Model -> Model
update msg model =
  case msg of
    HelloToBD ->
      model ++ " BD"

-- VIEW

view : Model -> Html Msg
view model =
  div [id "wrapper"]
    [ button [onClick HelloToBD] [text "SayHello"]
    , text model ]
