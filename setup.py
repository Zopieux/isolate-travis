import sys
import subprocess
import os

print(sys.executable)

path = subprocess.check_output('/usr/bin/isolate --box-id 10 --init --cg'.split()).decode().strip()
print(path)

with open(path + '/box/lol.hs', 'w') as c:
    c.write('''
module Main where main = putStrLn "42"
''')

os.mkdir('/tmp/ghcbite')
os.chmod('/tmp/ghcbite', 0o777)
os.system('ls /usr/lib/ghc/package.conf.d')
os.system('/usr/bin/isolate --box-id 10 --run --cg --env=PATH=/usr/bin:/bin:/usr/local/bin -p -d /etc/alternatives -d /var/lib/ghc -d /tmp=/tmp/ghcbite:rw -- /usr/bin/ghc -v3 -dynamic -O2 -o lol lol.hs')
os.system('/usr/bin/isolate --box-id 10 --run --cg -p -d /etc/alternatives -d /var/lib/ghc -d /tmp=/tmp/ghcbite:rw -- ./lol')
os.system('/usr/bin/isolate --box-id 10 --cleanup --cg')

