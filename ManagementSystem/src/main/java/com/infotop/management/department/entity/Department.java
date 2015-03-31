package com.infotop.management.department.entity;

import com.infotop.common.IdEntity;

public class Department extends IdEntity{
	
	private String deptCode;
	private String deptName;
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

}
