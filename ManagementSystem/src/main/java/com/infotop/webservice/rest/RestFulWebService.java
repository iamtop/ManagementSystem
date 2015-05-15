package com.infotop.webservice.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
}
