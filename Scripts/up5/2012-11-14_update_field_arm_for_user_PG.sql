--прогонять после деплоя приложения
update user_ref
set is_arm = false
where is_arm is null;