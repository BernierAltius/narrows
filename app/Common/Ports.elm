port module Common.Ports exposing (..)

import Json.Decode
import Common.Models exposing (FullCharacter)


type alias RenderTextInfo =
    { elemId : String
    , text : Json.Decode.Value
    , proseMirrorType : String
    }


type alias InitEditorInfo =
    { elemId : String
    , narrationId : Int
    , narrationImages : List String
    , chapterParticipants : List FullCharacter
    , text : Json.Decode.Value
    , editorType : String
    , updatePortName : String
    }


type alias NarrationMediaInfo =
    { audioElemId : String
    }


type alias FileUploadInfo =
    { type_ : String
    , portType : String
    , fileInputId : String
    , narrationId : Int
    }


port renderText : RenderTextInfo -> Cmd msg
port initEditor : InitEditorInfo -> Cmd msg
port startNarration : NarrationMediaInfo -> Cmd msg
port playPauseNarrationMusic : NarrationMediaInfo -> Cmd msg
port playNarrationMusic : NarrationMediaInfo -> Cmd msg
port pauseNarrationMusic : NarrationMediaInfo -> Cmd msg
port flashElement : String -> Cmd msg

port pageScrollListener : (Int -> msg) -> Sub msg
port markNarrationAsStarted : (Int -> msg) -> Sub msg


port openFileInput : String -> Cmd msg
port uploadFile : FileUploadInfo -> Cmd msg
