#!/usr/bin/env python3
from sys import argv

# Variables {{{
'''
i3 modes are case-insensitive. Please don't try to use cased characters
anywhere but the final character of the string.
'''


USER = 'elodin'
HOME = f'/home/{USER}'
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
    pass
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

direction = {'k': 'up', 'j': 'down', 'h': 'left', 'l': 'right'}
move_c_dir = {f'mc{key}': f'move container to output {value}'
              for key, value in direction.items()}
move_w_dir = {f'mw{key}': f'move workspace to output {value}'
              for key, value in direction.items()}


binds = {  # {{{
    **move_focus,
    **move_send,
    **move_send_focus,
    **move_c_dir,
    **move_w_dir,
    # {{{ OPEN
    'oa': exec(f'{BIN}/arconai.py'),
    'of': exec('firefox'),
    'op': exec_term('ipython'),
    'ok': exec('keepassxc'),
    'ol': exec('libreoffice'),
    'ov': exec('virtualbox'),
    # }}}
    # {{{ scratchpad
    'scratchpadl': exec(f'{BIN}/scratchpad.py -c transmission -a transmission-qt'),
    'scratchpadt': exec(f'{BIN}/scratchpad.py -t Telegram -a telegram-desktop'),
    'scratchpadd': exec(f'{BIN}/scratchpad.py -t discordapp.com -a '
                        f'"qutebrowser https://discordapp.com/channels/@me"'),
    'scratchpadw': exec(f'{BIN}/scratchpad.py -t web.whatsapp.com -a '
                        f'"qutebrowser https://web.whatsapp.com/"'),
    'scratchpadb': exec(f'{BIN}/scratchpad.py -c qute_scratch -a "qutebrowser --basedir'
                        f' {HOME}/Downloads/tmpdir --qt-arg name qute_scratch"'),
    # }}}
    # {{{ config
    'xk': exec(f'{BIN}/keyboard.sh'),
    'xs': exec(f'{BIN}/screen.sh'),
    'xx': exec([f'{BIN}/keyboard.sh', f'{BIN}/screen.sh']),
    # }}}
    # {{{ Workspace
    'wM': exec('i3-input -P "move to workspace " -F "move to workspace %s"'),
    'wm': exec("i3-input -P 'move to workspace number ' -F 'move to workspace number %s'"),
    'wo': exec("i3-input -P 'move workspace to output ' -F 'move workspace to output %s'"),
    'wr': exec("i3-input -P 'rename workspace to ' -F 'rename workspace to %s'"),
    # }}}
    # {{{ wallpaper
    # 'wr': exec('feh --randomize --bg-scale $walls/'),
    # 'ws': exec('nitrogen $walls'),
    'ww': exec('sxiv -r -t ~/Pictures/Wallpapers'),
    # }}}
    # {{{ music player
    'mp': exec('mpc toggle'),
    'mq': exec('mpc stop'),
    'mn': exec('mpc next'),
    'mN': exec('mpc previous'),
    'mr': exec('mpc random'),
    'mR': exec('mpc repeat'),
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
