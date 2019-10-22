c = get_config()
c.TerminalInteractiveShell.editing_mode = 'vi'
c.InteractiveShellApp.exec_lines.append(
    "try:\n    %load_ext ipython_autoimport\nexcept ImportError: pass")
c.InteractiveShellApp.exec_lines = []
c.InteractiveShellApp.exec_lines.append('%load_ext autoreload')
c.InteractiveShellApp.exec_lines.append('%autoreload 2')
c.InteractiveShellApp.exec_lines.append('print("Warning: disable autoreload in ipython_config.py to improve performance.")')
