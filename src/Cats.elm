import Html exposing (..)
import Html.Attributes exposing (..)

main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model = String

model : Model
model =
  "Cats ad infinitum"

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
  div [class "center-wrapper"]
    [ h1 [] [ text model ]
    , img [ src "#" ] [] ]
