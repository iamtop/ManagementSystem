package com.infotop.management.subject.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import com.infotop.common.IdEntity;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.department.entity.Department;

@Entity
@Table(name="ms_subject")
public class Subject extends IdEntity {
	private String subId;
	private String subName;
	private Department deptList;
	private Batch batchList;
	
	
	@javax.persistence.ManyToOne
	@JoinColumn(name= "dept_id", referencedColumnName="id")
	public Department getDeptList() {
		return deptList;
	}
	public void setDeptList(Department deptList) {
		this.deptList = deptList;
	}
	
	@javax.persistence.ManyToOne
	@JoinColumn(name= "sem_id", referencedColumnName="id")
	public Batch getBatchList() {
		return batchList;
	}
	public void setBatchList(Batch batchList) {
		this.batchList = batchList;
	}
	
	
	
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
	
	
}
