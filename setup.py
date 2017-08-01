import sys
import subprocess

print("LOL")
print(sys.executable)

print(subprocess.check_output('/usr/bin/isolate --box-id 10 --init --cg'))
print(subprocess.check_output('/usr/bin/isolate --box-id 10 --cleanup --cg'))

