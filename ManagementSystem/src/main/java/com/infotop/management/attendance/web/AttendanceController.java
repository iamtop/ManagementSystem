package com.infotop.management.attendance.web;


import com.infotop.management.attendance.service.AttendanceService;
import com.infotop.management.attendance.entity.Attendance;
import com.infotop.management.authority.entity.Authority;
import com.infotop.management.authority.service.AuthorityService;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.batch.service.BatchService;
import com.infotop.management.department.entity.Department;
import com.infotop.management.department.service.DepartmentService;
import com.infotop.management.student.entity.Student;
import com.infotop.management.student.service.StudentService;
import com.infotop.management.subject.entity.Subject;
import com.infotop.management.subject.service.SubjectService;
import com.infotop.management.taskmanager.entity.TaskManager;
import com.infotop.management.taskmanager.service.TaskManagerService;
import com.infotop.system.account.entity.User;
import com.infotop.system.account.service.ShiroDbRealm.ShiroUser;
import com.infotop.common.BasicController;

import net.infotop.web.easyui.DataGrid;
import net.infotop.web.easyui.Message;
import ch.qos.logback.classic.Logger;

import org.springside.modules.web.Servlets;

















import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
/**
 * AttendanceAction
 * $Id: AttendanceAction.java,v 0.0.1 2015-04-21 08:17:51  $
 */
@Controller
@RequestMapping(value = "/attendance")
public class AttendanceController extends BasicController {
    

    @Autowired
    private AttendanceService attendanceService;
    @Autowired
    private SubjectService subjectService;
	@Autowired
	private DepartmentService deptService;
	@Autowired
	private BatchService batchService;
	@Autowired
	private StudentService studentService;
	@Autowired
	private TaskManagerService taskMangerService;
	
