import sys
import argparse as ap
import subprocess as sp

# Command line argument parsing
parser = ap.ArgumentParser(prog="python nstatus.py",
                           epilog="""Displays useful information about
                           nodes in the eitan partition and jobs running on
                           them. It's recommended to add the following alias
                           to the appropriate shell file:
                           alias nstat="python /path/to/nstats.py" (for bash).
                           This script requiers python3, which, on
                           lighthouse, can be loaded by invoking 'module load
                           python3.7-anaconda'.""")
parser.add_argument("-l", "--list", action="store_true", default=False,
                    help="list all nodes belonging to the eitan partition")
parser.add_argument("-s", "--short", action="store_true", default=False,
                    help="print only number of available CPUs for each node")
parser.add_argument("-j", "--jobs", action="store_true", default=False,
                    help="display jobs being run on each node (and users)")
parser.add_argument("-n", dest="node", type=str, nargs="+", default=None,
                    help="node or list of nodes to display information for")
args = parser.parse_args()

# List of all nodes in the eitan partition
nlist = ["lh0057", "lh0058", "lh0059", "lh0060",
         "lh0071", "lh0072", "lh0073", "lh0074"]

# Output node list for eitan partition and exit
if args.list:
    print("Nodes in eitan partition:")
    for i in nlist:
        print(i)
    sys.exit(0)

# Set list of nodes to output info for based on command line argument
if args.node:
    nlist = []
    # Parse node range
    for n in args.node:
        if "-" in n:
            l = int(n[4:-1].split("-")[0][-2:])
            u = int(n[4:-1].split("-")[1][-2:])
            for i in range(u-l+1):
                nlist.append(f"lh{l+i:04d}")
        else:
            nlist.append(n)

# Gather information about jobs being run by users in the eitan partition
U = sp.run(["squeue", "-h", "-p", "eitan", "-o", "'%N|%i|%u|%C|%D|%L'"],
           capture_output=True)
jobs = U.stdout.decode("utf-8").split('\n')

# General node information
nodes = {}
for n in nlist:
    nodes[f"{n}"] = {}
    N = sp.run(["sinfo", "-h", "-n", n, "-o", "%e %m %O %C"],
                capture_output=True)
    out = N.stdout.decode("utf-8").split()
    cpus = out[3].split('/')
    nodes[f"{n}"]["CPU Load"] = out[2]
    nodes[f"{n}"]["Allocated Memory"] = (f"{(int(out[1])-int(out[0]))/1024:.1f}"
                                         f"/{int(out[1])/1024:.1f} GB")
    nodes[f"{n}"]["Available Memory"] = (f"{int(out[0])/1024:.1f}"
                                    f"/{int(out[1])/1024:.1f} GB")
    nodes[f"{n}"]["Allocated CPUs"] = (f"{cpus[0]}/{cpus[3]}")
    nodes[f"{n}"]["Idle CPUs"] = f"{cpus[1]}/{cpus[3]}"
    if args.jobs:
        nodes[f"{n}"]["Jobs"] = f"\n{'Curent jobs':18}\n"
        for j in jobs:
            ls = j[1:-1].split("|")
            if n in ls[0]:
                nodes[f"{n}"]["Jobs"] += (
                    f"- {ls[1]} by {ls[2]:^8} using {int(ls[3])//int(ls[4]):2}"
                    f"/{cpus[3]:2} CPUs. {ls[5]:>11} left\n"
                )

# Output accumulated node information
for n in nlist:
    if args.short:
        print(f"{n} {nodes[n]['Idle CPUs']:2} CPUs available")
    else:
        print('\n')
        print(f"{24*'='} {n.upper()} {24*'='}", end='\n\n')
        for k in ["CPU Load", "Idle CPUs", "Allocated CPUs",
                  "Available Memory", "Allocated Memory"]:
            print(f"{k:18}{nodes[f'{n}'][k]}")
        if args.jobs:
            print(nodes[f"{n}"]["Jobs"])
        else:
            print()
        print(f"{56*'='}", end="\n\n")

