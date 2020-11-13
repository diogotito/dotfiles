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


def xfce4_appfinder_settings(settings):
    for property, value in settings.items():
        xfconf.SetProperty("xfce4-appfinder", property, value)


async def open_xfce4_appfinder(i3, workspace_name=""):
    try:
        bus.get("org.xfce.Appfinder").OpenWindow(True, workspace_name)
    except:
        await i3.command("exec xfce4-appfinder")


async def on_workspace_focus(i3, event):
    await i3.command('[class="Xfce4-appfinder"] kill')

    if event.current.focus:
        return

    if event.current.num in WORKSPACE_CATEGORIES:
        category = WORKSPACE_CATEGORIES[event.current.num]
        xfce4_appfinder_settings({
            "/last/category": Variant("s", category),
            "/enable-service": Variant("b", True),
            "/single-window": Variant("b", True),
        })
        await open_xfce4_appfinder(i3, event.current.name)


async def main():
    i3 = await Connection(auto_reconnect=True).connect()
    i3.on(Event.WORKSPACE_FOCUS, on_workspace_focus)
    await i3.main()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
