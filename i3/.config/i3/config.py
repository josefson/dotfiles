#!/usr/bin/env python3
from sys import argv
import string
import os

# Variables {{{
'''
i3 modes are case-insensitive. Please don't try to use cased characters
anywhere but the final character of the string.
'''


USER = os.getenv('USER')
HOME = os.getenv('HOME')
BIN = f'{HOME}/bin'

term = 'urxvt'
shell = 'zsh'
editor = 'vim'
browser = 'qutebrowser'
# }}}


# Helper functions {{{
def exec(cmd):
    if type(cmd) is list:
        command = ''
        placeholder = 'exec --no-startup-id {};'
        for c in cmd:
            command += placeholder.format(c)
        return command
    return f'exec --no-startup-id {cmd}'


def exec_startup(cmd):
    return f'exec --no-startup-id {cmd}'


def exec_term(cmd):
    return f'exec --no-startup-id {term} -title {cmd} -e {cmd}'
# }}}


move_focus = {f'm{i}': f'workspace number $w{index}'
              for index, i in enumerate('asdfghjkl', start=1)}
move_send = {f'mm{i}': f'move container to workspace number $w{index}'
             for index, i in enumerate('asdfghjkl', start=1)}
move_send_focus = {
    f'M{i}':
    f'move container to workspace number $w{index}; workspace back_and_forth'
    for index, i in enumerate('asdfghjkl', start=1)
}

marks = {f'z{key}': f'mark --toggle --add {key}' for key in string.ascii_lowercase}
marks_goto = {f'c{key}': f'[con_mark="{key}"] focus;' for key in string.ascii_lowercase}

# direction = {'k': 'up', 'j': 'down', 'h': 'left', 'l': 'right'}
# move_c_dir = {f'mc{key}': f'move container to output {value}'
#               for key, value in direction.items()}
# move_w_dir = {f'mw{key}': f'move workspace to output {value}'
#               for key, value in direction.items()}


binds = {  # {{{
    **move_focus,
    **move_send,
    **move_send_focus,
    **marks,
    **marks_goto,
    # **move_c_dir,
    # **move_w_dir,
    # {{{ OPEN
    'oa': exec(f'{BIN}/arconai.py'),
    'of': exec('firefox'),
    'op': exec_term('ipython'),
    'ok': exec('keepassxc'),
    'ol': exec('libreoffice'),
    'ov': exec('virtualbox'),
    'oc': f'exec --no-startup-id {term} -title calc -e /usr/bin/zsh -c "source {HOME}/.zshrc && calc"',
    # }}}
    # {{{ scratchpad
    'sl': exec(f'{BIN}/scratchpad.py -c transmission -a transmission-qt'),
    'st': exec(f'{BIN}/scratchpad.py -t Telegram -a telegram-desktop'),
    'sd': exec(f'{BIN}/scratchpad.py -t discordapp.com -a '
               f'"qutebrowser https://discordapp.com/channels/@me"'),
    'sw': exec(f'{BIN}/scratchpad.py -t web.whatsapp.com -a '
               f'"qutebrowser https://web.whatsapp.com/"'),
    'sb': exec(f'{BIN}/scratchpad.py -c qute_scratch -a "qutebrowser --basedir'
               f' {HOME}/Downloads/tmpdir --qt-arg name qute_scratch"'),
    # }}}
    # {{{ Utils
    'uss': exec(f'{BIN}/say $xclip -selection primary -o'),  # selection
    'usc': exec(f'{BIN}/say $xclip -selection clipboard -o'),  # clipboard
    'uiw': exec(f'{BIN}/invert_colors.sh'),  # inner app
    'uix': exec('xrandr-invert-colors'),  # around app
    'ux': exec([f'{BIN}/keyboard.sh', f'{BIN}/screen.sh']),
    'uwr': exec('feh --randomize --bg-scale $walls/'),
    'uws': exec('sxiv -r -t ~/Pictures/Wallpapers'),
    # }}}
    # {{{ Workspace
    'wM': exec('i3-input -P "move to workspace name: " -F "move to workspace %s"'),
    'wm': exec("i3-input -P 'move to workspace number: ' -F 'move to workspace number %s'"),
    'wo': exec("i3-input -P 'move workspace to output: ' -F 'move workspace to output %s'"),
    'wr': exec("i3-input -P 'rename workspace to ' -F 'rename workspace to %s'"),
    # }}}
    # {{{ music player
    'dp': exec('mpc toggle'),
    'dq': exec('mpc stop'),
    'dn': exec('mpc next'),
    'dN': exec('mpc previous'),
    'dr': exec('mpc random'),
    'dR': exec('mpc repeat'),
    # }}}
    # {{{ screenshot or print
    # clipboard
    'pw': exec(f'{BIN}/shoot.sh -wc'),
    'pf': exec(f'{BIN}/shoot.sh -fc'),
    'ps': exec(f'{BIN}/shoot.sh -sc'),
    # clipboard and file
    'pW': exec(f'{BIN}/shoot.sh -w'),
    'pF': exec(f'{BIN}/shoot.sh -f'),
    'pS': exec(f'{BIN}/shoot.sh -s'),
    # imgur
    'pi': exec(f'{BIN}/shoot.sh -i'),
    # flameshot
    'pp': exec('flameshot gui'),
    # }}}
    # {{{ quake-style -> urxvt
    'h': exec(f'{BIN}/quake.py -n quake_left'),
    'l': exec(f'{BIN}/quake.py -n quake_right'),
    'k': exec(f'{BIN}/quake.py -n quake_top'),
    'j': exec(f'{BIN}/quake.py -n quake_bottom'),
    # }}}
    # {{{ quake-style -> float sticky position size
    'ah': exec(f'{BIN}/resolution.py -r 50 -p left'),
    'al': exec(f'{BIN}/resolution.py -r 50 -p right'),
    'ak': exec(f'{BIN}/resolution.py -r 50 -p top'),
    'aj': exec(f'{BIN}/resolution.py -r 50 -p bottom'),
    'ay': exec(f'{BIN}/resolution.py -r 30 -p top left'),
    'au': exec(f'{BIN}/resolution.py -r 30 -p top right'),
    'ai': exec(f'{BIN}/resolution.py -r 30 -p bottom left'),
    'ao': exec(f'{BIN}/resolution.py -r 30 -p bottom right'),
    # }}}
}  # }}}

# Footer {{{
# This variable is what gets read by vi3m. It's a list
# so you can set wholly separate groups of mappings if you want
# although it's not required.
configs = [
    {
        'key': '$super+semicolon',
        'sym': 'Do:',
        'binds': binds,
    }
]

# If you run `./sample_config d` or `./sample_config debug`, it should print
# out the contents of the 'binds' variable.
try:
    if argv[1] in ['d', 'debug']:
        for i in binds:
            print(f'{i}: {binds[i]}')
except Exception:
    pass
# }}}
# vim: fo=tcq fdm=marker tw=0
