ALTER TABLE holiday add holiday_date1 date;

update holiday
set holiday_date1 = holiday_date;

ALTER TABLE holiday drop holiday_date;

alter table holiday alter holiday_date1 to holiday_date;