#!/usr/bin/env python3

"""
Make your i3 session feel less empty with... XFCE4's Application Finder!
This script will stick an Application Finder in every new workspace you
enter. It gets dismissed when it loses focus to get out of your way.

It is assumed that i3 is configured with:
    focus_follows_mouse yes
    focus_on_window_activation focus
"""

import asyncio

from gi.repository.GLib import Variant
from i3ipc import Event
from i3ipc.aio import Connection
from pydbus import SessionBus

# Each numbered workspace is associated with an application category
WORKSPACE_CATEGORIES = {
    1: "Accesssories",
    2: "Chromium Apps",
    3: "Office",
    4: "Bookmarks",
    5: "Development",
    6: "Games",
    7: "Internet",
    8: "Settings",
    9: "System",
}

# Tweak xfce4-appfinder over D-Bus
bus = SessionBus()
xfconf = bus.get("org.xfce.Xfconf")
xfconf.SetProperty("xfce4-appfinder", "/enable-service", Variant("b", True))
xfconf.SetProperty("xfce4-appfinder", "/single-window", Variant("b", True))


async def on_workspace_focus(i3, event):
    """Show the appfinder when an empty workspace receives focus"""

    # Close any open appfinder window
    await i3.command('[class="Xfce4-appfinder"] kill')

    # Do nothing if this workspace isn't empty
    if event.current.focus:
        return

    if event.current.num in WORKSPACE_CATEGORIES:
        # Switch appfinder category to the one configured for this workspace
        category = Variant("s", WORKSPACE_CATEGORIES[event.current.num])
        xfconf.SetProperty("xfce4-appfinder", "/last/category", category)

        try:
            # Open a new appfinder window in the new category
            bus.get("org.xfce.Appfinder").OpenWindow(True, 'such_fast')
        except:
            # The xfce4-appfinder service isn't running. Start it up.
            await i3.command("exec --no-startup-id xfce4-appfinder")


async def on_window_focus(i3, event):
    """Close the appfinder when it loses focus"""
    if event.container.window_class != "Xfce4-appfinder":
        await i3.command('[class="Xfce4-appfinder"] kill')


async def main():
    i3 = await Connection(auto_reconnect=True).connect()
    i3.on(Event.WORKSPACE_FOCUS, on_workspace_focus)
    i3.on(Event.WINDOW_FOCUS, on_window_focus)
    await i3.main()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
