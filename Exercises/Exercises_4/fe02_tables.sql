SELECT table_name
FROM user_tables
ORDER BY table_name;

CREATE SEQUENCE read_increment_id
  START WITH 1
  INCREMENT BY 1
  CACHE 100;
  
CREATE TABLE patient (
    "patientid" NUMBER(4,0) NOT NULL ENABLE,
    "patientname" VARCHAR2(200 byte) NOT NULL ENABLE,
    "patientbirthdate" DATE NOT NULL ENABLE,
    "patientage" NUMBER NOT NULL ENABLE,
    CONSTRAINT "PATIENT_PK" PRIMARY KEY ("patientid")
    );
    
CREATE TABLE careteam_member (
    "id" NUMBER NOT NULL ENABLE,
    "nome" VARCHAR2(200 byte) NOT NULL ENABLE,
    CONSTRAINT "CARETEAM_MEMBER_PK" PRIMARY KEY ("id")
    );
    
CREATE TABLE patient_careteam (
    "memberid" NOT NULL ENABLE,
    "patientid" NUMBER NOT NULL ENABLE,
    CONSTRAINT "READ_CARETEAM_PK" PRIMARY KEY ("memberid", "patientid"),
    CONSTRAINT "MEMBER_CONNECTOR_FK"
        FOREIGN KEY ("memberid")
        REFERENCES careteam_member("id"),
    CONSTRAINT "PATIENT_CONNECTOR_FK"
        FOREIGN KEY ("patientid")
        REFERENCES patient("patientid")
    );
    
CREATE TABLE sensor (
    "number_of_sensors" NUMBER NOT NULL ENABLE,
    "sensorid" NUMBER(4,0) NOT NULL ENABLE,
    "sensornum" NUMBER NOT NULL ENABLE,
    "type_of_sensor" VARCHAR2(200 byte),
    CONSTRAINT "SENSOR_PK" PRIMARY KEY ("sensorid")
    );
    
CREATE TABLE read (
    "readid" NUMBER NOT NULL ENABLE,
    "servicecod" VARCHAR2(200 byte),
    "servicedesc" VARCHAR2(200 byte),
    "admdate" DATE,
    "bed" VARCHAR2(200 byte),
    "bodytemp" NUMBER(2,0),
    "bloodpress_systolic" NUMBER(3,0),
    "bloodpress_diastolic" NUMBER(3,0),
    "bpm" NUMBER(3,0),
    "sato2" NUMBER(3,0),
    "timestamp" TIMESTAMP,
    "sensorid_fk" NUMBER(4,0) NOT NULL ENABLE,
    "patientid_fk" NUMBER(4,0) NOT NULL ENABLE,
    CONSTRAINT "READ_PK" PRIMARY KEY ("readid"),
    CONSTRAINT "READ_SENSOR_FK"
        FOREIGN KEY ("sensorid_fk")
        REFERENCES sensor("sensorid"),
    CONSTRAINT "READ_PATIENT_FK"
        FOREIGN KEY ("patientid_fk")
        REFERENCES patient("patientid")
    );