	/**
	 * 跳转列表页面
	 * @return
	 */
    @RequestMapping(value = "")
	public String list(Model model, ServletRequest request) {
    	ShiroUser su = super.getLoginUser();
		User user = accountService.findUserByLoginName(su.getLoginName());
		if (user != null) {
			List<Department> deptList = deptService.getAllDepts();
			List<Batch> batList = batchService.getAllBatches();
			List<TaskManager> taskList = taskMangerService.findSpecificId();
			model.addAttribute("deptLs", deptList);
			model.addAttribute("batchList", batList);
			 model.addAttribute("tasks", taskList);
				
		} else {
			logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
			return "redirect:/login";
		}
       return "attendance/attendanceList";
    }
    
    
    /**
	 * 获取列表数据
	 * @param sortType
	 * @param order
	 * @param pageNumber
	 * @param rows
	 * @param model
	 * @param request
	 * @return
	 */
    @RequestMapping(value = "findList")
	@ResponseBody
	public DataGrid findList(
			@RequestParam(value = "sort", defaultValue = "auto") String sortType,
			@RequestParam(value = "order", defaultValue = "desc") String order,
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "rows", defaultValue = ROWS) int rows,
			@RequestParam(value = "deptId", defaultValue = "") String deptId,
			@RequestParam(value = "batchId", defaultValue = "") String batchId,
			@RequestParam(value = "timeSlotStart", defaultValue = "") String timeSlotStart,
			Model model, ServletRequest request) {

		DataGrid dataGrid = new DataGrid();
		try {
			ShiroUser su = super.getLoginUser();
			User user = accountService.findUserByLoginName(su.getLoginName());
			if (user != null) {
				Map<String, Object> searchParams = Servlets
						.getParametersStartingWith(request, "search_");
				
				model.addAttribute("searchParams", Servlets
						.encodeParameterStringWithPrefix(searchParams, "search_"));
				dataGrid = attendanceService.dataGrid(searchParams, pageNumber,
						rows, sortType, order,deptId,batchId,timeSlotStart);
			
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
			}
		} catch (Exception ex) {
			logger.log(this.getClass(),Logger.ERROR_INT,ex.getMessage(),super.getLoginUser().getLoginName(),null);
		}
		return dataGrid;
	}

	/**
	 * 跳转表单
	 * @param model
	 * @return
	 */
	 @RequestMapping(value = "create", method = RequestMethod.GET)
	 public String createForm(Model model) {
	     ShiroUser su = super.getLoginUser();
			User user = accountService.findUserByLoginName(su.getLoginName());
			if (user != null) {
			    
			     model.addAttribute("action", "create");
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
	     return "attendance/attendanceForm";
	 }
	 
	/**
	 * 保存表单数据
	 * @return
	 */
	 @RequestMapping(value = "create", method = RequestMethod.POST)
	 @ResponseBody
	 public Message create(@Valid Attendance attendance, RedirectAttributes redirectAttributes) {
		try {
			ShiroUser su = super.getLoginUser();
			User user = accountService.findUserByLoginName(su.getLoginName());
			if (user != null) {
		    	attendanceService.save(attendance);
				msg.setSuccess(true);
				msg.setMessage("信息添加成功");
				msg.setData(attendance);
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				msg.setSuccess(false);
				msg.setMessage("登陆帐号无效!");
				msg.setData("");
			}
		} catch (Exception ex) {
			logger.log(this.getClass(),Logger.ERROR_INT,ex.getMessage(),super.getLoginUser().getLoginName(),null);
			msg.setSuccess(false);
			msg.setMessage(ex.getMessage());
			msg.setData("");
		}
		return msg;
	}
	
	 @RequestMapping(value = "submit", method = RequestMethod.POST)
	 @ResponseBody
	    public Message submit(@RequestParam(value = "Department") List<String> Department,
	    		              @RequestParam(value = "slotstarttime") List<String> slotstarttime,
//	    		              @RequestParam(value = "slotendtime") List<String> slotendtime,
	    		              @RequestParam(value = "StudentName") List<String> StudentName,
		    		          @RequestParam(value = "Semester") List<String> Semester,
	    		              @RequestParam(value = "SubjectName") List<String> SubjectName,
	    		              @RequestParam(value = "attendanceDate") List<String> attendanceDate,
	            ServletRequest request) throws Exception {
		
	     try {
	    	 Attendance attendence;
	    	 	ShiroUser su = super.getLoginUser();
				User user = accountService.findUserByLoginName(su.getLoginName());
				if (user != null) {
					for(int i=0;i<Department.size();i++){
						attendence = new Attendance();
						
						attendence.setDeptId(Department.get(i));
						attendence.setBatchId(Semester.get(i));
						attendence.setSubId(SubjectName.get(i));
						attendence.setTimeSlotStart(slotstarttime.get(i));
//						attendence.setTimeSlotEnd(slotendtime.get(i));
						attendence.setStudId(StudentName.get(i));
						attendence.setAttendanceDate(attendanceDate.get(i));
						
						attendanceService.save(attendence);
						
					}
					
					msg.setSuccess(true);
					msg.setMessage("Data saved successfully");
					msg.setData("");
				} else {
					logger.log(this.getClass(),Logger.ERROR_INT,"invalid credential !","",null);
					msg.setSuccess(false);
					msg.setMessage("invalid credential!");
					msg.setData("");
				}
	    	 	
			} catch (Exception ex) {
				ex.printStackTrace();
				msg.setSuccess(false);
				msg.setMessage(ex.getMessage());
				msg.setData("");

			}
			return msg;
	    
				
	}
	 /**
	 * 跳转更新表单
	 * @param id
	 * @param model
	 * @return
	 */
	 @RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	    public String updateForm(@PathVariable("id") Long id, Model model) {
	        ShiroUser su = super.getLoginUser();
			User user = accountService.findUserByLoginName(su.getLoginName());
			if (user != null) {
				Attendance entity = attendanceService.get(id); 
		        model.addAttribute("attendance", entity);
		        model.addAttribute("action", "update");
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
	        return "attendance/attendanceForm";
	    }
	 
	 
	 /**
	 * 更新表单数据
	 * @param user
	 * @return
	 */
	 @RequestMapping(value = "update", method = RequestMethod.POST)
	 @ResponseBody
	    public Message update(@Valid @ModelAttribute("preloadAttendance") Attendance attendance,
	            RedirectAttributes redirectAttributes) {
		 try {
			 	ShiroUser su = super.getLoginUser();
				User user = accountService.findUserByLoginName(su.getLoginName());
				if (user != null) {
			    	attendanceService.save(attendance);
					msg.setSuccess(true);
					msg.setMessage("信息更新成功");
					msg.setData(attendance);
				} else {
					logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
					msg.setSuccess(false);
					msg.setMessage("登陆帐号无效!");
					msg.setData("");
				}
			} catch (Exception ex) {
				logger.log(this.getClass(),Logger.ERROR_INT,ex.getMessage(),super.getLoginUser().getLoginName(),null);
				msg.setSuccess(false);
				msg.setMessage(ex.getMessage());
				msg.setData("");
			}
			return msg;
	    }
	 
	 
	 
	 /**
	 * 删除记录
	 * @param ids 
	 * @return
	 */	
	 @RequestMapping(value = "delete", method = RequestMethod.POST)
	 @ResponseBody
	    public Message delete(@RequestParam(value = "ids") List<Long> ids,
	            ServletRequest request) throws Exception {
	     try {
	    	 	ShiroUser su = super.getLoginUser();
				User user = accountService.findUserByLoginName(su.getLoginName());
				if (user != null) {
					attendanceService.delete(ids);
					msg.setSuccess(true);
					msg.setMessage("信息删除成功");
					msg.setData("");
				} else {
					logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
					msg.setSuccess(false);
					msg.setMessage("登陆帐号无效!");
					msg.setData("");
				}
	    	 	
			} catch (Exception ex) {
				ex.printStackTrace();
				msg.setSuccess(false);
				msg.setMessage(ex.getMessage());
				msg.setData("");

			}
			return msg;
	    }
	 
	 @RequestMapping(value = "view/{id}", method = RequestMethod.GET)
	    public String view(@PathVariable("id") Long id, Model model) {
		 	ShiroUser su = super.getLoginUser();
			User user = accountService.findUserByLoginName(su.getLoginName());
			if (user != null) {
			 	Attendance entity = attendanceService.get(id); 
			 	model.addAttribute("attendance", entity);
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
		 	return "attendance/attendanceView";
	    }
	 
	 
	   @ModelAttribute("preloadAttendance")
	    public Attendance getAttendance(@RequestParam(value = "id", required = false) Long id) {
	        if (id != null) {
	            return attendanceService.get(id);
	        }
	        return null;
	    }

}