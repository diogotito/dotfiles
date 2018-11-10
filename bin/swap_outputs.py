#!/bin/env python
import sys
import os
import time
import i3

TEMP_WORKSPACE = "swap_outputs.py"

active_outputs = [out for out in i3.get_outputs() if out['active']]

# Do nothing if there aren't more than one active ouput
if len(active_outputs) < 2:
    sys.exit()

a, b = active_outputs[:2]
print("{} <-> {}".format(a['current_workspace'], b['current_workspace']))

a_workspace = a['current_workspace']
i3.workspace(a_workspace); time.sleep(0.025)
i3.move('workspace to output right'); time.sleep(0.025)
i3.workspace(a_workspace); time.sleep(0.025)
i3.rename('workspace to', TEMP_WORKSPACE); time.sleep(0.025)

b_workspace = b['current_workspace']
i3.workspace(b_workspace); time.sleep(0.025)
i3.move('workspace to output right'); time.sleep(0.025)
i3.workspace(b_workspace); time.sleep(0.025)
i3.rename('workspace to', a_workspace); time.sleep(0.025)

i3.workspace(TEMP_WORKSPACE); time.sleep(0.025)
i3.rename('workspace to', b_workspace); time.sleep(0.025)

i3.workspace(a_workspace)
i3.mode('default')

# Fix my background
# os.execlp('feh', '--bg-fill', '/home/diogo/Pictures/Wallpapers/t3_5bjy01.png')
