import pathlib
import webbrowser

webbrowser.open(
    'http://localhost:4000/space/' + pathlib.Path.cwd().name
)
