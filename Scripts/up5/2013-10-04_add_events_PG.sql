insert into evs values(23,'Пользователь вошел под окном','user.enter-window',true);

insert into ev_list_profile values(nextval('hibernate_sequence'),0,23);

insert into ev_attributes values('user.enter-window:comments','Дополнительная информация',false,23);


insert into evs values(24,'Пользователь пользуется эл очередью','user.e-queue',true);

insert into ev_list_profile values(nextval('hibernate_sequence'),0,24);

insert into ev_attributes values('user.e-queue:comments','Дополнительная информация',false,24);