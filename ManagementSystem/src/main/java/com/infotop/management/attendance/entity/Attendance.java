package com.infotop.management.attendance.entity;



import javax.persistence.Entity;
import javax.persistence.Table;

import com.infotop.common.IdEntity;
/**
 * @author rubz
 *
 */
@Entity
@Table(name="ms_attendance")
public class Attendance extends IdEntity{
	
	
	private String pId;
	private String studId;
	private String deptId;
	private String subId;
	private String timeSlot;
	private String attendanceDate;
	private String attendance;
	private boolean flag;
	
	
	
	public String getStudId() {
		return studId;
	}
	public void setStudId(String studId) {
		this.studId = studId;
	}
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
	
	public String getAttendance() {
		return attendance;
	}
	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}
	
	public String getAttendanceDate() {
		return attendanceDate;
	}
	public void setAttendanceDate(String attendanceDate) {
		this.attendanceDate = attendanceDate;
	}


	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getTimeSlot() {
		return timeSlot;
	}
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	public boolean isFlag() {
		return flag;
	}
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	
	
	
	
	
	

}
