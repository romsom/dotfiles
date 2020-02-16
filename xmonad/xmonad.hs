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
       { -- terminal   = "urxvt +sb -rv"
	 terminal = "termite --class 'termite-aux'"
       , modMask    = mod4Mask
       -- workspaces
       , workspaces = ["1:term", "2:edit", "3:qjackctl", "4:ardour", "5:setbfree", "6:guitarix"] ++ map show [7,8] ++ ["9:web"]
       , manageHook = myManageHook <+> manageHook def -- uses default to
       }

myKeybindings = \c -> additionalKeysP c $
  [ ("M-S-s", spawn "i3lock && systemctl suspend")
  , ("M-S-l", spawn "i3lock -d -I5 ")
  , ("M-S-h p", spawn "systemctl poweroff")
  , ("M-S-h r", spawn "systemctl reboot")
  , ("M-S-p a", spawn "ardour5")
  , ("M-S-p p", spawn "pavucontrol")
  , ("M-S-p c", spawn "carla")
  , ("M-S-p q", spawn "qjackctl")
  , ("M-S-p d", spawn "deadbeef")
  ]

-- manage workspaces
myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [ [ className   =? c                 --> doFloat | c <- myFloatsByClass]
    , [ title       =? t                 --> doFloat | t <- myFloatsByTitle]
    , [ resource    =? r                 --> doIgnore | r <- myIgnores]
    , [ title       =? "term-main"       --> doShift "1:term" ]
    , [ title       =? "emacs-main"      --> doShift "2:edit" ]
    , [ className   =? "qjackctl"        --> doShift "3:qjackctl" ]
    , [ className   =? "QjackCtl"        --> doShift "3:qjackctl" ]
    , [ className   =? "Pavucontrol"        --> doShift "3:qjackctl" ]
    , [ className   =? "ardour.*"         --> doShift "4:ardour" ]
    , [ title       =? "setBfree"        --> doShift "5:setbfree" ]
    , [ className   =? "Guitarix"        --> doShift "6:guitarix" ]
    , [ className   =? "Firefox"         --> doShift "9:web" ]
    ]
    where
        myIgnores       = ["panel", "stalonetray", "trayer"] -- sticky, respect geometry
        myFloatsByClass = [ "feh", "GIMP", "gimp", "gimp-2.4", "kcalc"
                          , "qemu", "qemu-system-aarch64"
                          , "scummvm"
                          ] -- xprop WM_CLASS
        myFloatsByTitle = [] 
