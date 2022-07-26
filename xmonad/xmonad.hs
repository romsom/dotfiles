import XMonad
import XMonad.Hooks.DynamicLog
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Util.EZConfig(additionalKeysP) -- for keybindings
import XMonad.Hooks.EwmhDesktops(ewmh) -- fullscreen applications (e.g., sdl2 games)
-- import XMonad.Hooks.EwmhDesktops(fullscreenEventHook,ewmh) -- is fullscreenEventHook necessary?
import XMonad.Actions.PhysicalScreens(viewScreen,sendToScreen) -- use correct ordering of screens

-- The main function.
main = xmonad =<< (statusBar myBar myPP toggleStrutsKey $ ewmh $ myKeybindings myConfig)

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
  -- rebind screen selection keys to use PhysicalScreens
  , ("M-w", viewScreen def 0)
  , ("M-e", viewScreen def 1)
  , ("M-r", viewScreen def 2)
  , ("M-S-w", sendToScreen def 0)
  , ("M-S-e", sendToScreen def 1)
  , ("M-S-r", sendToScreen def 2)
  ]

-- reference for PhysicalScreens from https://xiangji.me/2018/11/19/my-xmonad-configuration/#xmonadactionsphysicalscreens
-- physicalScreenKeys = [((modm .|. mask, key), f sc)
--     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
--     , (f, mask) <- [(viewScreen def, 0), (sendToScreen def, shiftMask)]]

-- manage workspaces
myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [ [ isFullscreen --> doFullFloat]
    , [ className   =? c                 --> doFloat | c <- myFloatsByClass]
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
                          , "residualvm", "xpra", "Projucer"
                          ] -- xprop WM_CLASS
        myFloatsByTitle = [] 
        myGames = ["Steam", "Lutris", "Gamehub", "multimc", "MultiMC5"]
        myAudio_Controls = ["qjackctl", "QjackCtl", "pavucontrol", "Pavucontrol"]
        myMedia_Players = ["Deadbeef", "deadbeef", "vlc"]
