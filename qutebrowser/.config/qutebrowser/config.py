import os
import shlex
import subprocess
import sys

from qutebrowser.api import interceptor
from qutebrowser.config.config import ConfigContainer  # noqa: F401
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401


config = config  # type: ConfigAPI # noqa: F821
c = c  # type: ConfigAPI # noqa: F821

# PATH {{{
if sys.platform == "darwin":
    os.environ["PATH"] += os.pathsep + os.path.expanduser("~/.pyenv/shims")
    os.environ["PATH"] += os.pathsep + "/usr/local/bin"
# }}}
# CONFIGURATION {{{
config.load_autoconfig()
# c.backend = 'webkit'
c.new_instance_open_target = "window"
c.new_instance_open_target_window = "last-focused"
c.scrolling.bar = "always"
c.scrolling.smooth = True
c.auto_save.session = True
c.session.lazy_restore = True
c.downloads.location.suggestion = "both"
c.downloads.location.directory = "~/Downloads"
c.downloads.location.prompt = False
c.downloads.remove_finished = 5000
c.zoom.default = 110
# Search Engines
c.url.default_page = "about:blank"
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    # 'DEFAULT'   : 'https://www.google.com/search?q={}',
    "d": "https://duckduckgo.com/?q={}",
    "e": "https://www.ecosia.org/search?q={}",
    "s": "https://searx.org/?q={}",
    "g": "https://www.google.com/search?q={}",
    "br": "https://www.google.com/search?q={}&lr=lang_pt",
    "wk": "https://en.wikipedia.org/wiki/{}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "ggit": "https://github.com/search?q={}",
    "ggist": "https://gist.github.com/search?q={}",
    "def": "https://www.google.com/search?q=define {}",
    "gmaps": "https://www.google.com/maps/place/{}",
    "imdb": "https://www.imdb.com/find?q={}",
    "rt": "https://www.rottentomatoes.com/search/?search={}",
    "tmdb": "https://www.themoviedb.org/search?query={}&language=en-US",
    "img": "https://imgur.com/search?q={}",
    "tpb": "https://thepiratebay.org/s/?q={}&=on&page=0&orderby=99",
    "13": "https://1337x.to/search/{}/1/",
    "img": "https://imgur.com/search?q={}",
    "am": "https://www.amazon.com/s/field-keywords={}",
    "ml": "https://lista.mercadolivre.com.br/{}",
    "olx": "https://mt.olx.com.br/?q={}",
    "ebay": "https://www.ebay.com/sch/{}",
    "ud": "http://www.urbandictionary.com/define.php?term={}",
    "4": "https://www.4chan.org/{}",
    "r": "https://reddit.com/r/{}",
    "rq": "https://www.reddit.com/search?q={}",
    "aw": "https://wiki.archlinux.org/index.php?search={}",
    "aur": "https://aur.archlinux.org/packages/?O=0&K={}",
    "yts": "https://yts.mx/browse-movies/{}",
    "libgen": "http://gen.lib.rus.ec/search.php?req={}&open=0&res=25&view=simple",
}
# Completions
c.completion.web_history.exclude = [
    "*://*.google.com.br/*",
    "*://*.google.com/*",
    "*://*.duckduckgo.com/*",
    "*://*.imdb.com/*",
    "*://*.1337x.to/*",
    "*://thepiratebay.org/*",
    "*://yts.mx/*",
]
c.completion.cmd_history_max_items = 20
c.completion.web_history.max_items = -1
c.completion.height = "100%"
c.completion.shrink = True
# Hints
c.hints.mode = "letter"
# c.hints.chars = 'asdfghjklqwertyuiopzxcvbnm'
# c.hints.chars = "asdfghjklqweruiop"
c.hints.chars = "qwertasdfgzxcvb"
# Tabs
c.tabs.background = True
c.tabs.last_close = "close"
c.tabs.title.format = "{audio}{private}{index}: {current_title}"
c.window.title_format = "{private}{perc}{host}"
# Contents
c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36"
c.content.headers.custom = {
    "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
}
c.content.headers.accept_language = "en-US,en;q=0.5"
c.content.geolocation = False
c.content.headers.do_not_track = True
c.content.host_blocking.enabled = True
c.content.notifications = False
c.content.javascript.enabled = True
c.content.ssl_strict = False
c.content.pdfjs = True
# c.content.webgl = False
c.content.plugins = True
c.content.host_blocking.enabled = True
c.content.host_blocking.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    # "https://testpages.adblockplus.org/en/abp-testcase-subscription.txt",
    # "/home/elodin/.config/qutebrowser/blocklist.txt",
]
# }}}
# DOMAIN CONFIG {{{
config.set("content.autoplay", False, "*.youtube.com")
c.content.host_blocking.whitelist = [
    "thepiratebay.org",
]
ALLOWED = """
web.whatsapp.com
www.netflix.com
gitlab.com
*.youtube.com
imgur.com
"""
for url in ALLOWED.strip().splitlines():
    if url.strip():
        config.set("content.javascript.enabled", True, url)
