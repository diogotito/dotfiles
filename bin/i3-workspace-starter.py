#!/usr/bin/env python3

import asyncio
import pprint

from gi.repository.GLib import Variant
from i3ipc import Event
from i3ipc.aio import Connection
from pydbus import SessionBus

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
    0: "Other"
}

bus = SessionBus()
xfconf = bus.get("org.xfce.Xfconf")
xfconf.SetProperty("xfce4-appfinder", "/enable-service", Variant("b", True))
xfconf.SetProperty("xfce4-appfinder", "/single-window", Variant("b", True))


async def on_workspace_focus(i3, event):
    await i3.command('[class="Xfce4-appfinder"] kill')

    if event.current.focus:
        return

    if event.current.num in WORKSPACE_CATEGORIES:
        category = Variant("s", WORKSPACE_CATEGORIES[event.current.num])
        xfconf.SetProperty("xfce4-appfinder", "/last/category", category)
        try:
            bus.get("org.xfce.Appfinder").OpenWindow(True, 'i3wspy')
        except:
            # The xfce4-appfinder service isn't running. Start it up.
            await i3.command("exec --no-startup-id xfce4-appfinder")


async def on_window_focus(i3, event):
    if event.container.window_class != "Xfce4-appfinder":
        for appfinder in (await i3.get_tree()).find_classed("Xfce4-appfinder"):
            await appfinder.command("kill")


async def main():
    i3 = await Connection(auto_reconnect=True).connect()
    i3.on(Event.WORKSPACE_FOCUS, on_workspace_focus)
    i3.on(Event.WINDOW_FOCUS, on_window_focus)
    await i3.main()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
