#!/usr/bin/python
# ATXRaspi/MightyHat interrupt based shutdown/reboot script
# Script by Tony Pottier, Felix Rusu
import RPi.GPIO as GPIO
import os
import sys
import time

GPIO.setmode(GPIO.BCM) 

pulseStart = 0.0
REBOOTPULSEMINIMUM = 0.2	#reboot pulse signal should be at least this long (seconds)
REBOOTPULSEMAXIMUM = 1.0	#reboot pulse signal should be at most this long (seconds)
SHUTDOWN = 7							#GPIO used for shutdown signal
BOOT = 8								#GPIO used for boot signal

# Set up GPIO 8 and write that the PI has booted up
GPIO.setup(BOOT, GPIO.OUT, initial=GPIO.HIGH)

# Set up GPIO 7  as interrupt for the shutdown signal to go HIGH
GPIO.setup(SHUTDOWN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

print "\n=========================================================================================="
print "   ATXRaspi shutdown IRQ script started: asserted pins (",SHUTDOWN, "=input,LOW; ",BOOT,"=output,HIGH)"
print "   Waiting for GPIO", SHUTDOWN, "to become HIGH (short HIGH pulse=REBOOT, long HIGH=SHUTDOWN)..."
print "=========================================================================================="
try:
	while True:	
		GPIO.wait_for_edge(SHUTDOWN, GPIO.RISING)
		shutdownSignal = GPIO.input(SHUTDOWN)
		pulseStart = time.time() #register time at which the button was pressed
		while shutdownSignal:
			time.sleep(0.2)
			if(time.time() - pulseStart >= REBOOTPULSEMAXIMUM):
				print "\n====================================================================================="
				print "            SHUTDOWN request from GPIO", SHUTDOWN, ", halting Rpi ..."
				print "====================================================================================="
				os.system("sudo poweroff")
				sys.exit()
			shutdownSignal = GPIO.input(SHUTDOWN)
		if time.time() - pulseStart >= REBOOTPULSEMINIMUM:
			print "\n====================================================================================="
			print "            REBOOT request from GPIO", SHUTDOWN, ", recycling Rpi ..."
			print "====================================================================================="
			os.system("sudo reboot")
			sys.exit()
		if GPIO.input(SHUTDOWN): #before looping we must make sure the shutdown signal went low
			GPIO.wait_for_edge(SHUTDOWN, GPIO.FALLING)
except:
	pass 
finally:
	GPIO.cleanup()
