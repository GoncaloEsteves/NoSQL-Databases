import requests
import time
import schedule
import json
import pymongo

sensorsNum = ['3001', '3002', '3003', '3004', '3005', '4001', '4002', '4003', '4004', '4005']

url = 'http://nosql.hpeixoto.me/api/sensor/'

def insertSensors(collection):
    print("Getting Data...")

    sensors = []

    for sensorID in sensorsNum:
        sensors.append(requests.get(url + sensorID).json()) 

    print('Saving Data...')

    collection.insert_many(sensors)

    print('Saved... ' + str(len(sensors)))

    print('Waiting...')


client = pymongo.MongoClient('localhost', 27017)

database = client["sensor"]

collection = database["reads"]
   
schedule.every(30).seconds.do(insertSensors,collection)

while True:
    schedule.run_pending()
    time.sleep(1)