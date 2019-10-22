#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pathlib import Path
import subprocess
import argparse
import shlex


def demo(**kwargs):
    """Test every voice for a given text or input file."""
    voice = None
    print('\nShowcasing avaliable voices:')
    temp = kwargs.copy()
    for voice in kwargs['voices']:
        temp['voice'] = voice
        command = compile_command(chosen_voice=voice, **temp)
        run(command)


def list_voices(voices):
    """List every avaliable voice in the voice_dir."""
    voice_dict = {voice.split('_')[2].split('.')[0]: voice for voice in voices}
    answer = ''
    for key, item in voice_dict.items():
        answer += f'{key} '
    print(f'\nShowing list of possible voices:\n{answer}')


def read_voices(path):
    """Given a voice_dir path, returns a list of absolute paths
    for all the voices there."""
    voices_path = Path(path).expanduser()
    voices = [voice.as_posix() for voice in voices_path.iterdir()
              if voice.is_file() and '.flitevox' in voice.name]
    return voices


def compile_command(**kwargs):
    """Given arguments, responsible to return a command string to be run."""
    command = f'flite --setf duration_stretch={kwargs["speed"]} '\
              f'-voice {kwargs["voice"]}'
    if kwargs['file']:
        command += ' -t {kwargs["text"]}'
    elif kwargs['text']:
        command += f''' -t "{kwargs['text']}"'''
    if kwargs['out']:
        command += f' -o {kwargs["out"]}'
    return command


def run(cmd):
    print(f'Command being run:\n{cmd}')
    subprocess.run(shlex.split(cmd))


def parse():
    args = argparse.ArgumentParser()
    args.add_argument('text', nargs='*', default='Hello World!'.split())
    args.add_argument(
        '-s', '--speed', dest='speed', default=0.9, type=str,
        help='Speed: Value form 0.1 to 1. The lesser the faster.'
    )
    args.add_argument(
        '-o', '--out', dest='output_file', type=str, default=None,
        help='Ouput: Filename if not to play, but to save in audio.'
    )
    args.add_argument(
        '-f', '--file', dest='input_file', type=str, default=None,
        help='File: Filename if input from a file.'
    )
    args.add_argument(
        '-v', '--voice', dest='voice', default='slt', type=str,
        help='Voice: voice 3 letter identifier to be chosen.')
    args.add_argument(
        '-l', '--list', dest='list', action='store_true',
        help='List: Print all the available voices from voice_dir.'
    )
    args.add_argument(
        '--demo', dest='demo', action='store_true',
        help='Demo: Run through every voice available.'
    )
    args.add_argument(
        '--dir', dest='voices_dir', type=str, default='~/.config/voices',
        help='Dir: Path where the *.flitevox voices are stored.'
    )
    parsed = args.parse_args()
    arg = {
        'list': parsed.list,
        'demo': parsed.demo,
        'out': parsed.output_file,
        'text': ' '.join(parsed.text),
        'file': parsed.input_file,
        'speed': parsed.speed,
        'voice': parsed.voice,
        'voices_dir': parsed.voices_dir,
        'voices': read_voices(parsed.voices_dir),
    }
    arg['voice'] = [voice for voice in arg['voices']
                    if arg['voice'] in voice][0]
    return arg


def main():
    arg = parse()
    if arg['list']:
        list_voices(arg['voices'])
    elif arg['demo']:
        demo(**arg)
    else:
        command = compile_command(**arg)
        run(command)


if __name__ == "__main__":
    main()
