#!/usr/bin/env python


import os
import threading
import datetime
import signal
import sys
from subprocess import Popen

BASE_PATH   = '/Users/cevaris/Documents/workspace/scron'
WORKER_PATH = os.path.join(BASE_PATH, 'worker.py')

DELTAS = []

def stats():
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

    print "Executed worker scheduled at %d in %s" % (time, str(delta))

    if repeat:
        schedule(time, args[0], args[1], repeat)

    # Execute actual work
    os.system("%s %s" % (args[0], args[1]))

    threading.exit()

    

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

    for x in range(1,100):
        print x, schedule(3, WORKER_PATH, ['echo', 'news', 'welcome'], False)

    signal.signal(signal.SIGINT, signal_handler)
    print('Press Ctrl+C')
    signal.pause()


    stats()
    print 'Done'


if __name__ == "__main__":
    main()
