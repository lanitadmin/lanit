insert into evs values(20, 'Пользователь удалил услуги', 'user.remove_service', true);
insert into evs values(21, 'Пользователь удалил адаптеры', 'user.remove_ad', true);
insert into evs values(22, 'Пользователь удалил элементы', 'user.remove_elem', true);

insert into ev_attributes values('user.remove_service:comments', 'Дополнительная информация', false, 20);
insert into ev_attributes values('user.remove_elem:comments', 'Дополнительная информация', false, 21);
insert into ev_attributes values('user.remove_adapter:comments', 'Дополнительная информация', false, 22);