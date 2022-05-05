import re
import numpy as np

atom1 = "Ga"
atom2 = "Te"
states = np.arange(0)

atom1_s = np.arange(0)
atom1_p = np.arange(0)
atom1_d = np.arange(0)
atom2_s = np.arange(0)
atom2_p = np.arange(0)
atom2_d = np.arange(0)
filename = "gate.pdos.out"
with open(filename, mode="r") as outfile:
    for lines in outfile:
        if "Problem Sizes" in lines:
            snumber = outfile.readline().split()[2]
            break
    for lines in outfile:
        if "read from pseudopotential files" in lines.strip():
            break
    outfile.readline()
    for i in range(int(snumber)):
        states = np.append(states, outfile.readline())
    for state in states:
        if "l=0" in state:
            if atom1 in state:
                atom1_s = np.append(atom1_s, state)
            if atom2 in state:
                atom2_s = np.append(atom2_s, state)
        if "l=1" in state:
            if atom1 in state:
                atom1_p = np.append(atom1_p, state)
            if atom2 in state:
                atom2_p = np.append(atom2_p, state)
        if "l=2" in state:
            if atom1 in state:
                atom1_d = np.append(atom1_d, state)
            if atom2 in state:
                atom2_d = np.append(atom2_d, state)

exec("{} = atom1_s".format(atom1 + "_s"))
exec("{} = atom1_p".format(atom1 + "_p"))
exec("{} = atom1_d".format(atom1 + "_d"))
exec("{} = atom2_s".format(atom2 + "_s"))
exec("{} = atom2_p".format(atom2 + "_p"))
exec("{} = atom2_d".format(atom2 + "_d"))


def show(lst):
    def names(obj, namespace):
        return [name for name in namespace if namespace[name] is obj]

    makefile = names(lst, globals())
    f = open(f"{makefile[1]}.dat", mode="w")
    for item in lst:
        temp = re.finditer(f'.*?#(?P<final>.*?): atom', item, re.S)
        for item in temp:
            f.write(item.group("final") + " ")
    f.close()

sum = [atom1_s, atom1_p, atom1_d, atom2_s, atom2_p, atom2_d]
for item in sum:
    show(item)
