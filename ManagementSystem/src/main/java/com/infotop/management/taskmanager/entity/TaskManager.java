package com.infotop.management.taskmanager.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import com.infotop.common.IdEntity;
import com.infotop.management.authority.entity.Authority;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.department.entity.Department;
import com.infotop.management.subject.entity.Subject;

@Entity
@Table(name="ms_task_manager")
public class TaskManager extends IdEntity {
	
	private String taskDate;
	private String slotStartTime;
	private String slotEndTime;
	private Department deptList;
	private Batch allSemester;
	private Subject subList;
	private Authority authorityList;
	public String getTaskDate() {
		return taskDate;
	}
	public void setTaskDate(String taskDate) {
		this.taskDate = taskDate;
	}
	public String getSlotStartTime() {
		return slotStartTime;
	}
	public void setSlotStartTime(String slotStartTime) {
		this.slotStartTime = slotStartTime;
	}
	public String getSlotEndTime() {
		return slotEndTime;
	}
	public void setSlotEndTime(String slotEndTime) {
		this.slotEndTime = slotEndTime;
	}
	
	
	@javax.persistence.ManyToOne
	@JoinColumn(name="dept_id" , referencedColumnName="id")
	public Department getDeptList() {
		return deptList;
	}
	public void setDeptList(Department deptList) {
		this.deptList = deptList;
	}
	
	@javax.persistence.ManyToOne
	@JoinColumn(name="sem_id" , referencedColumnName="id")
	public Batch getAllSemester() {
		return allSemester;
	}
	public void setAllSemester(Batch allSemester) {
		this.allSemester = allSemester;
	}
	
	@javax.persistence.OneToOne
	@JoinColumn(name="sub_id" , referencedColumnName="id")
	public Subject getSubList() {
		return subList;
	}
	public void setSubList(Subject subList) {
		this.subList = subList;
	}
	
	@javax.persistence.OneToOne
	@JoinColumn(name="p_id" , referencedColumnName="id")
	public Authority getAuthorityList() {
		return authorityList;
	}
	public void setAuthorityList(Authority authorityList) {
		this.authorityList = authorityList;
	}
}