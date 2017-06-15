-- удаляем из БД, чтобы записи пересоздались заново
delete from cons_history;
delete from report_param where id = 125;
delete from report_param where id = 126;
delete from report_param where id = 127;