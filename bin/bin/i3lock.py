#!/usr/bin/env python
import os

command = "command -v {}"
lock_command = "i3-msg exec {}"

locks = ["i3lock-fancy", "i3-lock", "dm-tool lock"]
for lock in locks:
    if os.system(command.format(lock)) == 0:
        print(f"Locking the system with: {lock}")
        os.system(lock_command.format(lock))
        break
    print(f"Haven't found suitable lock in : {locks}")
