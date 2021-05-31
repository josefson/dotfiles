#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Author: Elodin
Place: irc@freenote#i3
"""
import subprocess
import argparse
import shlex
import time
import sys

import i3ipc


def class_exists(connection, window_class):
    tree = connection.get_tree()
    try:
        return tree.find_instanced(window_class)[0]
    except IndexError:
        return False


def title_exists(connection, title):
    tree = connection.get_tree()
    try:
        return tree.find_named(title)[0]
    except IndexError:
        return False


def run(command):
    output = subprocess.run(shlex.split(command), capture_output=True)
    return output.stdout.decode('utf-8')


def parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--title', dest='title', type=str)
    parser.add_argument('-c', '--class', dest='window_class', type=str)
    parser.add_argument('-a', '--app', dest='app', required=True, type=str)
    args = parser.parse_args()
    if args.title and args.window_class:
        sys.exit('Expected either -t/--title or -c/--class, not both.')
    elif not args.title and not args.window_class:
        sys.exit('Expected either -t/--title or -c/--class.')
    return args


def main():
    connection = i3ipc.Connection()
    tree = connection.get_tree()
    args = parser()
    app, title, window_class = args.app, args.title, args.window_class

    # Window must either have class or title
    if title:
        window = tree.find_named(title)
    elif window_class:
        window = tree.find_instanced(window_class)
    else:
        sys.exit('Must either provide a -t/--tittle or a -c/--class')

    # If window already exists > manage window
    if window:
        window = window[0]
        if window.workspace().name == '__i3_scratch':
            window.command('scratchpad show')
            # window.command('fullscreen toggle')
        elif window.workspace().name != '__i3_scratch' and not window.focused:
            window.command('move scratchpad')
            window.command('scratchpad show')
            # window.command('fullscreen toggle')
        else:
            window.command('move scratchpad')
    # Otherwise create window
    else:
        cmd_open = f'i3-msg exec "{app}"'
        run(cmd_open)
        # create window by title
        if title:
            while not title_exists(connection, title):
                time.sleep(0.01)
            window = title_exists(connection, title)
            window.command('floating toggle')
            # window.command('fullscreen toggle')
        # othereise create window by class
        else:
            while not class_exists(connection, window_class):
                time.sleep(0.01)
            window = class_exists(connection, window_class)
            window.command('floating toggle')
            # window.command('fullscreen toggle')


if __name__ == "__main__":
    main()
