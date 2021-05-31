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

marks = {f'zz{key}': exec(f'{BIN}/i3-marks mark --mark {key}') for key in string.ascii_lowercase}
marks_goto = {f'zx{key}': exec(f'{BIN}/i3-marks goto --mark {key}') for key in string.ascii_lowercase}

# direction = {'k': 'up', 'j': 'down', 'h': 'left', 'l': 'right'}
# move_c_dir = {f'mc{key}': f'move container to output {value}'
#               for key, value in direction.items()}
# move_w_dir = {f'mw{key}': f'move workspace to output {value}'
#               for key, value in direction.items()}


binds = {  # {{{
    **move_focus,       # m{a-;}
    **move_send,        # mm{a-;}
    **move_send_focus,  # M{a-;}
    **marks,
    **marks_goto,
    # **move_c_dir,
    # **move_w_dir,
    # {{{ OPEN
    # 'oa': exec(f'{BIN}/arconai.py'),
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
    'sq': exec([f'{BIN}/scratchpad.py -c qute_scratch -a "qutebrowser --basedir'
               f' {HOME}/Downloads/tmpdir -C {HOME}/.config/qutebrowser/config.py'
               f' --qt-arg name qute_scratch"', f'{BIN}/resolution.py -r 60 -p center']),
    'sm': exec(f'{BIN}/scratchpad.py -c ncmpcpp -a "urxvt -name ncmpcpp -e ncmpcpp"'),
    # }}}
    # {{{ Utils
    'uss': exec(f'{BIN}/say $(xclip -selection primary -o)'),  # selection
    'usc': exec(f'{BIN}/say $(xclip -selection clipboard -o)'),  # clipboard
    'uiw': exec(f'{BIN}/invert_colors.sh'),  # inner app
    'uix': exec('xrandr-invert-colors'),  # around app
    'ux': exec([f'{BIN}/keyboard.sh', f'{BIN}/screen.sh']),
    'uwr': exec('feh --randomize --bg-scale $walls/'),
    'uws': exec('sxiv -r -t ~/Pictures/Wallpapers'),
    # Dunst
    'udh': exec('dunstctl history-pop'),
    'udc': exec('dunstctl close-all'),
    'udp': exec('dunstctl set-paused toggle'),
    'uds': exec('dunstctl set-paused false'),
    'udq': exec('dunstctl set-paused true'),
    # }}}
    # {{{ Workspace
    'wM': exec('i3-input -P "move to workspace name: " -F "move to workspace %s"'),
    'wm': exec("i3-input -P 'move to workspace number: ' -F 'move to workspace number %s'"),
    'wo': exec("i3-input -P 'move workspace to output: ' -F 'move workspace to output %s'"),
    'wr': exec("i3-input -P 'rename workspace to ' -F 'rename workspace to %s'"),
    # }}}
    # {{{ music player
    # Pianobar
    'pbp': exec(f'{HOME}/.config/pianobar/control.py play'),
    'pbq': exec(f'{HOME}/.config/pianobar/control.py quit'),
    'pbn': exec(f'{HOME}/.config/pianobar/control.py next'),
    'pbl': exec(f'{HOME}/.config/pianobar/control.py love'),
    'pbb': exec(f'{HOME}/.config/pianobar/control.py ban'),
    'pbt': exec(f'{HOME}/.config/pianobar/control.py tired'),
    'pbe': exec(f'{HOME}/.config/pianobar/control.py explain'),
    'pbi': exec(f'{HOME}/.config/pianobar/control.py info'),
    'pbh': exec(f'{HOME}/.config/pianobar/control.py history'),
    'pbk': exec(f'{HOME}/.config/pianobar/control.py volume_up'),
    'pbj': exec(f'{HOME}/.config/pianobar/control.py volume_down'),
    'pbr': exec(f'{HOME}/.config/pianobar/control.py volume_reset'),
    'pbc': exec(f'{HOME}/.config/pianobar/control.py change'),
    #Media plyaer
    'pdp': exec('mpc toggle'),
    'pdq': exec('mpc stop'),
    'pdn': exec('mpc next'),
    'pdN': exec('mpc previous'),
    'pdr': exec('mpc random'),
    'pdR': exec('mpc repeat'),
    # }}}
    # {{{ screenshot or print
    # clipboard
    'ssw': exec(f'{BIN}/shoot.sh -wc'),
    'ssf': exec(f'{BIN}/shoot.sh -fc'),
    'sss': exec(f'{BIN}/shoot.sh -sc'),
    # clipboard and file
    'ssW': exec(f'{BIN}/shoot.sh -w'),
    'ssF': exec(f'{BIN}/shoot.sh -f'),
    'ssS': exec(f'{BIN}/shoot.sh -s'),
    # imgur
    'ssi': exec(f'{BIN}/shoot.sh -i'),
    # flameshot
    'ssp': exec('flameshot gui'),
    # }}}
    # {{{ quake-style -> urxvt
    'h': exec(f'{BIN}/quake.py -n quake_left'),
    'l': exec(f'{BIN}/quake.py -n quake_right'),
    'k': exec(f'{BIN}/quake.py -n quake_top'),
    'j': exec(f'{BIN}/quake.py -n quake_bottom'),
    # }}}
    # {{{ quake-style -> float sticky position size
    'aa': exec(f'{BIN}/resolution.py -r 60 -p center'),
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
