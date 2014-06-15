#!/usr/bin/env python


import subprocess
import os
import threading
import datetime
import signal
import sys
from subprocess import Popen

BASE_PATH   = '/Users/cevaris/Documents/workspace/scron'
WORKER_PATH = os.path.join(BASE_PATH, 'worker.py')
DETACHED_PROCESS = 0x00000008

DELTAS = []

def stats():
    if DELTAS:
        print 'Average Delta: ', reduce(lambda x, y: x + y, DELTAS) / len(DELTAS)

def signal_handler(signal, frame):
    stats()
    sys.exit(0)


def do_work(*args, **kwargs):
    repeat   = kwargs.pop('repeat')
    time     = kwargs.pop('time')
    started  = kwargs.pop('started')
    executed = datetime.datetime.now()
    delta    = executed - started
    
    DELTAS.append(delta)
    stats()

    print "Executed worker scheduled at %d in %s" % (time, str(delta))

    if repeat:
        schedule(time, args[0], args[1], repeat)

    command = [args[0]]
    [command.append(arg) for arg in args[1]]

    # Fork process
    try:
        pid = os.fork()
    except OSError, e:
        print e
        sys.exit(1)
    if pid == 0:
        ## eventually use os.putenv(..) to set environment variables
        pid = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE).pid
        print 'Executed worker', pid
    
    

def schedule(time, exec_path, params=[], repeat=False):
    def validate():
        if not (time and int(time)):
            raise Exception('Time must be a valid integer',time)
        if not (exec_path and os.path.exists(exec_path)):
            raise Exception('Execution path must point to a valid/existing file',exec_path)

    if validate:
        # print 'Valid schedule item'
        started = datetime.datetime.now()
        timer = threading.Timer(time, do_work, [exec_path, params], {'repeat': repeat, 'time':time, 'started': started})
        timer.start()
        return True
    else:
        return False       



def main():

    for x in range(0,15):
        print x, schedule(3, WORKER_PATH, ['echo', 'news', 'welcome'], False)

    print 'Done'


if __name__ == "__main__":
    main()
