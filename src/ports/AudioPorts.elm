port module AudioPorts exposing (playNote, requestLoadSoundFont)


port requestLoadSoundFont : String -> Cmd msg


port playNote : String -> Cmd msg
