--Отключаем AGENT и PERSON от Securable

--Удаляем внешники на Securable
ALTER TABLE AGENT DROP CONSTRAINT 'Ключ на Securable';
ALTER TABLE AGENT_AUD DROP CONSTRAINT 'Ключ на Securable_AUD';

ALTER TABLE PERSON DROP CONSTRAINT 'Ключ на Securable';
ALTER TABLE PERSON_AUD DROP CONSTRAINT 'Ключ на Securable_AUD';

update agent a
set owner=(select s.owner from Securable s where s.id=a.id)
where exists (select 1 from Securable s where s.id=a.id);

update agent_aud p
set revtype=(select sa.revtype from securable_aud sa where sa.id=p.id and sa.rev=p.rev)
where exists (select 1 from securable_aud sa where sa.id=p.id and sa.rev=p.rev);

update person a
set owner=(select s.owner from Securable s where s.id=a.id)
where exists (select 1 from Securable s where s.id=a.id);

update person_aud p
set revtype=(select sa.revtype from securable_aud sa where sa.id=p.id and sa.rev=p.rev)
where exists (select 1 from securable_aud sa where sa.id=p.id and sa.rev=p.rev);

/*
!!!Убедиться что поля выше заполнились
Пока не прогонять.

delete from securable
where id in (select id from agent);

delete from securable
where id in (select id from person);
*/