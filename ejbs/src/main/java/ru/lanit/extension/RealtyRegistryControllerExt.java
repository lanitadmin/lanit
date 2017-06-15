package ru.lanit.extension;

import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.Install;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;

import java.io.Serializable;

import ru.lanit.realty.Realty;
import ru.lanit.realty.RealtyRegistryController;
import ru.lanit.util.Util;

/**
 * Created by vtsapaev on 20.02.15.
 */
@Name("realtyRegistry")
@Scope(ScopeType.CONVERSATION)
@Install(precedence = Install.DEPLOYMENT)
public class RealtyRegistryControllerExt extends RealtyRegistryController implements Serializable {

  @Override
  protected String getWhereQuery() {

    String whereQuery = super.getWhereQuery();

    if (Util.isNotEmpty(((Realty)getFilter()).getInventoryNumber())) {
      whereQuery += " and r.inventoryNumber = #{realtyRegistry.filter.inventoryNumber} ";
    }
    return whereQuery;
  }
}
