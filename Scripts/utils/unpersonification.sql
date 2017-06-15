-- Обезличивание юридических лиц
update agent set
address = '127000, г.Москва, ул.Безымянная 10',
bank = 'Безымянный',
bank_account = null,
boss_fio = 'Иванов Иван Иванович',
boss_fio_r = 'Иванову Ивану Ивановичу',
buh_fio = 'Петров Петр Петровичев',
email = 'test@test.com',
inn = '123456789012',
kpp = '123456789',
ogrn = '123456789012345',
post_address = '127000, г.Москва, ул.Безымянная 10',
phone = '89000000000';

-- Обезличивание физических лиц
update person set 
address = '127000, г.Москва, ул.Безымянная 10, 20',
birth_date = '1970-01-01',
cell_phone = '89000000000',
email = 'test@test.com',
fact_address = '127000, г.Москва, ул.Безымянная 10, 20',
inn = '123456789012',
first_name = 'Иван',
middle_name = 'Иванович',
pass_date = '2000-01-01',
pass_from = 'ОВД',
pass_no = '0001',
pass_seria = '000002',
phone = '(495)7000000',
snils = '112-233-445 95';