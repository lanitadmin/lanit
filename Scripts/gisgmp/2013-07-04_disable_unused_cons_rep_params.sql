/* отключает все параметры и отчеты */
UPDATE report_param SET disabled =true;
/* отчет по системе начислений для ГИС ГМП */
UPDATE report_param SET disabled =false where id = 29;

