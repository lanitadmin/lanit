ALTER TABLE holiday add holiday_date1 date;

update holiday
set holiday_date1 = trunc(holiday_date);

ALTER TABLE holiday drop column holiday_date;

alter table holiday rename column holiday_date1 to holiday_date;