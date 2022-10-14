import time, os, RPi.GPIO as GPIO
pin = 21
GPIO.setmode(GPIO.BCM)
GPIO.setup(21, GPIO.OUT, initial=0)
while 1:
 time.sleep(1)
 GPIO.output(pin,1)
 time.sleep(0.1)
 GPIO.output(pin,0)
 time.sleep(0.2)
 GPIO.output(pin,1)
 time.sleep(0.1)
 GPIO.output(pin,0)
