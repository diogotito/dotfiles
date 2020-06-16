import XMonad
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.GridSelect
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
import XMonad.Layout.NoBorders ( noBorders, smartBorders )
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowArranger
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


-- Apps
myBrowser = "firefox"
myTerminal = "xfce4-terminal"


myStartup = do
    spawnOnce "xmobar"
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
    , ("M-S-t", spawn "telegram-desktop")
    , ("M-S-v", themePrompt def)
    , ("M-S-f", spawn "nautilus")
    , ("M-f"  , spawn "thunar")
    , ("M-S-p", spawn "xfce4-appfinder")
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
    , ("M-S-q", confirmExit)
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

        exitGrid = runSelectedAction def [ ("Quit XMonad"    , confirmExit)
                                         , ("Lock (fancy)"   , spawn fancyLockCmd)
                                         , ("Lock (lightdm)" , spawn "dm-tool lock")
                                         , ("Shut down"      , spawn "systemctl poweroff")
                                         , ("Suspend"        , spawn "systemctl suspend")
                                         , ("Reboot"         , spawn "systemctl reboot")
                                         , ("Hibernate"      , fancyHibernate)
                                         , ("Reboot to Windows", winBoot)
                                         ]

        fancyLockCmd = unwords [ "i3lock"
                               , "--blur 5"
                               , "--indicator --clock"
                               , "--timecolor=1793D1ff"
                               , "--datecolor=1793D1ff"
                               ]

        fancyHibernate = do
            spawn fancyLockCmd
            spawn "systemctl hibernate"

        winBoot = do
            unGrab
            spawn "gksu 'efibootmgr --bootnext=0' && systemctl reboot"


myLayout =
    smartBorders mouseResizableTile |||
    smartBorders mouseResizableTile { isMirrored = True } |||
    centerMaster Grid |||
    buttonDeco shrinkText defaultThemeWithButtons floatSimpleSimple |||
    noBorders (tabbed shrinkText (theme adwaitaDarkTheme))

myConfig = desktopConfig
    { logHook = workspaceHistoryHook >> dynamicLog
    , startupHook = myStartup
    , layoutHook = myLayout

    -- overrides
    , modMask = mod4Mask
    , terminal = myTerminal
    , borderWidth = 4
    , normalBorderColor = "#272A33"
    , focusedBorderColor = "#5294E2"
    }

main = do
  xmonad =<< xmobar (myConfig `additionalKeysP` myKeys)

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
--          <M-S-b>   Firefox
--          <M-f>     Thunar
--          <PrtSc>   xfce4-screenshot?
--          <M-S-p>   xfce4-appfinder?   rofi?   algum runner do xmonad-contrib?
--          <M-Tab>   rofi -sidebar-mode -show window
--
--  Other stuff to configure
--      xmobar
--
--  Misc WM stuff
--      Automatically float some windows
--      Bring i3's "smart border" (a lonely window in a workspace doesn't have border)
--      Proper EWMH fullscreen handling
--      Confortable "Exit submap" (lock, suspend, hibernate, reboot to Windows, etc.)

-- Copy-pasted notes:
--     desktopConfig is an XConfig that configures xmonad to ignore and
-- leave room for dock type windows like panels and trays, adds the
-- default key binding to toggle panel visibility, and activates basic
-- EWMH support. It also sets a prettier root window mouse pointer.