BLOQUED = """
rarbgmirror.org
thepiratebay.org
mercadolivre.com
eztv.it
yts.mx
"""
for url in BLOQUED.strip().splitlines():
    if url.strip():
        config.set("content.javascript.enabled", False, url)

config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.80 Safari/537.36",
    "web.whatsapp.com",
)
# }}}
# BINDINGS
c.bindings.commands["normal"] = {}
# USERSCRIPTS {{{
if sys.platform == "darwin":
    c.aliases["fire"] = "spawn open -a firefox {url}"
    config.bind(",f", "spawn open -a firefox {url}")
elif sys.platform == "linux":
    c.aliases["fire"] = "spawn firefox {url}"
    config.bind(",f", "open firefox {url}")
# readability
config.bind(
    "<Ctrl-r>",
    "spawn --userscript /usr/share/qutebrowser/userscripts/readability",
    mode="normal",
)
# keepass
if sys.platform == "darwin":
    keepass_command = "spawn --userscript ~/.config/qutebrowser/userscripts/qute-keepass -p ~/Sync/keepass/keepass.kdbx"
elif sys.platform == "linux":
    keepass_command = "spawn --userscript /usr/share/qutebrowser/userscripts/qute-keepass -p ~/Sync/keepass/keepass.kdbx"
config.bind(",k", keepass_command, mode="normal")
config.bind("<Ctrl-k>", keepass_command, mode="insert")
# mpv
config.bind(";p", "hint links spawn --userscript view_in_mpv {hint-url}", mode="normal")
config.bind(";P", "spawn --userscript view_in_mpv", mode="normal")
# OLD way
# transmission
if sys.platform == "linux":
    transmission_command = 'hint links spawn transmission-remote -a "{hint-url}"'
    transmissoin_remote = 'hint links spawn tremc -c eolian "{hint-url}"'
    config.bind(";t", transmission_command, mode="normal")
    config.bind(";q", transmissoin_remote, mode="normal")
