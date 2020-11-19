import shlex
import subprocess
import sys
from importlib.util import find_spec
from modulefinder import ModuleFinder
from time import sleep


def exec_cmd(cmd: str) -> None:
    with open("/dev/null", "w") as devnull:
        subprocess.Popen(shlex.split(cmd), stdout=devnull, stderr=devnull)
        sleep(5)


finder = ModuleFinder()
finder.run_script(sys.argv[1])

for module in finder.badmodules.keys():
    try:
        if not find_spec(module):
            print(f"missing module: {module}")
            exec_cmd(f"pip3 install {module}")
    except Exception:
        pass
