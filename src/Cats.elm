import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode
import Time exposing (..)

main : Program Never Model Msg
main =
  Html.program 
  { init = init "Cats ad infinitum" "cute+cats"
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- MODEL

type alias Model =
  { heading : String
  , gifUrl : String
  , topic : String
  }

init: String -> String -> (Model, Cmd Msg)
init heading topic =
  ( Model heading "#" topic
  , getRandomGif topic
  )

-- UPDATE

type Msg
  = NewGif (Result Http.Error String)
  | UpdateGif Time

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    NewGif (Ok newUrl) ->
      ( { model | gifUrl = newUrl }, Cmd.none)

    NewGif (Err _) ->
      (model, Cmd.none)

    UpdateGif _ ->
      (model, Cmd.batch [getRandomGif (.topic model)])

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
    [ h1 [] [ text model.heading ]
    , img [ src model.gifUrl ] [] ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every (5 * Time.second) UpdateGif
