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


async def close_appfinder(i3, _event=None):
    await i3.command('[class="Xfce4-appfinder"] kill')
    i3.off(close_appfinder)


async def on_workspace_focus(i3, event):
    await close_appfinder(i3)

    if event.current.focus:
        return

    if event.current.num in WORKSPACE_CATEGORIES:
        category = Variant("s", WORKSPACE_CATEGORIES[event.current.num])
        xfconf.SetProperty("xfce4-appfinder", "/last/category", category)
        try:
            startup_id = f'i3-workspace-starter'
            bus.get("org.xfce.Appfinder").OpenWindow(True, startup_id)
        except:
            await i3.command("exec xfce4-appfinder")

    await asyncio.sleep(0.02)
    i3.on(Event.WINDOW_FOCUS, close_appfinder)


async def main():
    i3 = await Connection(auto_reconnect=True).connect()
    i3.on(Event.WORKSPACE_FOCUS, on_workspace_focus)
    i3.on(Event.WORKSPACE_INIT, close_appfinder)
    await i3.main()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
