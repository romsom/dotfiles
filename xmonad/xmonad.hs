import XMonad
import XMonad.Hooks.DynamicLog
import qualified XMonad.StackSet as W

import XMonad.Util.EZConfig -- for keybindings

-- The main function.
main = xmonad =<< (statusBar myBar myPP toggleStrutsKey $ myKeybindings myConfig)

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
-- Print runtime information from xmonad (e.g. workspace)
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = def
       { terminal   = "termite"
       , modMask    = mod4Mask
       -- workspaces
       , workspaces = ["1:term", "2:edit", "3:web", "4:mail", "5:games"] ++ map show [6 .. 7 :: Int] ++ ["8:media_players", "9:audio_controls"]
       , manageHook = myManageHook <+> manageHook def -- uses default to
       , normalBorderColor = "#000000"
       , focusedBorderColor = "#002F00"
       , borderWidth = 1
       }

myKeybindings = \c -> additionalKeysP c $
  [ ("M-S-s", spawn "i3lock && systemctl suspend")
  , ("M-S-l", spawn "i3lock -d -I5 ")
  ]

-- manage workspaces
myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [ [ className   =? c                 --> doFloat | c <- myFloatsByClass]
    , [ title       =? t                 --> doFloat | t <- myFloatsByTitle]
    , [ resource    =? r                 --> doIgnore | r <- myIgnores]
    , [ className   =? g                 --> doShift "5:games" | g <- myGames]
    , [ className   =? a                 --> doShift "9:audio_controls" | a <- myAudio_Controls]
    , [ className   =? m                 --> doShift "8:media_players" | m <- myMedia_Players]
    , [ title       =? "term-main"       --> doShift "1:term" ]
    , [ title       =? "emacs-main"      --> doShift "2:edit" ]
    , [ className   =? "Firefox"         --> doShift "3:web" ]
    , [ className   =? "firefox"         --> doShift "3:web" ]
    , [ className   =? "term-mutt"       --> doShift "4:mail" ]
    ]
    where
        myIgnores       = ["panel", "stalonetray", "trayer"] -- sticky, respect geometry
        myFloatsByClass = [ "feh", "GIMP", "gimp", "gimp-2.4", "kcalc"
                          , "qemu", "qemu-system-aarch64"
                          , "scummvm", "MediathekView", "Zenity"
                          , "residualvm", "xpra"
                          ] -- xprop WM_CLASS
        myFloatsByTitle = [] 
        myGames = ["Steam", "Lutris", "Gamehub", "multimc", "MultiMC5"]
        myAudio_Controls = ["qjackctl", "QjackCtl", "pavucontrol", "Pavucontrol"]
        myMedia_Players = ["Deadbeef", "deadbeef", "vlc"]
