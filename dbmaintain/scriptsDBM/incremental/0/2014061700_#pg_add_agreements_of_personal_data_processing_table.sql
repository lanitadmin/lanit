CREATE TABLE IF NOT EXISTS AGRM_OF_PERS_DATA_PROC (
    ID BIGINT NOT NULL UNIQUE,
    JCR_UID CHARACTER VARYING(255),
    PERSON_ID BIGINT NOT NULL,
 PRIMARY KEY (ID),
 CONSTRAINT AGRM_OF_PERS_DATA_PROC_PERSON_ID_FK
 FOREIGN KEY (PERSON_ID) REFERENCES  PERSON(ID)
 MATCH SIMPLE ON DELETE NO ACTION ON UPDATE NO ACTION
 );

INSERT INTO AGRM_OF_PERS_DATA_PROC (ID, JCR_UID, PERSON_ID) SELECT nextval('hibernate_sequence'), APP_AGREEM_UID, ID FROM PERSON;

ALTER TABLE PERSON_AUD DROP COLUMN  APP_AGREEM_UID;
ALTER TABLE PERSON DROP COLUMN APP_AGREEM_UID;