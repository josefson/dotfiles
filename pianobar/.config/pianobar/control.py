#!/usr/bin/env python
import sys
import os


ctl_file = f'{os.getenv("HOME")}/.config/pianobar/ctl'
remote_cmd = sys.argv[1]


if remote_cmd == 'play':
    cmd = f'echo -n "p" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'quit':
    cmd = f'echo -n "q" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'next':
    cmd = f'echo -n "n" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'love':
    cmd = f'echo -n "+" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'ban':
    cmd = f'echo -n "-" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'explain':
    cmd = f'echo -n "e" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'tired':
    cmd = f'echo -n "t" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'current':
    cmd = f'echo -n "t" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'info':
    cmd = f'echo -n "i" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'history':
    cmd = f'echo -n "h" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'change':
    cmd = f'echo -n "s" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'volume_up':
    cmd = f'echo -n ")" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'volume_down':
    cmd = f'echo -n "(" > {ctl_file}'
    os.system(cmd)
elif remote_cmd == 'volume_reset':
    cmd = f'echo -n "^" > {ctl_file}'
    os.system(cmd)
