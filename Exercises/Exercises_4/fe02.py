import requests
import time
import schedule
import json
import config
import cx_Oracle
import database

connection = None

cx_Oracle.init_oracle_client(lib_dir="C:\oracle\instantclient_19_6")


def getSensors():
    print("Getting Data...")
    sensor1 = requests.get('http://nosql.hpeixoto.me/api/sensor/3001').json()
    sensor2 = requests.get('http://nosql.hpeixoto.me/api/sensor/3002').json()
    sensor3 = requests.get('http://nosql.hpeixoto.me/api/sensor/3003').json()
    sensor4 = requests.get('http://nosql.hpeixoto.me/api/sensor/3004').json()
    sensor5 = requests.get('http://nosql.hpeixoto.me/api/sensor/3005').json()
    print("Saving Data...")
    database.commitSensor(sensor1, connection)
    database.commitSensor(sensor2, connection)
    database.commitSensor(sensor3, connection)
    database.commitSensor(sensor4, connection)
    database.commitSensor(sensor5, connection)
    print("Waiting...")

try:
    connection = cx_Oracle.connect(config.username, config.password, config.dsn, encoding = config.encoding)
    
    schedule.every(15).seconds.do(getSensors)

    while True:
        schedule.run_pending()
        time.sleep(1)
except cx_Oracle.Error as error:
    print(error)
finally:
    if connection:
        connection.close()
