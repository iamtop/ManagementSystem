package com.infotop.management.authority.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import com.infotop.common.IdEntity;
import com.infotop.management.department.entity.Department;
import com.infotop.management.personaldetails.entity.PersonalDetails;
import com.infotop.management.roleasignment.entity.RoleAsignment;


@Entity
@Table(name="ms_authority")
public class Authority extends IdEntity{
	
	private PersonalDetails personal;
	private Department deptList;
	private RoleAsignment roleList;
	
	
	@javax.persistence.ManyToOne
	@JoinColumn(name= "dept_id", referencedColumnName="id")
	public Department getDeptList() {
		return deptList;
	}
	public void setDeptList(Department deptList) {
		this.deptList = deptList;
	}
	
	@javax.persistence.ManyToOne
	@JoinColumn(name= "role_code", referencedColumnName="id")
	public RoleAsignment getRoleList() {
		return roleList;
	}
	public void setRoleList(RoleAsignment roleList) {
		this.roleList = roleList;
	}
	
	@javax.persistence.OneToOne
	@JoinColumn(name="p_id", referencedColumnName="id")
	public PersonalDetails getPersonal() {
		return personal;
	}
	public void setPersonal(PersonalDetails personal) {
		this.personal = personal;
	}

	}
