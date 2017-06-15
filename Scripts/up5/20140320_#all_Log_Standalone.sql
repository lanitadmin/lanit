Теперь часть лога от процессного движка переведно в debug и trace

!Делаем однократно
1) Внести в standalone.xml в секцию <subsystem xmlns="urn:jboss:domain:logging:1.2">
следующее

а)Добавить
<logger category="org.cp.shark">
	<level name="TRACE"/>
</logger>

<logger category="Shark">
	<level name="WARN"/>
</logger>

!По необходимости
Для того чтобы увидеть все сообщения, которые выводились раньше в лог надо переключить
уровень лога в <periodic-rotating-file-handler> на DEBUG. Если надо более детально, то TRACE

Переключение:
1) Внести исправления в standalone.xml - и перегрузить jboss
2) Исправить на лету, без перезагрузки jboss-а
	а) В браузер вбить host:9990 - Консоль администрирования. По умолчанию консоль 
	доступна только локально. Пробросьте порт. Наружу консоль не выставляйте.
	б) Ведите логин и пароль
	в) В верхнем правом углу выбираем Profile
	г) В дереве, выбираем Core, Logging
	д) В окне выбираем вкладку Handler, затем Periodic
	е) В секции Details нажимаем кнопку Edit и меняем уровень лога
3) Если вы хотите увидеть сообщения Shark ("is created", "is completed") - В принципе это информация
избыточна, так как она выводиться в лог org.cp.shark.impl.NotifyingEventAuditManager, измените
уровень WARN на INFO в <logger category="Shark">
4) TimeProfiler Shark-а в лог выводиться по умолчанию - Это компонет профилирования Shark-а, который
отслеживает операции по работе с БД, которые превышают лимиты