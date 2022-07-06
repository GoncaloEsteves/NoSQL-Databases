import cx_Oracle

#querys

queryPatient = ('insert into patient values(:patientid,:patientname ,to_date(:patientbirthdate, \'yyyy-mm-dd\'), :patientage)')
querySensor = ('insert into sensor values(:num, :id, :sn, :t)')
queryMember = ('insert into careteam_member values(:id,:nome)')
queryRead =  ('insert into read values(read_increment_id.nextval, :cod, :descricao, to_date(:d, \'yyyy-mm-dd\'), :b, :temp, :bsys'
              ', :bdias, :bpm, :sato2, to_timestamp(:time, \'yyyy-mm-dd  hh24:mi:ss\'), :sid, :pid)')
queryPatientMember = ('insert into patient_careteam values (:memberid, :id)')

def insertPatient(sensor, cursor):
    patient = sensor["patient"]
    try:
        cursor.execute(queryPatient, patient)
    except:
        print("ID: " + str(patient["patientid"]) + " already on data base.")

    insertCareTeam(sensor["careteam"], cursor, patient["patientid"])

def insertSensor(sensor, cursor):
    sensorData = {
        'num' : sensor["number_of_sensors"],
        'id' : sensor["sensorid"],
        'sn' : sensor["sensornum"],
        't' : sensor["type_of_sensor"]
    } 
    try:
        cursor.execute(querySensor, sensorData)
    except:
        print("ID: " + str(sensor["sensorid"]) + " already on data base.")

def insertCareTeam(team, cursor, id):
    for member in team:
        try:
            cursor.execute(queryMember, member)
        except:
            print("ID: " + str(member["id"]) + " already on data base.")

        data = {
            'memberid' : member["id"],
            'id' : id
        }      
        try:
            cursor.execute(queryPatientMember, data)
        except:
            pass

def insertRead(sensor, cursor):
    readData = {
        'cod' : sensor["servicecod"],
        'descricao' : sensor["servicedesc"],
        'd' : sensor["admdate"],
        'b' : sensor["bed"],        
        'temp' : sensor["bodytemp"],
        'bsys' : sensor["bloodpress"]["systolic"],
        'bdias' : sensor["bloodpress"]["diastolic"],
        'bpm' : sensor["bpm"],
        'sato2' : sensor["sato2"],
        'time' : sensor["timestamp"],
        'sid' : sensor["sensorid"],
        'pid' : sensor["patient"]["patientid"]
    }
    try:
        cursor.execute(queryRead, readData)
    except:
        pass




def commitSensor(sensor, connection):
    cursor = connection.cursor()
    insertPatient(sensor, cursor)
    insertSensor(sensor, cursor)
    insertRead(sensor, cursor)
    connection.commit()
    cursor.close()