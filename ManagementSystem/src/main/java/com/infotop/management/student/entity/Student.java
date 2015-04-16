package com.infotop.management.student.entity;


import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import com.infotop.common.IdEntity;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.department.entity.Department;
import com.infotop.management.personaldetails.entity.PersonalDetails;

@Entity
@Table(name="ms_student")
public class Student extends IdEntity {
	private String studId;
	private Department deptList;
	private Batch batchList;
	private PersonalDetails personal;
	
	
	@javax.persistence.OneToOne
	@JoinColumn(name= "dept_id", referencedColumnName="id")
	public Department getDeptList() {
		return deptList;
	}
	public void setDeptList(Department deptList) {
		this.deptList = deptList;
	}
	
	@javax.persistence.OneToOne
	@JoinColumn(name= "sem_id", referencedColumnName="id")
	public Batch getBatchList() {
		return batchList;
	}
	public void setBatchList(Batch batchList) {
		this.batchList = batchList;
	}
	
	@javax.persistence.OneToOne
	@JoinColumn(name= "p_id", referencedColumnName="id")
	public PersonalDetails getPersonal() {
		return personal;
	}
	public void setPersonal(PersonalDetails personal) {
		this.personal = personal;
	}
	
	public String getStudId() {
		return studId;
	}
	public void setStudId(String studId) {
		this.studId = studId;
	}
	
	
}
