import time, os, RPi.GPIO as GPIO
pin = 3
GPIO.setmode(GPIO.BCM)
GPIO.setup(pin, GPIO.IN, pull_up_down = GPIO.PUD_UP)
def interr(channel):
 os.system("sudo shutdown -h now")
GPIO.add_event_detect(pin, GPIO.FALLING, callback = interr, bouncetime = 500)
while 1:
 time.sleep(1)
