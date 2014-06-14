#!/usr/bin/env python


import os
import threading
import datetime

BASE_PATH   = '/Users/cevaris/Documents/workspace/scron'
WORKER_PATH = os.path.join(BASE_PATH, 'worker.py')


def do_work_repeat(*args, **kwargs):
    print args, kwargs


def do_work(*args, **kwargs):
    repeat = kwargs.pop('repeat')
    time   = kwargs.pop('time')
    if repeat:
        threading.Timer(time, do_work, [args[0], args[1]], {'repeat': repeat, 'time':time}).start()
    
    os.system("%s %s" % (args[0], args[1]))
    

def schedule(time, exec_path, params=[], repeat=False):
    def validate():
        if not (time and int(time)):
            raise Exception('Time must be a valid integer',time)
        if not (exec_path and os.path.exists(exec_path)):
            raise Exception('Execution path must point to a valid/existing file',exec_path)


    if validate:
        print 'Valid schedule item'
        timer = threading.Timer(time, do_work, [exec_path, params], {'repeat': repeat, 'time':time})
        timer.start()




def main():


    
    # schedule(10, WORKER_PATH, {}, False)
    # schedule(10, 'fake path', {}, False)
    # schedule('10s', WORKER_PATH, {}, False)
    # schedule('10', None, {}, False)

    print schedule(3, WORKER_PATH, ['echo', 'news', 'welcome'], True)
    # print schedule(1, WORKER_PATH, ['worker', 'does', 'nddds'], True)
    
    print 'Done'


if __name__ == "__main__":
    main()
