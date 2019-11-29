#!/usr/bin/env python3
from sys import argv
from config import configs

def validate_config(config):
	binds = config['binds']

	chains = list(binds)
	modes = []
	errors = []

	def get_modes(chain):
		if len(chain) > 1:
			chain = chain[:-1]
			modes.append(chain)
			return get_modes(chain)

	for chain in chains:
		mode = chain[:-1]
		if not chain.isalnum():
			errors.append([1, chain])
		get_modes(chain)

	modes = list(set(modes))
	modes.sort()

	overlap = list(set(chains) & set(modes))
	if overlap:
		errors.append([3, overlap])

	def debug():
		print(binds)
		print()
		print(chains)
		print(modes)

	try:
		if argv[1] in ['d', 'debug']:
			debug()
			exit()
	except:
		pass

	if errors:
		handle_errors(errors)
		exit(1)
	return [chains, modes]

def handle_errors(errors):
	types = {
		1: 'non-alphanumeric chars',
		3: 'overlapped mapping(s)',
	}
	for error in errors:
		msg = 'error: %s: ' % types[error[0]]
		err = str(error[1])
		print(msg + err)
		print(' ' * len(msg) + '^' * len(err))
	exit(1)

def generate_config(config):
	if 'mod' in config:
		p_key = '$mod+%s' % config['mod']
		p_sym = config['mod'][0].upper() + '-'
	elif 'key' in config and 'sym' in config:
		p_key = config['key']
		p_sym = config['sym']
	else:
		print('unable to determine activation binding')
		exit(1)
	binds = config['binds']

	chains, modes = validate_config(config)

	def mode_to_var(mode):
		# conversion to preserve capitalization
		return '$vi3m_' + ''.join([i + '_' if i.isupper() else i for i in list(mode)])

	def get_mode_name(mode, display = False):
		display = True
		if display:
			# Show all possible next keys.
			elems  = [i[-1] for i in chains + modes if mode == i[:-1]]

			# Most of these are disabled for several reasons. They're too long
			# or can break the config. I'm leaving them here, though, in case
			# they become useful.

			# # Show all possible next inputs, going multiple keys deep.
			# elems = [i[len(mode):] for i in chains if i.startswith(mode)]
			# # Show all possible binds that could be run.
			# elems = [binds[mode+i] for i in sub_elems]
			# # Show all possible next inputs, and their binds.
			# elems = ['{}:{}'.format(i, binds[mode+i]) for i in sub_elems]

			elems.sort()
			sub_string = ', '.join(elems)
			modestring = '%s%s (%s)' % (p_sym, mode, sub_string)
		else:
			modestring = '%s%s' % (p_sym, mode)
		return modestring

	# def get_modestring(mode):
	# 	return mode_to_var(mode)

	def gen_modevars():
		print('set $vi3m_ ' + get_mode_name(''))
		for mode in modes:
			var = mode_to_var(mode)
			modestr = get_mode_name(mode)
			print(f'set {var} {modestr}')

	gen_modevars()

	def gen_mode_exits():
		print('\tbindsym Return mode "default"')
		print('\tbindsym Escape mode "default"')
		print('\tbindsym Control+c mode "default"')
		print('\tbindsym Control+bracketleft mode "default"')

	def gen_prefix_mode():
		prefix_modestring = mode_to_var('')
		print('bindsym %s mode "%s"' % (p_key, prefix_modestring))
		print('mode "%s" {' % (prefix_modestring))
		gen_mode_exits()
		print('\tbindsym %s mode "default"' % (p_key))
		print('\tbindsym BackSpace mode "default"')

		elems = [i for i in chains if len(i) == 1]
		elems.sort()
		for elem in elems:
			key = elem
			if not key == key.lower():
				key = 'Shift+' + key.lower()
			print('\tbindsym %s %s; mode "default"'
				% (key, binds[elem]
			))

		for mode in modes:
			if len(mode) == 1:
				key = mode
				if not key == key.lower():
					key = 'Shift+' + key.lower()
				print('\tbindsym %s mode "%s"' % (key, mode_to_var(mode)))
		print('}')
		print()

	def gen_mode(mode):
		elems = [i for i in chains + modes if mode == i[:-1]]
		elems.sort()
		print('mode "%s" {' % mode_to_var(mode))
		gen_mode_exits()
		print('\tbindsym %s mode "default"' % (p_key))
		print('\tbindsym BackSpace mode "%s"' % mode_to_var(mode[:-1]))
		for elem in elems:
			key = elem.replace(mode, '', 1)
			if not key == key.lower():
				key = 'Shift+' + key.lower()
			if not elem in modes:
				print('\tbindsym %s %s; mode "default"'
					% (key, binds[elem]
				))
			else:
				print('\tbindsym %s mode "%s"' % (key, mode_to_var(elem)))
		print('}')
		print()

	gen_prefix_mode()
	for mode in modes:
		gen_mode(mode)

for config in configs:
	generate_config(config)
