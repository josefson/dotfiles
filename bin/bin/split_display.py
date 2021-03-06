#!/usr/bin/env python
# -*- coding: utf-8 -*-
# This script aims to split the xrandr display into 2 virtual displays
# in order to accomodate 2 workspaces in a single physical display.
# Apparently this was a feature awesomewm was capable of, but not i3.
# Here i implement the same feature through xrandr.
# Source of this idea came from:
# https://askubuntu.com/questions/659381/use-one-monitor-as-multiple-monitors/998429#998429
# xrandr --setmonitor "monitor_name" "width_px"/"width_mm"x"height_px"/"height_mm"+"x_offset_px"+"y_offset_px" "output_name"

import argparse
import re
import shlex
import subprocess
import sys


class Display:
    def __init__(self, xrandr_output, ratio):
        """Recieves a xrandr connected display line and isolate its
        attributes into variabes."""
        self.ratio = [r / 100 for r in ratio]
        pattern = (
            r"(?P<name>^\S+) .* "
            r"(?P<width>\d+)x(?P<height>\d+)\+(?P<x>\d+)\+(?P<y>\d+) "
            r".* (?P<mmx>\d+)mm x (?P<mmy>\d+)mm"
        )
        self.search = re.search(pattern, xrandr_output)
        self.name = self.search.group("name")
        self.width = int(self.search.group("width"))
        self.height = int(self.search.group("height"))
        self.x_offset = int(self.search.group("x"))
        self.y_offset = int(self.search.group("y"))
        self.mmx = int(self.search.group("mmx"))
        self.mmy = int(self.search.group("mmy"))

    def __repr__(self):
        """Representation of Display class."""
        return (
            f"{self.name}: {self.width}x{self.height} "
            f"{self.x_offset},{self.y_offset} "
            f"{self.mmx}mm,{self.mmy}mm"
        )

    def split(self):
        """Compile and execute needed to split a workspace in 2."""

        self.unsplit()  # Delete virtual monitors with the self.name if any.

        cmd = "xrandr --setmonitor {}~{} {}/{}x{}/{}+{}+{} {}"
        cmd1 = cmd.format(
            self.name,
            1,
            int(self.width * self.ratio[0]),
            self.mmx,
            self.height,
            self.mmy,
            self.x_offset,
            self.y_offset,
            self.name,
        )
        cmd2 = cmd.format(
            self.name,
            2,
            int(self.width * self.ratio[1]),
            self.mmx,
            self.height,
            self.mmy,
            self.x_offset + int(self.width * self.ratio[0]),
            self.y_offset,
            "none",
        )

        print(f"\nCREATING VIRTUAL/FAKE DISPLAYS:")
        commands = [cmd1, cmd2]
        for command in commands:
            run(command)

    def unsplit(self):
        """Compile and execute needed to unsplit a workspace from 2 to 1."""

        cmds = [
            f"xrandr --delmonitor {self.name}~1",
            f"xrandr --delmonitor {self.name}~2",
        ]

        print(f"\nDELETING PRE-EXISTING VIRTUAL DISPLAYS ON {self.name}")
        for cmd in cmds:
            run(cmd)


def run(cmd):
    print(f"Command being run: {cmd}")
    subprocess.run(shlex.split(cmd))


# def split(xrandr_display, action, ratio):
def split(xrandr_display, **arg):
    display = Display(xrandr_display, arg["ratio"])
    print(f"DISPLAY: {display}")
    if arg["action"] == "split":
        display.split()
    elif arg["action"] == "undo":
        display.unsplit()


def choose_display(output_choice):
    output = subprocess.run("xrandr", stdout=subprocess.PIPE).stdout.decode("utf-8")
    connected_outputs = [line for line in output.splitlines() if " connected " in line]
    outputs = {index + 1: output for index, output in enumerate(connected_outputs)}

    if not output_choice and len(outputs) == 1:
        return outputs[1]
    else:
        output = [
            output for output in outputs.values() if output_choice == output.split()[0]
        ]
        if len(output) == 1:
            return output[0]
        else:
            raise Exception(
                f"\nExpected only 1 matching output form xrandr, instead:"
                f"\nOutput entered: {output_choice}"
                f"\nFound: {len(output)} of avlaiable "
                f"{[output.split()[0] for output in outputs.values()]}."
            )


