package com.infotop.management.attendance.entity;



import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import com.infotop.common.IdEntity;
import com.infotop.management.authority.entity.Authority;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.department.entity.Department;
import com.infotop.management.student.entity.Student;
import com.infotop.management.subject.entity.Subject;
import com.infotop.management.taskmanager.entity.TaskManager;
/**
 * @author rubz
 *
 */
@Entity
@Table(name="ms_attendance")
public class Attendance extends IdEntity{
	
	
	
	private String deptId;
	private String studId;
	private String subId;
	private String batchId;
	private String timeSlotStart;
	private String timeSlotEnd;
	private String attendanceDate;
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getStudId() {
		return studId;
	}
	public void setStudId(String studId) {
		this.studId = studId;
	}
	public String getSubId() {
		return subId;
	}
	public void setSubId(String subId) {
		this.subId = subId;
	}
	public String getBatchId() {
		return batchId;
	}
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}
	public String getTimeSlotStart() {
		return timeSlotStart;
	}
	public void setTimeSlotStart(String timeSlotStart) {
		this.timeSlotStart = timeSlotStart;
	}
	public String getTimeSlotEnd() {
		return timeSlotEnd;
	}
	public void setTimeSlotEnd(String timeSlotEnd) {
		this.timeSlotEnd = timeSlotEnd;
	}
	public String getAttendanceDate() {
		return attendanceDate;
	}
	public void setAttendanceDate(String attendanceDate) {
		this.attendanceDate = attendanceDate;
	}
	
	
	
}
