package org.cp.sir.dao.filter;

import javax.persistence.Query;

import org.cp.sir.model.FilterValue;

public class DeclarantRequisiteRestriction implements MyTaskRestriction {
  /**
   * Логгер
   */
  private FilterValue filterValue;
  private static final String TABLE = "";
  private static final String CONDITION = "";
  private static final String VAR_NAME = "declarantName";

  public DeclarantRequisiteRestriction(FilterValue filterValue) {
    this.filterValue = filterValue;
  }

  @Override
  public String getFrom() {
    return TABLE;
  }

  @Override
  public String getSubWhere() {
    return "exists (SELECT item.id FROM ObjectGroupItem item join item.objectGroup og WHERE "
        + this.aliasGossrvcDocPackage+".applicantGroup=og and (exists (select p.id from Person p where p.id = "
              + "item.objectId and lower(p.lastName ||' '|| p.firstName ||' '|| p.middleName || ' ' || p.inn) like "
              + ":"+VAR_NAME + ") "
              + " or exists "
              + " (select a.id from Agent a where a.id = "
              + "item.objectId and lower(a.name || ' ' || a.inn) like :"+VAR_NAME+ "))) and ";
  }

  @Override
  public String getWhere() {
    return CONDITION;
  }

  @Override
  public void setParams(Query query) {
    query.setParameter(VAR_NAME, "%"+filterValue.getValues().get(0).toLowerCase()+"%");
  }

  @Override
  public boolean getUseGossrvcDocPackage() {
    // TODO Auto-generated method stub
    return true;
  }

}
