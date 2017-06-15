-- Удаление справочника "Суть обращения"
-- Скрипты создания справочника - 2012-12-11-Insert_new_card

-- Удаление содержимого
DELETE FROM CARD_ELEMENT_FIELD_VALUE WHERE CARD_ELEMENT_ID IN
(
  SELECT ID FROM CARD_ELEMENT WHERE CARD_CODE='SKonsult'
);

-- Удаление структуры

DELETE FROM CARD_FIELD WHERE CARD_CODE='SKonsult';
DELETE FROM CARD_ELEMENT WHERE CARD_CODE='SKonsult';
DELETE FROM CARD WHERE CARD_CODE='SKonsult';
