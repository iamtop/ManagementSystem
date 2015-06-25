package com.infotop.webservice.rest;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.infotop.management.roleasignment.entity.RoleAsignment;
import com.infotop.management.roleasignment.repository.RoleAsignmentDao;
import com.infotop.management.subject.entity.Subject;
import com.infotop.management.subject.repository.SubjectDao;
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
		String sql = "select distinct t.id, m.fname, m.lname, t.task_date as taskDate, t.slot_start_time as slotStartTime, t.slot_end_time as slotEndTime, d.dept_name as deptName, "
				+ "b.sem_name as SemName, s.sub_name as subName from ms_task_manager as t, ms_authority a, ms_personal m, ms_subject s, ms_batch b,"
				+ " ms_dept d where t.p_id = a.id and a.p_id = m.id and t.dept_id = d.id and t.sem_id = b.id and t.sub_id = s.id and t.id = "+id+"";
		return jdbcTemplate.queryForList(sql);
	}

	public List<Map<String, Object>> getStudents() {
		
		String sql = "select s.id, p.fname, p.lname from ms_personal as p, ms_student as s where s.p_id = p.id";
		return jdbcTemplate.queryForList(sql);
	}

	public List<Map<String, Object>> getStudentDetails(int id) {
		String sql;
			sql = "select distinct s.id, s.stud_id,p.fname, p.lname, p.father_name as fatherName, p.mother_name as motherName, "
					+ "p.dob, p.doj, p.email, p.gender, p.phone, b.sem_name as semName, d.dept_name as deptName from ms_student as s, "
					+ "ms_personal as p, ms_batch as b, ms_dept as d where s.p_id = " +id+" and p.id = "+id+" and s.sem_id = b.id and s.dept_id = d.id";
		return jdbcTemplate.queryForList(sql);	
	}

	public List<Map<String, Object>> getAllAuthorities() {
		String sql = "select a.id, p.fname, p.lname, p.address, p.email, p.phone, p.gender, p.father_name as fatherName, "
				+ "p.mother_name as motherName, p.dob, p.doj, d.dept_name as deptName, r.role_name as roleName from ms_authority as a, ms_personal as p, ms_dept as d, "
				+ "ms_role_asign as r where a.p_id = p.id and a.role_code = r.id and a.dept_id = d.id";
		return jdbcTemplate.queryForList(sql);
	}

	public List<Map<String, Object>> getAuthDetail(int id) {
		String sql = "select a.id, p.fname, p.lname, p.address, p.email, p.phone, p.gender, p.father_name as fatherName, "
				+ "p.mother_name as motherName, p.dob, p.doj, d.dept_name as deptName, r.role_name as roleName from ms_authority as a, ms_personal as p, ms_dept as d, "
				+ "ms_role_asign as r where a.p_id = p.id and a.role_code = r.id and a.dept_id = d.id and a.id= "+id+"";
		return jdbcTemplate.queryForList(sql);
	}
}
