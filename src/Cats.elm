import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode

main : Program Never Model Msg
main =
  Html.program 
  { init = init "Cats ad infinitum"
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- MODEL

type alias Model =
  { topic : String
  , gifUrl : String
  }

init: String -> (Model, Cmd Msg)
init topic =
  ( Model topic "#"
  , getRandomGif "cute+cats"
  )

-- UPDATE

type Msg
  = NewGif (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    NewGif (Ok newUrl) ->
      ( { model | gifUrl = newUrl }, Cmd.none)

    NewGif (Err _) ->
      (model, Cmd.none)

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "https://api.giphy.com/v1/gifs/random?api_key=RAVCL8pFf1O5H3OuHZZxii0B3PFkU6u2&tag=" ++ topic

    request =
      Http.get url decodeGifUrl

  in
    Http.send NewGif request

decodeGifUrl : Decode.Decoder String
decodeGifUrl =
  Decode.at ["data", "image_url"] Decode.string

-- VIEW

view : Model -> Html Msg
view model =
  div [class "center-wrapper"]
    [ h1 [] [ text model.topic ]
    , img [ src model.gifUrl ] [] ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
