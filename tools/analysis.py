import os
from os import path
from pathlib import Path
import sys
import subprocess
from termcolor import colored

pathSource = "src/"
pathTest = "teschbench/"
pathSim = "simulation/"
pathOutput = "output/"

cmd = "ghdl"
cmd_sim = "gtkwave"
opt_build   = ["-a", "-e", "-r"]
opt_lib     = ["--ieee=synopsys", "--ieee=standard"]
opt_sim     = "--vcd="
opt_sttime  = "--stop-time="
command     = ["Analysis", "Elaborate", "Run"]
color       = ["red", "green", "yellow_4b"]
status      = ["FAIL", "OK", "WARNING"]

def printLog(build, name, stt):
    print( build + " " + name + "\t\t\t\t\t\t" + "[" + colored(status[stt], color[stt]) +"]" )

#analysis all file in src/ folder
def analysisSource():
    stt = 1
    for root, dirs, files in os.walk(os.path.abspath(pathSource)):
        for file in files:
            pth = os.path.join(root, file)
            stt = 1
            try:
                subprocess.run([cmd, opt_build[0], opt_lib[0], pth], cwd=pathOutput)
                subprocess.check_output([cmd, opt_build[0], opt_lib[0], pth], cwd=pathOutput)
            except:
                 stt = 0
            printLog(command[0], file, stt)


def analysisFile(file):
    stt = 1
    file = os.path.abspath(file)
    filename = Path(file).name
    for build in opt_build:
        stt = 1
        if build == "-a":
            try:
                subprocess.run([cmd, build, opt_lib[0], file], cwd=pathOutput)
                subprocess.check_output([cmd, build, opt_lib[0], file], cwd=pathOutput)
            except:
                stt = 0
                printLog(command[0], filename, stt)
                return
            printLog(command[0], filename, stt)
        else:
            module = filename.split('.')
            module = module[0]
            if build == "-e":
                try:
                    subprocess.run([cmd, build, opt_lib[0], module], cwd=pathOutput)
                    subprocess.check_output([cmd, build, opt_lib[0], module], cwd=pathOutput)
                except:
                    stt = 0
                    printLog(command[1], filename, stt)
                    return
                printLog(command[1], filename, stt)
            else :
                #run -- create file simulation and ...
                ans = input("\nDo you want to simulate (y/N): ")
                if ans == 'y' or ans == 'Y' :
                    #run -- create file simulate
                    stop = input("Enter stop time (ns): ")
                    _filesim = os.path.abspath(pathSim + module + ".vcd")
                    _stoptime = opt_sttime + stop + "ns"
                    try:
                        subprocess.run([cmd, build, opt_lib[0], module, opt_sim + _filesim, _stoptime], cwd=pathOutput)
                        subprocess.check_output([cmd, build, opt_lib[0], module, opt_sim + _filesim, _stoptime], cwd=pathOutput)
                    except:
                        stt = 0
                        printLog(command[2], filename, stt)
                        return
                    printLog(command[2], filename, stt)
                    ans = input("\nDo you want to run simulate (y/N): ")
                    if ans == 'y' or ans == 'Y':
                        try:
                            subprocess.run([cmd_sim, _filesim], cwd=pathSim)
                        except:
                            stt = 0
                            printLog(command[2], _filesim, stt)
                            return
                        printLog([command[2], _filesim, stt])
                else : #when ans is "No"
                    #just run module
                    pass

if len(sys.argv) > 1:
    try:
        analysisSource()
        analysisFile(sys.argv[1])
    except:
        print("\n" + colored("Error: ", "red") + " exception.")
else:
    print(colored("Error: ", "red") + "no input files")