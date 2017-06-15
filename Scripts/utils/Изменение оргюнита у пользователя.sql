update securable 
set owner = 'OTIS'
where id in(select id from user_ref us1 where us1.login in ('Kontroler_OTIS', 'Podoynitsin_A', 'Demidov_A')) and aobject = 'entity.User';


update securable
set owner = 'ASO'
where id in(select id from user_ref us1 where us1.login in ('Kontroler_ASO', 'Faterin_V', 'Tishenko_N', 'Hvan_N', 'Lozovskaya_S', 'Kovalev_A', 'Mihaylova_O'))
and aobject = 'entity.User';

update securable
set owner = 'KUI'
where id in(select id from user_ref us1 where us1.login in ('Director_KUIA', 'Kontroler_KUIA'))
and aobject = 'entity.User';

update securable
set owner = 'OOA'
where id in(select id from user_ref us1 where us1.login in ('GrachevaT', 'BolshakovaO'))
and aobject = 'entity.User';

update securable
set owner = 'GKHLO'
where id in(select id from user_ref us1 where us1.login in ('Brovko_S', 'Beschastnaya_E', 'Vasiliev_I', 'Vibornih_J'))
and aobject = 'entity.User';


update securable
set owner = 'OGKHCO'
where id in(select id from user_ref us1 where us1.login in ('Razin_A', 'Nikitina_J', 'Derkach_O', 'Dgiba_S', 'Karataeva_V', 'test1'))
and aobject = 'entity.User';


update securable
set owner = 'KSMI'
where id in(select id from user_ref us1 where us1.login in ('Makeeva_J', 'Director_smi'))
and aobject = 'entity.User';


update securable
set owner = 'OPlZa'
where id in(select id from user_ref us1 where us1.login in ('Kruzhaeva_E', 'Bugaeva_A', 'Drugankina_V', 'Presniakova_A', 'Tambovtseva_E', 'Shustrova_M'))
and aobject = 'entity.User';

update securable
set owner = 'OOOSIPR'
where id in(select id from user_ref us1 where us1.login in ('Kontroler_OOOSIPR', 'Ivanov_K', 'Solodkiy_D', 'Vlasenkova_L', 'Del_O', 'Zimina_S'))
and aobject = 'entity.User';

update securable
set owner = 'KANC'
where id in(select id from user_ref us1 where us1.login in ('Borisova_A', 'Melnichuk_G'))
and aobject = 'entity.User';

update securable
set owner = 'SIIYAiG'
where id in(select id from user_ref us1 where us1.login in ('Zaporozhsky_S', 'Gorlov_A', 'Datsko_D'))
and aobject = 'entity.User';


update securable
set owner = 'ZemOtUAG'
where id in(select id from user_ref us1 where us1.login in ('Shayhaeva_A', 'Skomorohova_V', 'Zatevahina_L', 'Shkedova_E', 'Bashkirova_O', 'Vetsheva_E', 'Voevodina_E', 'Kostenko_I'))
and aobject = 'entity.User';


update securable
set owner = 'UGKHTE'
where id in(select id from user_ref us1 where us1.login in ('Kontroler_UGKHTE', 'Kulikov_I', 'Orlova_M', 'Sicheva_V'))
and aobject = 'entity.User';






