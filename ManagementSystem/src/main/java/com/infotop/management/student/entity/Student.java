package com.infotop.management.student.entity;


import javax.persistence.Entity;
import javax.persistence.Table;
import com.infotop.common.IdEntity;

@Entity
@Table(name="ms_student")
public class Student extends IdEntity {
	private String studId;
	private String brId;
	private String subId;
	private String pId;
	
	/*private String createUser;
	private String updateUser ;
	private String createDate;
	private String updateDate */
	public String getStudId() {
		return studId;
	}
	public void setStudId(String studId) {
		this.studId = studId;
	}
	public String getBrId() {
		return brId;
	}
	public void setBrId(String brId) {
		this.brId = brId;
	}
	public String getSubId() {
		return subId;
	}
	public void setSubId(String subId) {
		this.subId = subId;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	
}
