alter table personal_add_info drop PARENT_PASS_DATE;
alter table personal_add_info add PARENT_PASS_DATE date;

INSERT INTO BENEFITS_ENTITLED (BENEFITS_ENTITLED_ID,PRIORITY,CARD_ELEMENT_ID, BENEFITS_ENTITLED_Name) VALUES (1,3,'PravoVneoch', 'Льгота, дающая право на внеочередное зачисление');
INSERT INTO BENEFITS_ENTITLED (BENEFITS_ENTITLED_ID,PRIORITY,CARD_ELEMENT_ID, BENEFITS_ENTITLED_Name) VALUES (2,2,'PravoPervooch', 'Льгота, дающая право на первоочередное зачисление');
INSERT INTO BENEFITS_ENTITLED (BENEFITS_ENTITLED_ID,PRIORITY,CARD_ELEMENT_ID, BENEFITS_ENTITLED_Name) VALUES (3,1,'PravoPreim', 'Льгота, дающая право на преимущественное зачисление');