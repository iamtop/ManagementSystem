package com.infotop.management.student.entity;


import javax.persistence.Entity;
import javax.persistence.Table;
import com.infotop.common.IdEntity;

@Entity
@Table(name="ms_student")
public class Student extends IdEntity {
	private String studId;
	private String semId;
	private String deptId;
	private String pId;
	
	
	public String getStudId() {
		return studId;
	}
	public void setStudId(String studId) {
		this.studId = studId;
	}
	public String getSemId() {
		return semId;
	}
	public void setSemId(String semId) {
		this.semId = semId;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	
}
