insert into evs values(23,'Пользователь вошел под окном','user.enter-window',1);

insert into ev_list_profile values(hibernate_sequence.nextval,0,23);

insert into ev_attributes values('user.enter-window:comments','Дополнительная информация',0,23);


insert into evs values(24,'Пользователь пользуется эл очередью','user.e-queue',1);

insert into ev_list_profile values(hibernate_sequence.nextval,0,24);

insert into ev_attributes values('user.e-queue:comments','Дополнительная информация',0,24);