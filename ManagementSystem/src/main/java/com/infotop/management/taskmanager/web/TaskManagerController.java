package com.infotop.management.taskmanager.web;


import com.infotop.management.authority.entity.Authority;
import com.infotop.management.authority.service.AuthorityService;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.batch.service.BatchService;
import com.infotop.management.department.entity.Department;
import com.infotop.management.department.service.DepartmentService;
import com.infotop.management.personaldetails.entity.PersonalDetails;
import com.infotop.management.personaldetails.service.PersonalDetailsService;
import com.infotop.management.subject.entity.Subject;
import com.infotop.management.subject.service.SubjectService;
import com.infotop.management.taskmanager.service.TaskManagerService;
import com.infotop.management.taskmanager.entity.TaskManager;
import com.infotop.system.account.entity.User;
import com.infotop.system.account.service.ShiroDbRealm.ShiroUser;
import com.infotop.common.BasicController;

import net.infotop.web.easyui.DataGrid;
import net.infotop.web.easyui.Message;
import ch.qos.logback.classic.Logger;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springside.modules.web.Servlets;

















import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
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
 * TaskManagerAction
 * $Id: TaskManagerAction.java,v 0.0.1 2015-04-09 14:44:22  $
 */
@Controller
@RequestMapping(value = "/taskmanager")
public class TaskManagerController extends BasicController {
    

    @Autowired
    private TaskManagerService taskmanagerService;
    
    @Autowired
    private DepartmentService deptService;
    
    @Autowired
    private BatchService batchService;
    
    @Autowired
    private SubjectService subService;
    
    @Autowired
    private PersonalDetailsService personalService;
    
    @Autowired
    private AuthorityService authService;
	
	/**
	 * 跳转列表页面
	 * @return
	 */
    @RequestMapping(value = "")
	public String list(Model model, ServletRequest request) {
    	ShiroUser su = super.getLoginUser();
		User user = accountService.findUserByLoginName(su.getLoginName());
		if (user != null) {
			//TODO add some code.
		} else {
			logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
			return "redirect:/login";
		}
       return "taskmanager/taskmanagerList";
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
				dataGrid = taskmanagerService.dataGrid(searchParams, pageNumber,
						rows, sortType, order);
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
				
				 TaskManager entity = new TaskManager(); 
				 List<Department> deptList = deptService.getAllDepts();
				 List<Batch> batchList=batchService.getAllBatches();
				 List<Subject> subList=subService.getAllSubjects();
				 List<Authority> pIdList=authService.findSpecificId();
				 List<PersonalDetails> idList=personalService.findSpecificId();
				 List<Object>list=new ArrayList<Object>();
				 for(Authority a:pIdList){
					 System.out.println("Authority Pid : "+a.getPersonal().getId());
					 
					  for(PersonalDetails p:idList)
						 if(a.getPersonal().getId().equals(p.getId())){
							  
							  list.add(a.getPersonal());
							 
								
						 }
				 }
			    
				 
				 model.addAttribute("depts", deptList);
				 model.addAttribute("sems",batchList);
				 model.addAttribute("subs" , subList);
				 model.addAttribute("personalIdList", list);
				 
			     model.addAttribute("taskmanager", entity);
			     model.addAttribute("action", "create");
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
	     return "taskmanager/taskmanagerForm";
	 }
	 
