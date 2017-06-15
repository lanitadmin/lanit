--прогонять после деплоя приложения
update user_ref
set is_arm = 0
where is_arm  is null