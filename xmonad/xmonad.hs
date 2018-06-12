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
       , workspaces = ["1:term", "2:edit", "3:web", "4:mail"] ++ map show [5 .. 9 :: Int]
       , manageHook = myManageHook <+> manageHook def -- uses default to
       }

myKeybindings = \c -> additionalKeysP c $
  [ ("M-S-s", spawn "i3lock && systemctl suspend")
  ]

-- manage workspaces
myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [ [ className   =? c                 --> doFloat | c <- myFloatsByClass]
    , [ title       =? t                 --> doFloat | t <- myFloatsByTitle]
    , [ resource    =? r                 --> doIgnore | r <- myIgnores]
    , [ className   =? "termite-main"    --> doShift "1:term" ]
    , [ title       =? "emacs-main"      --> doShift "2:edit" ]
    , [ className   =? "Firefox"         --> doShift "3:web" ]
    , [ className   =? "termite-mutt"    --> doShift "4:mail" ]
    ]
    where
        myIgnores       = ["panel", "stalonetray", "trayer"] -- sticky, respect geometry
        myFloatsByClass = ["feh", "GIMP", "gimp", "gimp-2.4", "kcalc", "qemu", "scummvm"] -- xprop WM_CLASS
        myFloatsByTitle = [] 