	/**
	 * 保存表单数据
	 * @return
	 */
	 @RequestMapping(value = "create", method = RequestMethod.POST)
	 @ResponseBody
	 public Message create(@Valid TaskManager taskmanager, RedirectAttributes redirectAttributes , HttpServletRequest request) {
		try {
			ShiroUser su = super.getLoginUser();
			User user = accountService.findUserByLoginName(su.getLoginName());
			if (user != null) {
				
				taskmanager.setTaskDate(request.getParameter("taskDate"));
				taskmanager.setSlotStartTime(request.getParameter("slotStartTime"));
				taskmanager.setSlotEndTime(request.getParameter("slotEndTime"));
				taskmanager.setDeptList(deptService.get(Long.parseLong(request.getParameter("deptName"))));
				taskmanager.setAllSemester(batchService.get(Long.parseLong(request.getParameter("semName"))));
				taskmanager.setSubList(subService.get(Long.parseLong(request.getParameter("subName"))));
				
				String auth=request.getParameter("authname");
				System.out.println("auth:"+auth);
				Long aId=0L;
				List<Authority> pIdList=authService.findSpecificId();
				for(Authority a:pIdList){
					if(auth.equals((a.getPersonal().getId().toString()))){
						aId=a.getId();
						System.out.println("aId=="+aId);
					}
					
				}
				taskmanager.setAuthorityList(authService.get(aId));
		    	taskmanagerService.save(taskmanager);
				msg.setSuccess(true);
				msg.setMessage("New task generated successfully ");
				msg.setData(taskmanager);
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"invalid credential !","",null);
				msg.setSuccess(false);
				msg.setMessage("invalid credential !");
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
				
				List<Department> deptList = deptService.getAllDepts();
				 List<Batch> batchList=batchService.getAllBatches();
				 List<Subject> subList=subService.getAllSubjects();
				 
				 List<Authority> pIdList=authService.findSpecificId();
				 List<PersonalDetails> idList=personalService.findSpecificId();
				 List<Object>list=new ArrayList<Object>();
				 for(Authority a:pIdList){
					 System.out.println("Authority Pid : "+a.getPersonal().getId());
					 
					  for(PersonalDetails p:idList)
						 if(a.getPersonal().getId().equals(p.getId())){
							  
							  list.add(a.getPersonal());
							 
								
						 }
				 }
				TaskManager entity = taskmanagerService.get(id);
				model.addAttribute("depts", deptList);
				 model.addAttribute("sems",batchList);
				 model.addAttribute("subs" , subList);
				 model.addAttribute("personalIdList", list);
		        model.addAttribute("taskmanager", entity);
		        model.addAttribute("action", "update");
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"invalid credential!","",null);
				return "redirect:/login";
			}
	        return "taskmanager/taskmanagerForm";
	    }
	 
	 
	 /**
	 * 更新表单数据
	 * @param user
	 * @return
	 */
	 @RequestMapping(value = "update", method = RequestMethod.POST)
	 @ResponseBody
	    public Message update(@Valid @ModelAttribute("preloadTaskManager") TaskManager taskmanager,
	            RedirectAttributes redirectAttributes , HttpServletRequest request) {
		 try {
			 	ShiroUser su = super.getLoginUser();
				User user = accountService.findUserByLoginName(su.getLoginName());
				if (user != null) {
					
					taskmanager.setTaskDate(request.getParameter("taskDate"));
					taskmanager.setSlotStartTime(request.getParameter("slotStartTime"));
					taskmanager.setSlotEndTime(request.getParameter("slotEndTime"));
					taskmanager.setDeptList(deptService.get(Long.parseLong(request.getParameter("deptName"))));
					taskmanager.setAllSemester(batchService.get(Long.parseLong(request.getParameter("semName"))));
					taskmanager.setSubList(subService.get(Long.parseLong(request.getParameter("subName"))));
					
					String auth=request.getParameter("authname");
					System.out.println("auth:"+auth);
					Long aId=0L;
					List<Authority> pIdList=authService.findSpecificId();
					for(Authority a:pIdList){
						if(auth.equals((a.getPersonal().getId().toString()))){
							aId=a.getId();
							System.out.println("aId=="+aId);
						}
						
					}
					taskmanager.setAuthorityList(authService.get(aId));
			    	taskmanagerService.save(taskmanager);
					msg.setSuccess(true);
					msg.setMessage("The Task has been updated successfully .");
					msg.setData(taskmanager);
				} else {
					logger.log(this.getClass(),Logger.ERROR_INT,"invalid credential!","",null);
					msg.setSuccess(false);
					msg.setMessage("The Task has been updated successfully .!");
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
					taskmanagerService.delete(ids);
					msg.setSuccess(true);
					msg.setMessage("Task deleted successfully");
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
	 
	 @RequestMapping(value = "view/{id}", method = RequestMethod.GET)
	    public String view(@PathVariable("id") Long id, Model model) {
		 	ShiroUser su = super.getLoginUser();
			User user = accountService.findUserByLoginName(su.getLoginName());
			if (user != null) {
				
				List<Department> deptList = deptService.getAllDepts();
				List<Batch> batchList=batchService.getAllBatches();
				List<Subject> subList=subService.getAllSubjects();
			 	TaskManager entity = taskmanagerService.get(id); 
			 	
			 	model.addAttribute("depts", deptList);
				model.addAttribute("sems",batchList);
				model.addAttribute("subs" , subList);
			 	model.addAttribute("taskmanager", entity);
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"invalid credential!","",null);
				return "redirect:/login";
			}
		 	return "taskmanager/taskmanagerView";
	    }
	 
	 
	   @ModelAttribute("preloadTaskManager")
	    public TaskManager getTaskManager(@RequestParam(value = "id", required = false) Long id) {
	        if (id != null) {
	            return taskmanagerService.get(id);
	        }
	        return null;
	    }
	   
	   @RequestMapping(value="export")
	   public void export(Model model, HttpServletRequest request,
			   			 @RequestParam(value="sortType", defaultValue = "auto") String sortType,
			   			 @RequestParam(value="page", defaultValue = "1") int pageNumber,
			   			 @RequestParam(value="order", defaultValue = "desc") String order,
			   			 @RequestParam(value="pageSize", defaultValue = "" + PAGE_SIZE) int pageSize,
			   			 HttpServletResponse response) throws IOException {
		   
		   HttpSession session = request.getSession();
		   session.setAttribute("state", null);
		   
		   response.setContentType("application/vnd.ms-excel");
		   OutputStream fOut = null;
		   
		   try {
			   response.setHeader("content-disposition", "attachment;filename*=UTF-8''" + "TaskManager.xls");
			   
			   HSSFWorkbook workbook = new HSSFWorkbook();
			   HSSFSheet sheet = workbook.createSheet();
			   
			   List<String> headingList = new ArrayList<String>();
			   headingList.clear();
			   headingList.add("Date Of Task");
			   headingList.add("Slot Start Time");
			   headingList.add("Slot End Time");
			   headingList.add("Department");
			   headingList.add("Semester");
			   headingList.add("Subject");
			   headingList.add("Teacher");
			   
			   
			   HSSFRow row1 = sheet.createRow(0);
			   for(int i=0; i < headingList.size(); i++){
				   HSSFCell cell = row1.createCell(i);
				   cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cell.setCellValue(headingList.get(i));
			   }
			   HSSFCell cells;
			   Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
			   Page<TaskManager> page = taskmanagerService.getAllTaskManager(searchParams, pageNumber, 100, sortType, order);
			   List<TaskManager> taskList = page.getContent();
			   
			   for(int i = 0; i < taskList.size(); i++){
				   HSSFRow row2 = sheet.createRow(i+1);
				   TaskManager param = taskList.get(i);
				   cells = row2.createCell(0);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getTaskDate());
				   cells = row2.createCell(1);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getSlotStartTime());
				   cells = row2.createCell(2);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getSlotEndTime());
				   cells = row2.createCell(3);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getDeptList().getDeptName());
				   cells = row2.createCell(4);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getAllSemester().getSemName());
				   cells = row2.createCell(5);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getSubList().getSubName());
				   cells = row2.createCell(6);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getAuthorityList().getPersonal().getFname()+" "+param.getAuthorityList().getPersonal().getLname());
				   
				   
			   }
			   for( int i =0; i < sheet.getRow(0).getPhysicalNumberOfCells(); i++){
				   sheet.autoSizeColumn(i);
			   }
			   
			   fOut = response.getOutputStream();
			   workbook.write(fOut);
			   workbook.close();
			   
		   }catch (Exception e1){
			   e1.printStackTrace();
		   }
		   
	   }

}