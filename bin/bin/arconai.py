#!/usr/bin/env python
from bs4 import BeautifulSoup as bs4
from selenium import webdriver
import tempfile
import requests
import sys
import os
import re


class Base:
    base_url = 'https://www.arconaitv.us/'


class Show(Base):

    def __init__(self, title, link):
        self.id = link[link.find('=') + 1:]
        self.title = title
        self.link = self.base_url + link


class Arconai(Base):

    @classmethod
    def shows(self):
        """Read shows into list of Shows."""
        response = requests.get(self.base_url)
        source = response.text
        soup = bs4(source, 'html.parser')
        show_tags = soup.select('a[title]')
        show_tags = [tag for tag in show_tags
                     if tag.has_attr('class') is False]
        shows = [Show(tag['title'], tag['href']) for tag in show_tags]
        return shows


class Driver:

    def __init__(self):
        self.log = tempfile.NamedTemporaryFile(mode='w')
        self._stream = None
        # driver setup
        options = webdriver.ChromeOptions()
        options.add_argument('headless')
        options.add_argument('--log-net-log={}'.format(self.log.name))
        self.driver = webdriver.Chrome(chrome_options=options)

    def stream(self, show):
        self.driver.get(show.link)
        self.driver.close()
        self.driver.quit()
        with open(self.log.name, 'r') as log:
            dump = log.read()
        pattern = r'https:\/\/videoserver[0-9].org\/live.+m3u8'
        link = re.findall(pattern, dump)[-1]
        self.log.close()
        return link


VENV = 'streamlink'


def choose(shows):
    for show in shows.values():
        print('{} - {}'.format(show.id, show.title))
    chosen = input('Enter the selected show number:\n')
    print(shows[chosen].title)
    return shows[chosen]


def play(show):
    streamlink = Driver().stream(show)
    if 'linux' in sys.platform:
        command = 'echo "streamlink -p mpv {} best" | xsel --clipboard'
        command = command.format(streamlink)
    elif 'darwin' in sys.platform:
        command = 'echo "workon {}; streamlink -p mpv {} best" | pbcopy'
        command = command.format(VENV, streamlink)
    os.system(command)


def main():
    shows = Arconai.shows()

    if len(sys.argv) == 1:
        shows = {show.id: show for show in shows}
        chosen = choose(shows)
        play(chosen)
    else:
        query = ' '.join(sys.argv[1:])
        filtered = [show for show in shows
                    if query.lower() in show.title.lower()]
        if len(filtered) == 1:
            print('{}'.format(filtered[0].title))
            play(filtered[0])
        elif len(filtered) > 1:
            # if query yields > 1 then choose()
            shows = {show.id: show for show in filtered}
            chosen = choose(shows)
            play(chosen)
        else:
            print('Nothing found for {}'.format(sys.argv[1:]))
            sys.exit(1)
    print('Command copied to clipboard.')


if __name__ == "__main__":
    main()
