package com.infotop.management.authority.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.infotop.common.IdEntity;


@Entity
@Table(name="ms_authority")
public class Authority extends IdEntity{
	
	private String deptId;
	private String subId;
	private String roleCode;
	private String pId;
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getSubId() {
		return subId;
	}
	public void setSubId(String subId) {
		this.subId = subId;
	}
	public String getRoleCode() {
		return roleCode;
	}
	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}

}
