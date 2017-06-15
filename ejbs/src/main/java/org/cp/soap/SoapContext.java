package org.cp.soap;

import org.cp.admin.AppSettingsBean;
import org.cp.common.Securable;
import org.cp.lodent.User;
import org.cp.lodent.UserDAO;
import org.cp.model.doc.JcrAttach;
import org.hibernate.annotations.Index;
import org.hibernate.annotations.Type;
import org.jboss.seam.Component;
import org.jboss.seam.annotations.Name;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlEnumValue;
import javax.xml.bind.annotation.XmlTransient;
import javax.xml.bind.annotation.XmlType;

import java.io.Serializable;
import java.util.*;

import ru.lanit.core.entity.SoapContextBase;

@Entity
@Table(name = "SOAP_CONTEXT")
public class SoapContext extends SoapContextBase<SoapContext> implements Serializable {

    private String applicantName;
    private String serviceName;
    private String activityId;

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
    }
    
    
}
