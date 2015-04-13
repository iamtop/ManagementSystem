package com.infotop.management.student.entity;


import javax.persistence.Entity;
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
	private PersonalDetails personalList;
	
	
	
	public String getStudId() {
		return studId;
	}
	public void setStudId(String studId) {
		this.studId = studId;
	}
	
	
}
