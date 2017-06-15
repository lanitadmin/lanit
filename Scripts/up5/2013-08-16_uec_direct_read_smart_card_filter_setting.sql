UPDATE APP_SETTING SET  
	SETTING_NAME = 'Типы смарт карт отображающихся в списке(допустимые типы карт:uecKrasnodar;uecRpB;socRpB;uecTyumen;directReadUec;) через ;', 
	SETTING_VALUE='uecKrasnodar;uecRpB;socRpB;uecTyumen;directReadUec;' where SETTING_ID = 'sm_card_active_cards';  
