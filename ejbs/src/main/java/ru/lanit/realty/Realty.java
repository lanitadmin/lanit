package ru.lanit.realty;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.envers.Audited;
import ru.lanit.core.entity.RealtyBase;

/**
 * Created by vtsapaev on 20.02.15.
 */
@Entity
@Audited
@Table(name = "realty")
public class Realty extends RealtyBase implements Serializable {

  private String inventoryNumber;

  @Column(name = "inventory_number")
  public String getInventoryNumber() {
    return inventoryNumber;
  }

  public void setInventoryNumber(String inventoryNumber) {
    this.inventoryNumber = inventoryNumber;
  }
}
