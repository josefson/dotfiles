#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import shutil
import click


@click.command()
@click.option('--libpath', help='root path for mpd library.', required=True)
@click.option('--playlist', help='playlist file to be read.',
              required=True, type=click.File('r'))
def main(libpath, playlist):
    songs = [song.strip() for song in playlist.readlines()]
    dest = f"{os.path.expanduser('~/Downloads/')}"\
           f"playlist_{playlist.name.split('/')[-1].split('.')[0]}"
    try:
        os.mkdir(dest)
        for index, song in enumerate(songs):
            src = f'{libpath}/{song}'
            dst = f"{dest}/{index}-{song.replace('/', '-')}"
            print(src, dst)
            shutil.copyfile(src, f'{dst}')
    except FileExistsError:
        shutil.rmtree(dest)
    except Exception as e:
        print(f'{e}')


if __name__ == "__main__":
    main()
