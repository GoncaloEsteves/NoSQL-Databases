CREATE TABLESPACE hr_tables DATAFILE 'HR_FILES_01.dbf' SIZE 500m;

CREATE TEMPORARY TABLESPACE hr_temp TEMPFILE 'HR_TEMP_01.dbf' SIZE 500m;

CREATE USER hr IDENTIFIED BY &senha 
    DEFAULT TABLESPACE hr_tables
    TEMPORARY TABLESPACE hr_temp QUOTA
        UNLIMITED ON hr_tables ;

GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE SEQUENCE TO hr;