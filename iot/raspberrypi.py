import firebase_admin

from firebase_admin import credentials,firestore

import time

import serial

import RPi.GPIO as GPIO

GPIO.setwarnings(False)

GPIO.setmode(GPIO.BCM)

cred=credentials.Certificate('credentials.json')

firebase_admin.initialize_app(cred)

db=firestore.client()

collection=db.collection('SensorData')

time=time.time()

if __name__ == "__main__":

    ser = serial.Serial('/dev/ttyUSB0',9600,timeout = 1)

    ser.flush()

    while True:

        if ser.in_waiting > 0:

            x = ser.readline().decode('utf-8').rstrip()

            res=collection.document(str(int(time))).set({'SensorData':x,'time':int(time)})

            print(res)
