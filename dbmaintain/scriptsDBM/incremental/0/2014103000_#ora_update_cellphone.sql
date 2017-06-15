update person
set cell_phone = '+7(' || substr(trim(replace(replace(cell_phone, '-',''), ' ','')), 3, 3) || ')' || substr(trim(replace(replace(cell_phone, '-',''), ' ','')), 6)
where cell_phone is not null and substr(cell_phone, 1, 1) = '+' and substr(cell_phone, 3, 1) != '(' and length(trim(cell_phone)) = 12;

update person
set cell_phone = '+7(' || substr(trim(replace(replace(cell_phone, '-',''), ' ','')), 2, 3) || ')' || substr(trim(replace(replace(cell_phone, '-',''), ' ','')), 5)
where cell_phone is not null and substr(cell_phone, 1, 1) != '+';

