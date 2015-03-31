package com.infotop.management.subject.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.infotop.common.IdEntity;
@Entity
@Table(name="ms_subject")
public class Subject extends IdEntity {
	private String subId;
	private String subName;
	private String deptId;
	private String semId;
	
	public String getSubId() {
		return subId;
	}
	public void setSubId(String subId) {
		this.subId = subId;
	}
	public String getSubName() {
		return subName;
	}
	public void setSubName(String subName) {
		this.subName = subName;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getSemId() {
		return semId;
	}
	public void setSemId(String semId) {
		this.semId = semId;
	}
	
	
	

}
