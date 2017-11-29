import XMonad
import XMonad.Hooks.DynamicLog
import qualified XMonad.StackSet as W

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = def
       { terminal = "termite"
       , modMask  = mod4Mask
       -- desktops
       , workspaces = ["1:term", "2:edit", "3:web", "4:mail"] ++ map show [5 .. 9 :: Int]
       }

-- manage workspaces
myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [ [ className   =? c                 --> doFloat | c <- myFloatsByClass]
    , [ title       =? t                 --> doFloat | t <- myFloatsByTitle]
    , [ resource    =? r                 --> doIgnore | r <- myIgnores]
    , [ className   =? "Firefox-bin"     --> doF (W.shift "3:web") ]
    , [ className   =? "emacs"           --> doF (W.shift "2:edit") ]
    , [ className   =? "termite-mutt" --> doF (W.shift "4:mail") ]
    , [ className   =? "termite-main" --> doF (W.shift "1:term") ]
    ]
    where
        myIgnores       = ["panel", "stalonetray", "trayer"] -- sticky, respect geometry
        myFloatsByClass = ["feh", "GIMP", "gimp", "gimp-2.4", "kcalc", "qemu"] -- xprop WM_CLASS
        myFloatsByTitle = [] 
