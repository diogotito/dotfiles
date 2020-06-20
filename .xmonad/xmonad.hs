{-# LANGUAGE NoMonomorphismRestriction #-}
import XMonad
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.GridSelect as GS
import XMonad.Actions.Launcher
import XMonad.Actions.TreeSelect
import XMonad.Actions.WindowBringer
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.WorkspaceHistory
import XMonad.Layout.ButtonDecoration
import XMonad.Layout.CenteredMaster
import XMonad.Layout.Circle
import XMonad.Layout.DecorationAddons
import XMonad.Layout.DecorationMadness
import XMonad.Layout.Grid
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowArranger
import XMonad.Layout.Fullscreen
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt (confirmPrompt)
import XMonad.Prompt.Theme
import XMonad.Prompt.XMonad (xmonadPrompt)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.Themes
import XMonad.Util.Ungrab
import qualified XMonad.StackSet as W
import System.Exit (exitWith, ExitCode ( ExitSuccess ) )
import Data.Tree
import Data.Tuple (swap)
import Data.Map as M


-- I want pipes in my Haskell!!!
(|>) :: a -> (a -> b) -> b
(|>) = flip ($)


-- Apps
myBrowser = "firefox"
myTerminal = "xfce4-terminal"


-- Colors
myNormalBorder = "#272A33"
myFocusedBorder =  "#5294E2"
myForegroundActiveColor = "#EEEEFF"
myForegroundInactiveColor = "#CCCCCC"

myStartup = do
    spawnOnce "xfce4-panel"
    -- spawnOnce "stalonetray"
    -- spawnOnce "xmobar"
    spawnOnce "autorandr quarto"
    spawnOnce "xfce4-volumed-pulse"
    spawnOnce "xfce4-power-manager"
    spawnOnce "xfce4-clipman"
    spawnOnce "picom"
    spawnOnce "setxkbmap -option grp:lctrl_lwin_rctrl_menu"
    spawnOnce "redshift-gtk"
    spawnOnce "/home/diogo/bin/fucking-razer.sh"
    spawnOnce "sleep 1s && /home/diogo/.fehbg"
    spawnOnce "evrouter /dev/input/by-id/usb-Razer_Razer_*"


myKeys :: [(String, X ())]
myKeys =
    [ ("M-S-b", spawn myBrowser)
    , ("M-<Return>", spawn myTerminal)
    , ("M-S-<Return>", spawn myTerminal)
    , ("M-S-t", spawn "telegram-desktop")
    , ("M-S-v", themePrompt def)
    , ("M-S-f", spawn "nautilus")
    , ("M-f"  , spawn "thunar")
    , ("M-p", spawn "darkblue xfce4-appfinder-category.sh 'All Applications'")
    , ("M-S-p", spawn "dmenu_run")
    , ("M-g b", bringSelected def)
    , ("M-g g", goToSelected def)
    , ("M-g w", gridselectWorkspace def W.greedyView)
    , ("M-g s", spawnSelected def $ words "gvim emacs subl code gedit")
    , ("M-g m", gotoMenu)
    , ("M-g r", spawn "rofi -sidebar-mode -show window")
    , ("M-g e", exitGrid)
    , ("M-g c", spawn "darkblue gvim ~/.xmonad/xmonad.hs")
    , ("M-S-x", xmonadPrompt def)
    , ("M1-<Tab>", workspaceHistory >>= \(_:l:_) -> windows (W.view l))
    , ("M-S-q", exitGrid)
    , ("M-u",   sendMessage ShrinkSlave)
    , ("M-i",   sendMessage ExpandSlave)
    ]
    where
        confirmExit = confirmPrompt
                        def { position = CenteredAt 0.5 0.5
                            , height = 100
                            , font = "xft:Hack:pixelsize=30"
                            , borderColor = "red"
                            , promptBorderWidth = 10
                            }
                        "Quit XMonad?" $
                            io (exitWith ExitSuccess)


        exitGrid = runSelectedAction cfg [ ("Lock (fancy)"     , fancyLock)
                                         , ("Quit XMonad"      , confirmExit)
                                         , ("Lock (lightdm)"   , spawn "dm-tool lock")
                                         , ("Shut down"        , spawn "systemctl poweroff")
                                         , ("Suspend"          , spawn "systemctl suspend")
                                         , ("Reboot"           , spawn "systemctl reboot")
                                         , ("Hibernate"        , fancyHibernate)
                                         , ("Reboot to Windows", winBoot)
                                         ]
          where
            cfg = def { gs_cellheight = 50, gs_cellwidth = 200, gs_colorizer = colorizer, gs_navigate = myNavigation, gs_font = "xft:Source Code Sans 12", gs_bordercolor = myFocusedBorder }
            colorizer _ True  = return (myFocusedBorder, myForegroundActiveColor)
            colorizer _ False = return (myNormalBorder, myForegroundInactiveColor)
            myNavigation :: TwoD a (Maybe a)
            myNavigation = makeXEventhandler $ shadowWithKeymap navKeyMap navDefaultHandler
             where navKeyMap = M.fromList [
                      ((0,xK_r)     , setPos (0,2) >> myNavigation)
                     ,((0,xK_w)     , setPos (2,0) >> myNavigation)
                     ,((0,xK_q)     , setPos (0,1) >> myNavigation)
                     ,((shiftMask,xK_Q), setPos (0,1) >> myNavigation)
                     ,((mod4Mask,xK_q), setPos (0,1) >> myNavigation)
                     ,((shiftMask .|. mod4Mask,xK_Q), setPos (0,1) >> myNavigation)
                     ,((0,xK_s)     , setPos (-1,0) >> myNavigation)
                     ,((0,xK_Escape), GS.cancel)
                     ,((0,xK_Return), GS.select)
                     ,((0,xK_slash) , substringSearch myNavigation)
                     ,((0,xK_Left)  , move (-1,0)  >> myNavigation)
                     ,((0,xK_h)     , move (-1,0)  >> myNavigation)
                     ,((0,xK_Right) , move (1,0)   >> myNavigation)
                     ,((0,xK_l)     , move (1,0)   >> myNavigation)
                     ,((0,xK_Down)  , move (0,1)   >> myNavigation)
                     ,((0,xK_j)     , move (0,1)   >> myNavigation)
                     ,((0,xK_Up)    , move (0,-1)  >> myNavigation)
                     ,((0,xK_k)     , move (0,-1)  >> myNavigation)
                     ,((0,xK_y)     , move (-1,-1) >> myNavigation)
                     ,((0,xK_i)     , move (1,-1)  >> myNavigation)
                     ,((0,xK_n)     , move (-1,1)  >> myNavigation)
                     ,((0,xK_m)     , move (1,1)  >> myNavigation)
                     ,((0,xK_space) , setPos (0,0) >> myNavigation)
                     ]
                   -- The navigation handler ignores unknown key symbols
                   navDefaultHandler = const GS.defaultNavigation

            

        fancyLock = do
            unGrab
            spawn $ unwords [ "i3lock"
                            , "--blur 5"
                            , "--indicator --clock"
                            , "--timecolor=1793D1ff"
                            , "--datecolor=1793D1ff"
                            ]

        fancyHibernate = do
            fancyLock
            spawn "systemctl hibernate"

        winBoot = do
            unGrab
            spawn "gksu 'efibootmgr --bootnext=0' && systemctl reboot"


myLayout =
    (lessBorders Screen) mouseResizableTile |||
    (lessBorders Screen) mouseResizableTile { isMirrored = True } |||
    centerMaster Grid |||
    buttonDeco shrinkText defaultThemeWithButtons floatSimpleSimple |||
    noBorders (tabbed shrinkText (theme adwaitaDarkTheme))


myManageHook = composeAll
                 [ className =? "Xfce4-appfinder"   --> doFloat
                 ]


main = desktopConfig
        { logHook = workspaceHistoryHook <+> dynamicLog
        , startupHook = myStartup
        , layoutHook = myLayout
        , manageHook = myManageHook <+> manageHook desktopConfig

        , modMask = mod4Mask
        , terminal = "xfce4-terminal"
        , borderWidth = 4
        , normalBorderColor = myNormalBorder
        , focusedBorderColor = myFocusedBorder
        }

    |> fullscreenSupport
    |> (`additionalKeysP` myKeys)
    |> xmobar

    >>= xmonad


-- Things to do
--
--  GRID SELECT
--      Menu "logout" - Agora quero criar keybindings lá
--      Apps preferidas
--
--  Tray icons
--      pasystray
--      nm-applet
--      redshift-gtk
--      xfce4-clipman
--      xfce4-power-manager
--      polychromatic-tray-icon
--      birdtray
--      xxkb
--
--  Keybindings
--      Launch apps:
--          <PrtSc>   xfce4-screenshot?
--          <M-Tab>   rofi -sidebar-mode -show window
--
--  Other stuff to configure
--      xmobar
--
--  Misc WM stuff
--      Proper EWMH fullscreen handling -- Only Firefox doesn't work

-- Copy-pasted notes:
--     desktopConfig is an XConfig that configures xmonad to ignore and
-- leave room for dock type windows like panels and trays, adds the
-- default key binding to toggle panel visibility, and activates basic
-- EWMH support. It also sets a prettier root window mouse pointer.
