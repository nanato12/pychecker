import shlex
import subprocess
import sys
from importlib.util import find_spec
from modulefinder import ModuleFinder


def exec_cmd(cmd: str) -> None:
    with open("/dev/null", "w") as devnull:
        subprocess.Popen(shlex.split(cmd), stdout=devnull, stderr=devnull)


finder = ModuleFinder()
finder.run_script(sys.argv[1])

for module in finder.badmodules.keys():
    try:
        if not find_spec(module):
            exec_cmd("pip3 install {}".format(module))
    except Exception:
        pass