# streamlink peerflix
streamlink_command = "spawn -v -d  streamlink -p mpv"
config.bind(
    ";s", f"hint links {streamlink_command} " + "{hint-url} 480p", mode="normal"
)
config.bind(";S", f"{streamlink_command} " + "{url} 480p", mode="normal")
# config.bind(';x', '''hint links spawn --userscript quteflix {hint-url}''', mode='normal')
config.bind(
    ";x",
    '''hint links spawn -v -u /usr/bin/urxvt -title peerflix -e /usr/bin/zsh -c "/home/elodin/bin/quteflix '{hint-url}'"''',
    mode="normal",
)
# config.bind(';x', '''hint links spawn -v -d /usr/bin/urxvt -title peerflix -e /usr/bin/zsh -c "peerflix '{hint-url}' --mpv --path $HOME/Downloads"''', mode='normal')
config.bind(
    ";X",
    '''hint links spawn -v -d /usr/bin/urxvt -title peerflix -e /usr/bin/zsh -c "peerflix '{hint-url}' --mpv --path $HOME/Downloads -l"''',
    mode="normal",
)
config.bind(";v", "hint links spawn -v -d firefox {hint-url}", mode="normal")
# }}}
# LEADER UNITE/DENITE LIKE {{{
c.bindings.commands["normal"]["b"] = "set-cmd-text -s :buffer"
c.bindings.commands["normal"][",b"] = "set-cmd-text -s :buffer "
c.bindings.commands["normal"][",h"] = "set-cmd-text -s :help "
c.bindings.commands["normal"][",q"] = "set-cmd-text :quickmark-"
c.bindings.commands["normal"][",m"] = "set-cmd-text :bookmark-"
c.bindings.commands["normal"][",d"] = "set-cmd-text :download"
c.bindings.commands["normal"][",e"] = "set-cmd-text :session-load "
c.bindings.commands["normal"][",j"] = "set content.javascript.enabled false"
c.bindings.commands["normal"][",J"] = "set content.javascript.enabled true"
# }}}
# HINTS{{{
c.bindings.commands["normal"]["f"] = "hint"
c.bindings.commands["normal"]["F"] = "hint all tab-bg"
c.bindings.commands["normal"][";f"] = "hint all tab-fg"
c.bindings.commands["normal"][";b"] = "hint all tab-bg"
c.bindings.commands["normal"][";r"] = "hint --rapid links tab-bg"
c.bindings.commands["normal"][";R"] = "hint --rapid links window"
c.bindings.commands["normal"][";w"] = "hint all window"
c.bindings.commands["normal"][";W"] = "hint links run open -p {hint-url}"
c.bindings.commands["normal"][";y"] = "hint links yank"
c.bindings.commands["normal"][";a"] = "hint inputs"
c.bindings.commands["normal"][";i"] = "hint images"
c.bindings.commands["normal"][";I"] = "hint images tab"
c.bindings.commands["normal"][";d"] = "hint links download"
c.bindings.commands["normal"][";h"] = "hint links hover"
# }}}
# COMMAND MODE {{{
c.bindings.commands["command"] = {
    "<Ctrl-A>": "rl-beginning-of-line",
    "<Ctrl-E>": "rl-end-of-line",
    "<Ctrl-K>": "rl-unix-line-discard",
    "<Ctrl-J>": "rl-kill-line",
    "<Ctrl-B>": "rl-backward-word",
    "<Ctrl-F>": "rl-forward-word",
    "<Ctrl-W>": "rl-backward-kill-word",
    # '<Ctrl->'   : 'rl-kill-word',
    "<Ctrl-D>": "completion-item-del",
    "<Ctrl-H>": "rl-unix-filename-rubout",
    "<Ctrl-Y>": "rl-yank",
    "<Tab>": "completion-item-focus next",
    "<Shift-Tab>": "completion-item-focus prev",
    "<Ctrl-P>": "command-history-prev",
    "<Ctrl-N>": "command-history-next",
    "<Escape>": "leave-mode",
    "<Return>": "command-accept",
}
# }}}
# CARET MODE {{{
c.bindings.commands["caret"] = {
    "<Escape>": "leave-mode",
    "c": "enter-mode normal",
    "v": "toggle-selection",
    "<Space>": "toggle-selection",
    "<Ctrl-Space>": "drop-selection",
    "y": "yank selection",
    "Y": "yank selection -s",
    "<Return>": "yank selection",
    "G": "move-to-end-of-document",
    "gg": "move-to-start-of-document",
    "[": "move-to-start-of-prev-block",
    "]": "move-to-start-of-next-block",
    "{": "move-to-end-of-prev-block",
    "}": "move-to-end-of-next-block",
    "$": "move-to-end-of-line",
    "0": "move-to-start-of-line",
    "h": "move-to-prev-char",
    "j": "move-to-next-line",
    "k": "move-to-prev-line",
    "l": "move-to-next-char",
    "w": "move-to-next-word",
    "b": "move-to-prev-word",
    "e": "move-to-end-of-word",
    "H": "scroll left",
    "J": "scroll down",
    "K": "scroll up",
    "L": "scroll right",
}
# }}}
# INSERT: {{{
config.bind("<Ctrl-E>", "open-editor", mode="insert")
config.bind("<Escape>", "leave-mode", mode="insert")
config.bind("<Shift-Ins>", "insert-text {primary}", mode="insert")
# }}}
# NORMAL MODE {{{
c.bindings.commands["normal"][":"] = "set-cmd-text :"
# Navigation {{{
c.bindings.commands["normal"]["<Ctrl-A>"] = "navigate increment"
c.bindings.commands["normal"]["<Ctrl-X>"] = "navigate decrement"
c.bindings.commands["normal"]["h"] = "scroll left"
c.bindings.commands["normal"]["j"] = "scroll down"
c.bindings.commands["normal"]["k"] = "scroll up"
c.bindings.commands["normal"]["l"] = "scroll right"
c.bindings.commands["normal"]["<Ctrl-B>"] = "scroll-page 0 -1"
c.bindings.commands["normal"]["<Ctrl-F>"] = "scroll-page 0 1"
c.bindings.commands["normal"]["<Ctrl-D>"] = "scroll-page 0 0.5"
c.bindings.commands["normal"]["<Ctrl-U>"] = "scroll-page 0 -0.5"
c.bindings.commands["normal"]["G"] = "scroll-to-perc 100"
c.bindings.commands["normal"]["gg"] = "scroll-to-perc 0"
c.bindings.commands["normal"]["H"] = "back"
c.bindings.commands["normal"]["L"] = "forward"
c.bindings.commands["normal"]["[["] = "navigate prev"
c.bindings.commands["normal"]["]]"] = "navigate next"
c.bindings.commands["normal"]["{{"] = "navigate prev -t"
c.bindings.commands["normal"]["}}"] = "navigate next -t"
c.bindings.commands["normal"]["r"] = "reload"
c.bindings.commands["normal"]["R"] = "reload -f"
c.bindings.commands["normal"]["ZQ"] = "quit"
c.bindings.commands["normal"]["ZZ"] = "quit --save"
c.bindings.commands["normal"][
    "<Escape>"
] = "clear-keychain ;; search ;; fullscreen --leave"
c.bindings.commands["normal"]["<Return>"] = "follow-selected"
# }}}
# Search {{{
c.bindings.commands["normal"]["/"] = "set-cmd-text /"
c.bindings.commands["normal"]["?"] = "set-cmd-text ?"
c.bindings.commands["normal"]["N"] = "search-prev"
c.bindings.commands["normal"]["n"] = "search-next"
# }}}
# Utils {{{
c.bindings.commands["normal"]["q"] = "record-macro"
c.bindings.commands["normal"]["@"] = "run-macro"
c.bindings.commands["normal"]["="] = "zoom"
c.bindings.commands["normal"]["+"] = "zoom-in"
c.bindings.commands["normal"]["-"] = "zoom-out"
# }}}
# Modes ENTER/EXIT {{{
# ENTER
config.bind("i", "enter-mode insert", mode="normal")
config.bind("v", "enter-mode caret", mode="normal")
config.bind("`", "enter-mode set_mark", mode="normal")
config.bind("''", "enter-mode jump_mark", mode="normal")
config.bind("<Ctrl-V>", "enter-mode passthrough", mode="normal")
# EXIT
config.bind("<Escape>", "leave-mode", mode="hint")
config.bind("<Ctrl-V>", "leave-mode", mode="register")
config.bind("<Ctrl-V>", "enter-mode passthrough", mode="normal")
# }}}
# TABS{{{
c.bindings.commands["normal"]["T"] = "tab-focus"
c.bindings.commands["normal"]["J"] = "tab-next"
c.bindings.commands["normal"]["K"] = "tab-prev"
c.bindings.commands["normal"]["th"] = "back -t"
c.bindings.commands["normal"]["tl"] = "forward -t"
c.bindings.commands["normal"]["D"] = "tab-close -o"
c.bindings.commands["normal"]["d"] = "tab-close"
c.bindings.commands["normal"]["g$"] = "tab-focus -1"
c.bindings.commands["normal"]["g0"] = "tab-focus 1"
c.bindings.commands["normal"]["g^"] = "tab-focus 1"
c.bindings.commands["normal"]["gC"] = "tab-clone"
c.bindings.commands["normal"]["gm"] = "tab-move"
c.bindings.commands["normal"]["gl"] = "tab-move +"
c.bindings.commands["normal"]["gh"] = "tab-move -"
c.bindings.commands["normal"]["gu"] = "navigate up"
c.bindings.commands["normal"]["gU"] = "navigate up -t"
c.bindings.commands["normal"]["go"] = "set-cmd-text :open {url:pretty}"
c.bindings.commands["normal"]["gO"] = "set-cmd-text :open -t -r {url:pretty}"
c.bindings.commands["normal"]["u"] = "undo"
# }}}
# Paste to{{{
c.bindings.commands["normal"]["po"] = "open -- {clipboard}"
c.bindings.commands["normal"]["pb"] = "open -b -- {clipboard}"
c.bindings.commands["normal"]["pt"] = "open -t -- {clipboard}"
c.bindings.commands["normal"]["pw"] = "open -w -- {clipboard}"
# }}}
# Open{{{
c.bindings.commands["normal"]["o"] = "set-cmd-text -s :open"
c.bindings.commands["normal"]["O"] = "set-cmd-text -s :open -t"
c.bindings.commands["normal"]["wo"] = "set-cmd-text -s :open -w"
c.bindings.commands["normal"]["wp"] = "set-cmd-text -s :open -p"
c.bindings.commands["normal"]["wh"] = "back -w"
c.bindings.commands["normal"]["wl"] = "forward -w"
# }}}
# Yanks{{{
c.bindings.commands["normal"]["yd"] = "yank domain"
c.bindings.commands["normal"]["yp"] = "yank pretty-url"
c.bindings.commands["normal"]["yt"] = "yank title"
c.bindings.commands["normal"]["yy"] = "yank"
c.bindings.commands["normal"]["yD"] = "yank domain -s"
c.bindings.commands["normal"]["yP"] = "yank pretty-url -s"
c.bindings.commands["normal"]["yT"] = "yank title -s"
c.bindings.commands["normal"]["yY"] = "yank -s"
c.bindings.commands["normal"]["yi"] = "hint images run open {hint-url}"
# }}}
# Prompt Bindings {{{:
c.bindings.commands["prompt"] = {
    "<Alt-B>": "rl-backward-word",
    "<Alt-Backspace>": "rl-backward-kill-word",
    "<Alt-D>": "rl-kill-word",
    "<Alt-F>": "rl-forward-word",
    "<Ctrl-?>": "rl-delete-char",
    "<Ctrl-A>": "rl-beginning-of-line",
    "<Ctrl-B>": "rl-backward-char",
    "<Ctrl-E>": "rl-end-of-line",
    "<Ctrl-F>": "rl-forward-char",
    "<Ctrl-H>": "rl-backward-delete-char",
    "<Ctrl-K>": "rl-kill-line",
    "<Ctrl-U>": "rl-unix-line-discard",
    "<Ctrl-W>": "rl-unix-word-rubout",
    "<Ctrl-X>": "prompt-open-download",
    "<Ctrl-Y>": "rl-yank",
    "<Down>": "prompt-item-focus next",
    "<Escape>": "leave-mode",
    "<Return>": "prompt-accept",
    "<Shift-Tab>": "prompt-item-focus prev",
    "<Tab>": "prompt-item-focus next",
    "<Up>": "prompt-item-focus prev",
}
# }}}
# }}}
os.environ["PATH"] += ":/home/elodin/.local/bin"


def filter_yt(info: interceptor.Request):
    url = info.request_url
    url_str = url.toString()
    if "youtube.com/watch?v=" in url_str:
        print(url_str)
        if "pbj=1" in url_str:
            print("blocking pbj=1")
            info.block()
        else:
            command = f"mpv {url_str}".replace("&pbjreload=10", "")
            subprocess.Popen(shlex.split(command))
            print(command)
            c.content.auto_play = False
            # info.block()
# interceptor.register(filter_yt)
config.source('pids.py')
# vim: fo=tcq fdm=marker tw=0
