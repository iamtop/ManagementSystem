package com.infotop.webservice.rest;


import java.util.List;

import com.infotop.common.BasicController;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.department.entity.Department;
import com.infotop.management.roleasignment.entity.RoleAsignment;
import com.infotop.management.subject.entity.Subject;
import com.infotop.management.taskmanager.entity.TaskManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
public class RestFulWebController extends BasicController{
	
	
@Autowired
RestFulWebService restService;


@RequestMapping(value = "getAllDesignation", method = RequestMethod.GET, produces = "application/json")
public @ResponseBody List<RoleAsignment> getAllRoleNames(){
	return (List<RoleAsignment>) restService.getAllRoleName();
	
}
@RequestMapping(value = "getAllTasks" , method=RequestMethod.GET , produces = "application/json")
public @ResponseBody List<TaskManager> getAllTasks(){
	return (List<TaskManager>) restService.getAllTask();
	
}
@RequestMapping(value="getAllSemesters" , method=RequestMethod.GET , produces="application/json")
public @ResponseBody List<Batch> getAllSemesters(){
	return (List<Batch>) restService.getAllSemester();
}

@RequestMapping(value="getAllSubjects", method=RequestMethod.GET , produces="application/json")
public @ResponseBody List<Subject> getAllSubjects(){
	return (List<Subject>) restService.getAllSubject();
}

@RequestMapping(value="getAllDepts", method=RequestMethod.GET , produces="application/json")
public @ResponseBody List<Department> getAllDepartments(){
	return (List<Department>) restService.getAllDepartment();
}
}
