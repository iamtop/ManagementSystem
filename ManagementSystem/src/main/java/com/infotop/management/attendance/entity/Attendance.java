package com.infotop.management.attendance.entity;



import javax.persistence.Entity;
import javax.persistence.Table;

import com.infotop.common.IdEntity;
import com.infotop.management.authority.entity.Authority;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.department.entity.Department;
import com.infotop.management.student.entity.Student;
import com.infotop.management.subject.entity.Subject;
/**
 * @author rubz
 *
 */
@Entity
@Table(name="ms_attendance")
public class Attendance extends IdEntity{
	
	private String timeSlotStart;
	private String timeSlotEnd;
	private String attendanceDate;
	private String attendance;
	
	private Department departmentList;
	private Student studentList;
	private Subject subjectList;
	private Batch batchList;
	private Authority authId;
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
	public String getAttendance() {
		return attendance;
	}
	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}
	public Department getDepartmentList() {
		return departmentList;
	}
	public void setDepartmentList(Department departmentList) {
		this.departmentList = departmentList;
	}
	public Student getStudentList() {
		return studentList;
	}
	public void setStudentList(Student studentList) {
		this.studentList = studentList;
	}
	public Subject getSubjectList() {
		return subjectList;
	}
	public void setSubjectList(Subject subjectList) {
		this.subjectList = subjectList;
	}
	public Batch getBatchList() {
		return batchList;
	}
	public void setBatchList(Batch batchList) {
		this.batchList = batchList;
	}
	public Authority getAuthId() {
		return authId;
	}
	public void setAuthId(Authority authId) {
		this.authId = authId;
	}
	
}
