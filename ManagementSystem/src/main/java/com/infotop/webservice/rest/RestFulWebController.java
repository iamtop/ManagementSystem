package com.infotop.webservice.rest;


import java.util.List;
import java.util.Map;

import com.infotop.common.BasicController;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.department.entity.Department;
import com.infotop.management.roleasignment.entity.RoleAsignment;
import com.infotop.management.subject.entity.Subject;
import com.infotop.management.taskmanager.entity.TaskManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
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

//Get teacher name from task manager
@RequestMapping(value="getTaskTeachers", method=RequestMethod.GET, produces = "application/json")
public List<Map<String, Object>> getTaskTeachers(){
	return (List<Map<String, Object>>) restService.getTaskTeachers();
}

// Get the details of task for a particular teacher
@RequestMapping(value="getTasktDetails/{id}", method=RequestMethod.GET, produces = "application/json")
public List<Map<String, Object>> getTaskDetails(@PathVariable ("id") int id){
	return (List<Map<String, Object>>) restService.getTaskDetails(id);
}

// get the student details
@RequestMapping(value="getStudents", method=RequestMethod.GET, produces = "application/json")
public List<Map<String, Object>> getStudents(){
	return (List<Map<String, Object>>) restService.getStudents();
}

// get individual student details
@RequestMapping(value="getStudentDetails/{id}", method = RequestMethod.GET, produces="application/json")
public List<Map<String, Object>> getStudentDetails(@PathVariable ("id") int id){
	return (List<Map<String, Object>>) restService.getStudentDetails(id);
}

//get all Authorities
@RequestMapping(value = "getAllAuthorities", method=RequestMethod.GET, produces= "application/json")
public List<Map<String, Object>> getAllAuthorities(){
	return (List<Map<String, Object>>) restService.getAllAuthorities();
}

//get particular teahcer detail
@RequestMapping(value = "getAuthDetail/{id}", method=RequestMethod.GET, produces= "application/json")
public List<Map<String, Object>> getAuthDetail(@PathVariable ("id") int id){
	return (List<Map<String, Object>>) restService.getAuthDetail(id);
}
}
