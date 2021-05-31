#!/usr/bin/env python
# -*- coding: utf-8 -*-
import subprocess
import argparse
import shlex
import sys

import i3ipc


class Float:

    positions = ["top", "bottom", "right", "left", "center"]

    def __init__(self, position="top right", ratio=30):
        self.app = None
        self.command = None
        self.i3 = i3ipc.Connection()
        self.tree = self.i3.get_tree()
        self.resolution = [
            workspace
            for workspace in self.i3.get_workspaces()
            if workspace.focused is True
        ][0].rect
        self.position = self._positions(position)
        self.border = self.tree.find_focused().current_border_width
        self.ratio = ratio
        self.controller()

    def _positions(self, position):
        """
        Parser for positions argument.
        """
        if type(position) is str and position in self.positions:
            position = [position]
        if type(position) is not list:
            sys.exit(f"position should be a list, instead: {type(position)}")
        if len(position) > 2:
            sys.exit(f"Expects max 2: {len(position)}: {position}")
        for word in position:
            if word not in self.positions:
                sys.exit(f"Direction: {word} not in {self.positions}")
        return position

    def controller(self):
        # local namespace
        border = self.border
        ratio = self.ratio
        position = self.position

        x, y = None, None
        width, height = None, None
        resolution = self.resolution
        # Note: resolution has 4 attrs: x, y, width, height
        # x and y are regarding the position of the global map of displays it starts at
        # width and height are its dimensions

        width = round(resolution.width * ratio / 100)
        height = round(resolution.height * ratio / 100)

        if len(position) == 1:
            if "top" in position:
                width = resolution.width - 2 * border
                x = resolution.x
                y = resolution.y
            elif "bottom" in position:
                width = resolution.width - 2 * border
                x = resolution.x + border
                y = resolution.y + resolution.height - height
            elif "left" in position:
                height = resolution.height
                x = resolution.x
                y = resolution.y
            elif "right" in position:
                height = resolution.height
                x = resolution.x + resolution.width - width
                y = resolution.y
            elif "center" in position:
                x = resolution.x + round(((resolution.width - width) / 2))
                y = resolution.y + round(((resolution.height - height) /2))
        else:
            if "top" in position and "left" in position:
                x = resolution.x
                y = resolution.y
            elif "top" in position and "right" in position:
                x = resolution.width - width + resolution.x
                y = resolution.y
            elif "bottom" in position and "left" in position:
                x = resolution.x
                y = resolution.height - height + resolution.y
            elif "bottom" in position and "right" in position:
                x = resolution.width - width + resolution.x
                y = resolution.height - height + resolution.y

        # command = f'i3-msg floating enable, sticky enable, '\
        command = (
            f"floating enable, sticky enable, "
            f"resize set {width} px {height} px, "
            f"move absolute position {x} {y}"
        )
        self.command = command


def main():
    description = (
        "Accepts a ratio argument in order to get the active output"
        " resolution and calculate the percentage ratio."
    )
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument(
        "-r",
        "--ratio",
        dest="ratio",
        type=int,
        help="Required: Percentage ratio from the active " "resolution. Ex: --ratio 30",
    )
    parser.add_argument(
        "-p",
        "--position",
        dest="position",
        nargs="+",
        required=True,
        type=str,
        help="Required: Which position to be used: "
        "[top, bottom, left, right] to open or move window to. "
        "Ex: --position top; -p top left",
    )

    args = parser.parse_args()
    ratio, position = args.ratio, args.position

    # execute command
    command = f"i3-msg {Float(ratio=ratio, position=position).command}"
    print(command)
    output = subprocess.run(shlex.split(command), capture_output=True)
    return output.stdout.decode("utf-8")


if __name__ == "__main__":
    main()
