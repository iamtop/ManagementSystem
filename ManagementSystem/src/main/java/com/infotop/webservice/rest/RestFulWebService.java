package com.infotop.webservice.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.infotop.management.roleasignment.entity.RoleAsignment;
import com.infotop.management.roleasignment.repository.RoleAsignmentDao;
import com.infotop.management.subject.entity.Subject;
import com.infotop.management.subject.repository.SubjectDao;
import com.infotop.management.taskmanager.entity.TaskManager;
import com.infotop.management.taskmanager.repository.TaskManagerDao;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.batch.repository.BatchDao;
import com.infotop.management.department.entity.Department;
import com.infotop.management.department.repository.DepartmentDao;

@Service
public class RestFulWebService {
	
	@Autowired
	private RoleAsignmentDao roleDao;
	
	@Autowired
	private TaskManagerDao taskDao;

	@Autowired
	private BatchDao batchDao;
	
	@Autowired
	private DepartmentDao deptDao;
	
	@Autowired
	private SubjectDao subjectDao;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	public List<RoleAsignment> getAllRoleName(){
		return (List<RoleAsignment>) roleDao.findAll();		
	}
	
	public List<TaskManager> getAllTask(){
		return (List<TaskManager>) taskDao.findAll();
	}
	
	public List<Batch> getAllSemester(){
		return (List<Batch>) batchDao.findAll();
	}
	
	public List<Subject> getAllSubject(){
		return (List<Subject>) subjectDao.findAll();
	}
	
	public List<Department> getAllDepartment(){
		return (List<Department>) deptDao.findAll();
	}

	public List<Map<String, Object>> getTaskTeachers() {
		
		String sql = "select t.id, m.fname, m.lname from ms_task_manager t, ms_authority a, "
				+ "ms_personal m where t.p_id = a.id and a.p_id = m.id";
		return jdbcTemplate.queryForList(sql);
	}

	public List<Map<String, Object>> getTaskDetails(int id) {
		String sql = "select distinct t.id, m.fname, m.lname, t.slot_start_time, t.slot_end_time, d.dept_name, "
				+ "b.sem_name, s.sub_name from ms_task_manager as t, ms_authority a, ms_personal m, ms_subject s, ms_batch b,"
				+ " ms_dept d where t.p_id = a.id and a.p_id = m.id and t.dept_id = d.id and t.sem_id = b.id and t.sub_id = s.id and t.id = "+id+"";
		return jdbcTemplate.queryForList(sql);
	}

	public List<Map<String, Object>> getStudents() {
		
		String sql = "select s.id, p.fname, p.lname from ms_personal as p, ms_student as s where s.p_id = p.id";
		return jdbcTemplate.queryForList(sql);
	}

	public List<Map<String, Object>> getStudentDetails(int id) {
		String sql = "select distinct s.id, s.stud_id,p.fname, p.lname, p.father_name, p.mother_name, "
				+ "p.dob, p.doj, p.email, p.gender, p.phone, b.sem_name, d.dept_name from ms_student as s, "
				+ "ms_personal as p, ms_batch as b, ms_dept as d where s.p_id = " +id+" and p.id = "+id+" and s.sem_id = b.id and s.dept_id = d.id";
		return jdbcTemplate.queryForList(sql);
	}
}
