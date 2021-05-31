#!/usr/bin/env python
# -*- coding: utf-8 -*-
# This script serves as an auxiliar script to pywal, to set theme colors to
# rofi and i3status bar
import os
from pathlib import Path


def read_colors(color_file):
    with open(color_file, 'r') as f:
        color_pallete = [color.strip() for color in f.readlines()]
    colors = {
        'bg': color_pallete[0],
        'fg': color_pallete[1],
        'tx': color_pallete[7]
    }
    return colors


def set_rofi(rofi_file, colors):

    # rofi config file
    with open(rofi_file, 'r') as f:
        # readlines for config excluding the rofi.color lines
        rofi_lines = [line for line in f.readlines()
                      if 'rofi.color-' not in line]

    # setting colors to be used
    bg = colors['bg']
    fg = colors['fg']

    # appending the new rofi.color- lines to the rofi_lines list
    for option in ['window', 'normal', 'active', 'urgent']:
        line = f'rofi.color-{option}: {bg}, {fg}, {bg}, {fg}, {bg}'
        if option == 'window':
            line = f'rofi.color-{option}: {bg}, {bg}, {bg}, {fg}, {bg}'
        rofi_lines.append(line + '\n')

    # writing rofi_lines list to rofi_config file
    with open(rofi_file, 'w') as f:
        f.writelines(rofi_lines)


def set_i3status(i3status_file, colors):
    color_changes = [
        'color_good', 'color_pause', 'color_play', 'color_stop',
        'color_charging'
    ]
    for change in color_changes:
        command = (
            f"""sed -i -E "s/(^.*{change}).*$/\\1 = '{colors["tx"]}'/" """
            f"""{i3status_file}"""
        )
        os.system(command)
        print(command)
    os.system('i3-msg restart')


def set_urxvt(xresources_file, colors):
    os.system('xrdb -load {xresources_file}')

def set_zsh_theme(theme_file, colors):
    pass


def main():
    # color file generated by pywal: wal -i image
    color_file = Path('~/.cache/wal/colors').expanduser().as_posix()
    colors = read_colors(color_file)
    rofi_file = Path('~/.config/rofi/config').expanduser().as_posix()
    set_rofi(rofi_file, colors)
    # i3status_file = Path('~/.config/i3status/config').expanduser().as_posix()
    # set_i3status(i3status_file, colors)
    xresources_file = Path('~/.Xresources').expanduser().as_posix()
    set_urxvt(xresources_file, colors)


if __name__ == "__main__":
    main()
