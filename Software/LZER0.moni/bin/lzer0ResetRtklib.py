#!/usr/bin/python -u
# -*- coding: utf-8 -*-
#"""
#Created on Sun Dec 30 16:24:39 2018
#
#@author: dzuliani
#"""
import socket
import os
import time
#
# Defaults
reSpanTime = 120    # max number of seconds to allow a float or stand alone status
sckTimeOut = 10     # socket timeout
epochCounter = 0    # counter, if the counter reaches the resPanTime a reset is send
sleepTime = 10      # num of seconds to wait after a receiver reset before reconnecting
socketBuf = 1024    # socket buffer dimension
serverAddr  = '127.0.0.1' # to be used for local connections
# serverAddr  = 'crsbru3.dyndns.org' # to be used for remote connections
serverPort  = 5754
resetCmd = "'/home/lzer0/bin/rtkrcv.res'" # to be used for local connections
#resetCmd = "ssh -p 2282 lzer0@crsbru3.dyndns.org '/home/lzer0/bin/rtkrcv.res'" # to be used for remote connections
#
# Creating the socket and connecting to the server
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.settimeout(sckTimeOut)
connected = False
while not connected:
    try:
        s.connect((serverAddr, serverPort))
        connected = True
    except socket.error, exc:
        connected = False
        print "Caught exception socket.error : %s" % exc
        print "Trying to reset remote receiver"
        os.system("'/home/lzer0/bin/rtkrcv.res'")
        time.sleep(sleepTime)
while True:
    # CHeck if the socket is still streaming data
    try:
	data = s.recv(socketBuf)
	connect = True
	print 'Phase 1'
    except socket.error, exc:
        connected = False
        print "Caught exception socket.error : %s" % exc
        print "Trying to reset remote receiver"
        os.system("'/home/lzer0/bin/rtkrcv.res'")
        time.sleep(sleepTime)
    while data == '':
        print "No data available"
        print "Trying to reset remote receiver"
        s.close()
        connected = False
	os.system(resetCmd)
        time.sleep(sleepTime)
        while not connected:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	    print 'Phase 2'
            try:
                s.connect((serverAddr, serverPort))
                connected = True
                data = s.recv(socketBuf)
		print 'Phase 3'
            except socket.error, exc:
                connected = False
                print "Caught exception socket.error : %s" % exc
                print "Trying to reset remote receiver"
                os.system(resetCmd)
                time.sleep(sleepTime)
    dataSplitOri=data.split() #used to split the inpt string
    print 'Phase 4'
    if  (dataSplitOri[5] == '2') or  (dataSplitOri[5] == '5'):
        epochCounter = epochCounter + 1
        if epochCounter > reSpanTime:
            print 'Warning epoch counter is: ',epochCounter
            print "Trying to reset remote receiver"
            os.system(resetCmd)
            epochCounter = 0
            time.sleep(sleepTime)
    else:
        epochCounter = 0
	print 'Phase 5'
    print repr(data),dataSplitOri[5],epochCounter
    print 'Phase 6'
s.close()
print 'Phase 7'
