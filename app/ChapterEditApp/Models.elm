module ChapterEditApp.Models exposing (..)

import Json.Encode
import Json.Decode
import Common.Models exposing (FullCharacter, Character, Narration, Chapter, Banner, MessageThread)


newEmptyChapter : Narration -> Chapter
newEmptyChapter narration =
    { id = 0
    , narrationId = narration.id
    , title = ""
    , audio = narration.defaultAudio
    , backgroundImage = narration.defaultBackgroundImage
    , text = Json.Encode.object [ ("type", Json.Encode.string "doc")
                                , ("content", Json.Encode.list [])
                                ]
    , participants = narration.characters
    , published = Nothing
    }


type alias LastChapter =
    { id : Int
    , title : String
    , text : Json.Decode.Value
    , participants : List Character
    , messageThreads : List MessageThread
    }


type alias LastReactionsResponse =
    { lastChapters : List LastChapter
    }


type alias Model =
    { chapter : Maybe Chapter
    , narration : Maybe Narration
    , lastChapters : Maybe (List LastChapter)
    , banner : Maybe Banner
    , flash : Maybe Banner
    , showPublishChapterDialog : Bool
    , savingChapter : Bool
    , uploadingAudio : Bool
    , uploadingBackgroundImage : Bool
    }
