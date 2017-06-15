update person
set cell_phone = '+7(' || substring((replace(replace(trim(cell_phone), ' ',''), '-','')) from 3 for 3) || ')' || substring((replace(replace(trim(cell_phone), ' ',''), '-','')) from 6)
where cell_phone is not null and cell_phone != '' and substring(cell_phone from 1 for 1) = '+' and substring(cell_phone from 3 for 1) != '(' and length(trim(cell_phone)) = 12;

update person
set cell_phone = '+7(' || substring(replace(replace(trim(cell_phone), '-',''),' ','') from 2 for 3) || ')' || substring(replace(replace(trim(cell_phone), '-',''),' ','') from 5)
where cell_phone is not null and cell_phone != '' and substring(cell_phone from 1 for 1) != '+';
