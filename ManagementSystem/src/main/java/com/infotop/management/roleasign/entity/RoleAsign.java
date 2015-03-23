package com.infotop.management.roleasign.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.infotop.common.IdEntity;
@Entity
@Table(name="ms_role_asign")
public class RoleAsign extends IdEntity {
	
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getBranchId() {
		return branchId;
	}
	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}
	public String getAsignRole() {
		return asignRole;
	}
	public void setAsignRole(String asignRole) {
		this.asignRole = asignRole;
	}
	private String deptId;
	private String branchId;
	private String asignRole;
	

}
