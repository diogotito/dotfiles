#!/usr/bin/env python3

import asyncio
import pprint

from gi.repository.GLib import GError, Variant
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


async def main():
    bus = SessionBus()
    xfconf = bus.get("org.xfce.Xfconf")
    i3 = await Connection(auto_reconnect=True).connect()

    def convenient_settings():
        v_true = Variant("b", True)
        xfconf.SetProperty("xfce4-appfinder", "/enable-service", v_true)
        xfconf.SetProperty("xfce4-appfinder", "/single-window", v_true)

    async def open_xfce4_appfinder(workspace_name=""):
        convenient_settings()

        await i3.command('[class="Xfce4-appfinder"] '
                         'move --no-auto-back-and-forth container to '
                         f'workspace number {workspace_name}')

        try:
            bus.get("org.xfce.Appfinder").OpenWindow(True, workspace_name)
        except:
            await i3.command("exec xfce4-appfinder")

    async def on_workspace_focus(_i3, event):
        if event.current.focus:
            # Focus stack isn't empty --> workspace isn't empty, so ignore it.
            return

        new_workspace_num = event.current.num
        new_workspace_name = event.current.name

        if new_workspace_num in WORKSPACE_CATEGORIES:
            category = WORKSPACE_CATEGORIES[new_workspace_num]
            xfconf.SetProperty("xfce4-appfinder", "/last/category",
                               Variant("s", category))
            await open_xfce4_appfinder(new_workspace_name)

    i3.on(Event.WORKSPACE_FOCUS, on_workspace_focus)
    await i3.main()


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main())