def parser():

    output = subprocess.run("xrandr", stdout=subprocess.PIPE).stdout.decode("utf-8")
    connected_outputs = [line for line in output.splitlines() if " connected " in line]
    outputs = [output.split(" ")[0] for output in connected_outputs]

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "action",
        choices=["split", "undo"],
        help="Action to perform on a chosen workspace, "
        'either "split" or "undo" is accepted. SPLIT: Splits vertically '
        "a chosen xrandr display into two virtual ones. UNDO: Delete "
        "possible virtual displays created by this script for a chosen "
        "xrandr display.",
    )
    parser.add_argument(
        "-r",
        "--ratio",
        dest="ratio",
        default="50x50",
        type=str,
        help="Ratio: Ratio percentage for the 2 halfs. AxB where "
        "A+B is 100.\n\tDefault is 50x50.\n\tEx: -r 50x50; -r 30x70.",
    )
    parser.add_argument(
        "-o",
        "--output",
        dest="output",
        type=str,
        default=None,
        help="Output name given by xrandr.",
    )
    parser.add_argument("--reload_cmd", dest="reload_cmd", type=str, nargs="+")
    parser.add_argument(
        "--i3",
        action="store_true",
        help="If using i3, in order to reload it afterwards for fixing bars.",
    )
    parser.add_argument(
        "--i3ipc",
        action="store_true",
        help="Flag for making use of python "
        "i3ipc dependency. Which is used to put the focus back at the "
        "workspace where one activated the script.",
    )
    args = parser.parse_args()

    if len(outputs) > 1 and not args.output:
        message = (
            f"Attention: \n\tSince xrandr shows multiple outputs connected, "
            f' you must select one of them through the "-o/--output" flag.'
            f"\n\tCurrently connected outputs are: {outputs}"
            f"\nHELP: \n\tRun --help for more info"
        )
        print(message)
        sys.exit(0)
    arg = {
        "action": args.action,
        "output": args.output.upper(),
        "i3ipc": args.i3ipc,
        "i3": args.i3,
        "reload_cmd": args.reload_cmd,
        "ratio": args.ratio,
    }
    return arg


def main():
    # parsing
    arg = parser()
    # action, ratio, i3ipc = args.action, args.ratio, args.i3ipc

    # valitades --ratio/-r argument
    if arg["ratio"]:
        import sys

        ratio = arg["ratio"]
        if "x" not in ratio:
            sys.exit("Argument ratio format not expected. Ex: 30x70")
        ratio = [int(split) for split in ratio.split("x")]
        if len(ratio) != 2:
            sys.exit("Too many splits were passed, max: 2. Ex: 30x70")
        if sum(ratio) != 100:
            sys.exit("Ratio sum should be 100. Ex: 50x50, 30x70, etc")
        for x in ratio:
            if x < 1 or x > 100:
                sys.exit(
                    "Ratios should be greater than 0 and lesser than 100 "
                    "Ex: 50x50, 30,70"
                )
        arg["ratio"] = ratio

    # Select the xrandr_display
    xrandr_display = choose_display(arg["output"])

    if arg["i3ipc"]:
        # if i3ipc dependency was chosen, refocus origin workspace
        import i3ipc

        i3 = i3ipc.Connection()
        workspace = i3.get_tree().find_focused().workspace().name
        split(xrandr_display, **arg)
        i3.command(f"workspace {workspace}")
    else:
        split(xrandr_display, **arg)
    if arg["i3"]:
        run("i3-msg reload")
    elif arg["reload_cmd"]:
        run(" ".join(arg["reload_cmd"]))


if __name__ == "__main__":
    main()
