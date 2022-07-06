select * from patient;

select * from sensor;

select * from careteam_member;

select * from read;

select * from read_careteam;

select read_increment_id.nextval from dual;

delete from read where "readid" > 0;
delete from careteam_member where "id" > 0;
delete from patient where "patientid" > 0;
delete from sensor where "sensorid" > 0;
delete from read_careteam where "readid" > 0;


drop SEQUENCE read_increment_id;


CREATE SEQUENCE read_increment_id
  START WITH 1
  INCREMENT BY 1
  CACHE 100;

commit;