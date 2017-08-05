import sys
import subprocess

print(sys.executable)

path = subprocess.check_output('/usr/bin/isolate --box-id 10 --init --cg'.split())
print(path)

with open(path + '/box/Lol.java', 'w') as c:
    c.write('''
public class Lol {
    public static void main(String[] args) {
        System.out.println("lolz");
    }
}''')

print(subprocess.check_output('/usr/bin/isolate --box-id 10 --run --cg -p -d /etc/java-8-openjdk -- /usr/bin/javac Lol.java'.split()))
print(subprocess.check_output('/usr/bin/isolate --box-id 10 --run --cg -p -d /etc/java-8-openjdk -- /usr/bin/java Lol'.split()))
print(subprocess.check_output('/usr/bin/isolate --box-id 10 --cleanup --cg'.split()))

