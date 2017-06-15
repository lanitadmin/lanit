update CARD_ELEMENT_DEPENDENCE  d
set d.owner = (select c.owner from CARD_ELEMENT c where c.id = d.element_id);