#!/usr/bin/env python
# -*- coding: utf-8 -*-
import argparse
import shlex
import subprocess
import time

import i3ipc

from resolution import Float

POSITIONS = ["left", "right", "top", "bottom"]


class Quake:
    def __init__(self, name):
        self.i3 = i3ipc.Connection()
        self.tree = self.i3.get_tree()
        self.name = name
        self.active_workspace = [
            workspace.name
            for workspace in self.i3.get_workspaces()
            if workspace.focused is True
        ][0]

    def is_visible(self):
        # if window in workspace and workspace is focused
        if self.already_exists().workspace().name == self.active_workspace:
            return self.already_exists()
        else:
            return False

    def already_exists(self):
        self.tree = self.i3.get_tree()
        try:
            return self.tree.find_named(self.name)[0]
        except IndexError:
            return False

    def command(self, cmd):
        i3msg = f"{cmd}"
        run(i3msg)


def run(command):
    output = subprocess.run(shlex.split(command), capture_output=True)
    return output.stdout.decode("utf-8")


def parse():
    description = ""
    epilog = ""
    parser = argparse.ArgumentParser(description=description, epilog=epilog)
    parser.add_argument(
        "-n", "--name", dest="name", required=True, type=str,
        help="Window name for existence to be checked.",
    )
    args = parser.parse_args()
    return args


def main():
    args = parse()
    quake = Quake(args.name)

    cmd_float = Float(args.name.split("_")[1], 50).command

    if quake.already_exists() and quake.is_visible():
        quake.already_exists().command('move scratchpad')
    elif quake.already_exists() and not quake.is_visible():
        quake.already_exists().command('scratchpad show')
        quake.already_exists().command(cmd_float)
    elif quake.already_exists() is False:
        run(f'i3-msg exec "urxvt -name {quake.name}"')
        while not quake.already_exists():
            time.sleep(0.01)
        quake.already_exists().command(cmd_float)


if __name__ == "__main__":
    main()
