package com.infotop.management.subject.web;


import com.infotop.management.batch.entity.Batch;
import com.infotop.management.batch.service.BatchService;
import com.infotop.management.department.entity.Department;
import com.infotop.management.department.service.DepartmentService;
import com.infotop.management.subject.service.SubjectService;
import com.infotop.management.subject.entity.Subject;
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
 * SubjectAction
 * $Id: SubjectAction.java,v 0.0.1 2015-04-10 08:34:16  $
 */
@Controller
@RequestMapping(value = "/subject")
public class SubjectController extends BasicController {
    

    @Autowired
    private SubjectService subjectService;
	@Autowired
	private DepartmentService deptService;
	@Autowired
	private BatchService batchService;
	
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
       return "subject/subjectList";
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
				dataGrid = subjectService.dataGrid(searchParams, pageNumber,
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
				 Subject entity = new Subject();
				 List<Department> deptList = deptService.getAllDepts();
				 List<Batch> batchList = batchService.getAllBatches();
				 model.addAttribute("depts", deptList);
				 model.addAttribute("sem", batchList);

			     model.addAttribute("subject", entity);
			     model.addAttribute("action", "create");
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
	     return "subject/subjectForm";
	 }
	 
	/**
	 * 保存表单数据
	 * @return
	 */
	 @RequestMapping(value = "create", method = RequestMethod.POST)
	 @ResponseBody
	 public Message create(@Valid Subject subject, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		try {
			ShiroUser su = super.getLoginUser();
			User user = accountService.findUserByLoginName(su.getLoginName());
			if (user != null) {
				
				String depts = request.getParameter("deptName");
				System.out.println("-------------------------------------------"+depts);
				String sems = request.getParameter("semName");
				System.out.println("-------------------------------------------"+sems);
				Department dpt = deptService.get(Long.parseLong(depts));
				Batch batch = batchService.get(Long.parseLong(sems));
				
				subject.setDeptList(dpt);
				subject.setBatchList(batch);
		    	subjectService.save(subject);
				msg.setSuccess(true);
				msg.setMessage("信息添加成功");
				msg.setData(subject);
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
				Subject entity = subjectService.get(id);
				 List<Department> deptList = deptService.getAllDepts();
				 List<Batch> batchList = batchService.getAllBatches();
				 System.out.println("deptList========================="+deptList);
				 System.out.println("deptList========================="+batchList);
				 model.addAttribute("depts", deptList);
				 model.addAttribute("sem", batchList);
		        
				 model.addAttribute("subject", entity);
		         model.addAttribute("action", "update");
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
	        return "subject/subjectForm";
	    }
	 
	 
	 /**
	 * 更新表单数据
	 * @param user
	 * @return
	 */
	 @RequestMapping(value = "update", method = RequestMethod.POST)
	 @ResponseBody
	    public Message update(@Valid @ModelAttribute("preloadSubject") Subject subject,
	            RedirectAttributes redirectAttributes,HttpServletRequest request) {
		 try {
			 	ShiroUser su = super.getLoginUser();
				User user = accountService.findUserByLoginName(su.getLoginName());
				if (user != null) {
					String depts = request.getParameter("deptName");
					System.out.println("++++++++++++++++"+depts);
					String sems = request.getParameter("semName");
					System.out.println("++++++++++++++++++++"+sems);
					Department dpt = deptService.get(Long.parseLong(depts));
					Batch sem = batchService.get(Long.parseLong(sems));
					subject.setDeptList(dpt);
					subject.setBatchList(sem);
			    	
					subjectService.save(subject);
					msg.setSuccess(true);
					msg.setMessage("信息更新成功");
					msg.setData(subject);
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
					subjectService.delete(ids);
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
				
			 	Subject entity = subjectService.get(id); 
			 
			 	model.addAttribute("subject", entity);
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
		 	return "subject/subjectView";
	    }
	 
	 
	   @ModelAttribute("preloadSubject")
	    public Subject getSubject(@RequestParam(value = "id", required = false) Long id) {
	        if (id != null) {
	            return subjectService.get(id);
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
			   response.setHeader("content-disposition", "attachment;filename*=UTF-8''" + "Subject.xls");
			   
			   HSSFWorkbook workbook = new HSSFWorkbook();
			   HSSFSheet sheet = workbook.createSheet();
			   
			   List<String> headingList = new ArrayList<String>();
			   headingList.clear();
			   headingList.add("Subject Code");
			   headingList.add("Subject Name");
			   headingList.add("Department");
			   headingList.add("Semester");
			   
			   HSSFRow row1 = sheet.createRow(0);
			   for(int i=0; i < headingList.size(); i++){
				   HSSFCell cell = row1.createCell(i);
				   cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cell.setCellValue(headingList.get(i));
			   }
			   
			   HSSFCell cells;
			   Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
			   Page<Subject> page = subjectService.getAllSubject(searchParams, pageNumber, 100, sortType, order);
			   List<Subject> subList = page.getContent();
			   
			   for(int i = 0; i < subList.size(); i++){
				   HSSFRow row2 = sheet.createRow(i+1);
				   Subject param = subList.get(i);
				   cells = row2.createCell(0);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getSubId());
				   cells = row2.createCell(1);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getSubName());
				   cells = row2.createCell(2);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getDeptList().getDeptName());
				   cells = row2.createCell(3);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getBatchList().getSemName());
			   }
			   fOut = response.getOutputStream();
			   workbook.write(fOut);
			   workbook.close();
			   
		   }catch (Exception e1){
			   e1.printStackTrace();
		   }
		   
	   }
	   
}