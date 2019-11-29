#!/usr/bin/env python3
from sys import argv
import os

# vim:fdm=marker:

# i3 modes are case-insensitive. Please don't try to use cased characters
# anywhere but the final character of the string.

# Helper variables
# You can set these to whatever you want.
term = 'urxvt'
shell = 'zsh'
editor = 'vim'

# Helper functions
def E(cmd): return 'exec %s' % cmd
def En(cmd): return 'exec --no-startup-id %s' % cmd

def B(cmd): return '~/bin/%s' % cmd
def I(cmd): return '~/.i3/bin/%s' % cmd

def T(cmd): return '%s -e %s' % (term, cmd)
def S(cmd): return '%s -c "%s"' % (shell, cmd)

# Generate some bindings for each workspace number
# These assume you have workspaces numbered $wN, so if you don't, change it.
move_focus = {
	'm%i' % i: 'workspace number $w%i' % i
	for i in list(range(1, 10)) + [0]
}

move_send = {
	'mm%i' % i: 'move container to workspace number $w%i' % i
	for i in list(range(1, 10)) + [0]
}

move_send_focus = {
	'mz%i' % i: 'move container to workspace number $w%i; workspace back_and_forth' % i
	for i in list(range(1, 10)) + [0]
}

binds = { # {{{
	**move_focus,
	**move_send,
	**move_send_focus,
	# I use z for workspace back_and_forth in my config, so I'm using it here
	'mZ': 'move container to workspace back_and_forth; workspace back_and_forth',
	# {{{ applications
		'ad': E('discord'),
		'af': E('firefox'),
		'aF': E('firefox --private-window'),
		'ag': E('gimp'),
		'aG': E('gimp ~/Pictures/Screenshots/Latest.png'),
		'al': E('leafpad'),
		'aL': E('libreoffice'),
		'as': E('steam'),
		'at': E(B('telegram')),
		'av': E('vlc'),
		'aV': E('VirtualBox'),
	# }}}
	# {{{ i3-wm
		'ii': E('i3-input'),
		'il': E(I('autolock_locker.sh')),
		'iL': E(I('autolock_locker.sh' + ' & ' + S('sleep 60 && xset dpms force off'))),
		'im': E('i3-input '
			+ '-P "mark " -F "mark %s"'),
		'iM': E('i3-input '
			+ '-P "unmark " -F "unmark %s"'),
	# }}}
	# {{{ workspaces
		'wm': E('i3-input '
			+ '-P "move to workspace " -F "move to workspace %s"'),
		'wM': E('i3-input '
			+ '-P "move to workspace number " -F "move to workspace number %s"'),
		'wo': E('i3-input '
			+ '-P "move workspace to output " -F "move workspace to output %s"'),
		'wr': E('i3-input '
			+ '-P "rename workspace to " -F "rename workspace to %s"'),
	# }}}
	# {{{ utilities
		'up': E(T('pulsemixer')),
		'uP': E('pavucontrol'),
	# }}}
	# {{{ misc
		# The z prefix is where all my miscellaneous bindings go
		'zpocr': E('echo -n "https://ocremix.org/remix/OCRxxxxx" | xsel -b -i'),
	# }}}
} # }}}

# This variable is what gets read by vi3m. It's a list, so you can set wholly separate
# groups of mappings if you want, although it's not required.
configs = [
	{
		# The presence of 'mod' overrides 'key' and 'sym', so I've commented it
		# out. You can put any key, like 'p', 'semicolon', or 'Return' here,
		# and it will attempt to automatically determine the keybinding and the
		# symbolic name for the vi3m mode.
		#'mod': 'p',
		'key': '$mod+p',
		'sym': 'P-',
		'binds': binds
	}
]

# If you run `./sample_config d` or `./sample_config debug`, it should print
# out the contents of the 'binds' variable.
try:
	if argv[1] in ['d', 'debug']:
		for i in binds:
			print('\'%s\': \'%s\'' % (i, binds[i]))
except:
	pass
