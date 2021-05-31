#!/usr/bin/env python
import subprocess
import shlex
import sys
import os


ctl_file = f'{os.getenv("HOME")}/.config/pianobar/ctl'
remote_cmd = sys.argv[1]


def run_cmd(shortcut):
    cmd = f'echo -n "{shortcut}" > {ctl_file}'
    os.system(cmd)


if remote_cmd == 'play':
    run_cmd('p')
elif remote_cmd == 'quit':
    run_cmd('q')
elif remote_cmd == 'next':
    run_cmd('n')
elif remote_cmd == 'love':
    run_cmd('+')
elif remote_cmd == 'ban':
    run_cmd('-')
elif remote_cmd == 'explain':
    run_cmd('e')
elif remote_cmd == 'tired':
    run_cmd('t')
elif remote_cmd == 'info':
    run_cmd('i')
elif remote_cmd == 'history':
    run_cmd('h')
elif remote_cmd == 'volume_up':
    run_cmd(')')
elif remote_cmd == 'volume_down':
    run_cmd('(')
elif remote_cmd == 'volume_reset':
    run_cmd('^')
elif remote_cmd == 'change':
    zenity = subprocess.run(shlex.split('zenity --entry --entry-text="Search station:" --text="eg: Pink Floyd"'), capture_output=True)
    station = zenity.stdout.decode('utf-8')
    cmd = f'echo -n "s" > {ctl_file}'
    os.system(cmd)
    cmd = f'echo -n "{station}" > {ctl_file}'
    os.system(cmd)
