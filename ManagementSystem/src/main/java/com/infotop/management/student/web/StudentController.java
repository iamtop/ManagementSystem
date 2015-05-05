package com.infotop.management.student.web;


import com.infotop.management.authority.entity.Authority;
import com.infotop.management.batch.entity.Batch;
import com.infotop.management.batch.service.BatchService;
import com.infotop.management.department.entity.Department;
import com.infotop.management.department.service.DepartmentService;
import com.infotop.management.personaldetails.entity.PersonalDetails;
import com.infotop.management.personaldetails.service.PersonalDetailsService;
import com.infotop.management.student.service.StudentService;
import com.infotop.management.student.entity.Student;
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
 * StudentAction
 * $Id: StudentAction.java,v 0.0.1 2015-04-13 14:08:11  $
 */
@Controller
@RequestMapping(value = "/student")
public class StudentController extends BasicController {
    

    @Autowired
    private StudentService studentService;
    @Autowired
	private DepartmentService deptService;
    @Autowired
   	private BatchService batchService;
    @Autowired
    private PersonalDetailsService detailsService;
	
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
       return "student/studentList";
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
				dataGrid = studentService.dataGrid(searchParams, pageNumber,
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
				 Student entity = new Student(); 
				 List<Department> deptList = deptService.getAllDepts();
				 List<Batch> batchList = batchService.getAllBatches();
				
				  model.addAttribute("depts", deptList);
				  model.addAttribute("sems", batchList);
			      model.addAttribute("student", entity);
			      model.addAttribute("action", "create");
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
	     return "student/studentForm";
	 }
	 
	/**
	 * 保存表单数据
	 * @return
	 */
	 @RequestMapping(value = "create", method = RequestMethod.POST)
	 @ResponseBody
	 public Message create(@Valid Student student, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		try {
			
			ShiroUser su = super.getLoginUser();
			User user = accountService.findUserByLoginName(su.getLoginName());
			if (user != null) {
				PersonalDetails personal = new PersonalDetails();
				String depts = request.getParameter("deptName");
				String sems = request.getParameter("semName");
				
				Department dpt = deptService.get(Long.parseLong(depts));
				Batch sem = batchService.get(Long.parseLong(sems));
				
				student.setDeptList(dpt);
				student.setBatchList(sem);
		    	
				personal.setpId(request.getParameter("pId"));
				personal.setFname(request.getParameter("fname"));
				personal.setLname(request.getParameter("lname"));
				personal.setAddress(request.getParameter("address"));
				personal.setEmail(request.getParameter("email"));
				personal.setPhone(request.getParameter("phone"));
				personal.setGender(request.getParameter("gender"));
				personal.setFatherName(request.getParameter("fathername"));
				personal.setMotherName(request.getParameter("mothername"));
				personal.setDob(request.getParameter("dob"));
				personal.setDoj(request.getParameter("doj"));
				detailsService.save(personal);
				

				student.setPersonal(personal);
				studentService.save(student);
				msg.setSuccess(true);
				msg.setMessage("信息添加成功");
				msg.setData(student);
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
				Student entity = studentService.get(id); 
				 List<Department> deptList = deptService.getAllDepts();
				 List<Batch> batchList = batchService.getAllBatches();
				 //List<PersonalDetails> personalList = detailsService.findSpecificId();
				
				model.addAttribute("depts", deptList);
				model.addAttribute("sems", batchList);
		        model.addAttribute("student", entity);
		        model.addAttribute("action", "update");
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
	        return "student/studentForm";
	    }
	 
	 
	 /**
	 * 更新表单数据
	 * @param user
	 * @return
	 */
	 @RequestMapping(value = "update", method = RequestMethod.POST)
	 @ResponseBody
	    public Message update(@Valid @ModelAttribute("preloadStudent") Student student,
	            RedirectAttributes redirectAttributes,HttpServletRequest request) {
		 try {
			 	ShiroUser su = super.getLoginUser();
				User user = accountService.findUserByLoginName(su.getLoginName());
				if (user != null) {
					
					PersonalDetails personal = new PersonalDetails();
					String depts = request.getParameter("deptName");
					String sems = request.getParameter("semName");
					
					Department dpt = deptService.get(Long.parseLong(depts));
					Batch sem = batchService.get(Long.parseLong(sems));
					
					student.setDeptList(dpt);
					student.setBatchList(sem);
			    	
					personal.setpId(request.getParameter("pId"));
					System.out.println("ppppppppppppppppppppp"+request.getParameter("pId"));
					personal.setFname(request.getParameter("fname"));
					personal.setLname(request.getParameter("lname"));
					personal.setAddress(request.getParameter("address"));
					personal.setEmail(request.getParameter("email"));
					personal.setPhone(request.getParameter("phone"));
					personal.setGender(request.getParameter("gender"));
					personal.setFatherName(request.getParameter("fathername"));
					personal.setMotherName(request.getParameter("mothername"));
					personal.setDob(request.getParameter("dob"));
					personal.setDoj(request.getParameter("doj"));
					detailsService.save(personal);
					

					student.setPersonal(personal);
					studentService.save(student);
			    	studentService.save(student);
					msg.setSuccess(true);
					msg.setMessage("信息更新成功");
					msg.setData(student);
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
					studentService.delete(ids);
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
			 	Student entity = studentService.get(id); 
			 	model.addAttribute("student", entity);
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
		 	return "student/studentView";
	    }
	 
	 
	   @ModelAttribute("preloadStudent")
	    public Student getStudent(@RequestParam(value = "id", required = false) Long id) {
	        if (id != null) {
	            return studentService.get(id);
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
			   response.setHeader("content-disposition", "attachment;filename*=UTF-8''" + "Student.xls");
			   
			   HSSFWorkbook workbook = new HSSFWorkbook();
			   HSSFSheet sheet = workbook.createSheet();
			   
			   List<String> headingList = new ArrayList<String>();
			   headingList.clear();
			   headingList.add("Student Id");
			   headingList.add("Personal Id");
			   headingList.add("Department");
			   headingList.add("Semester");
			   headingList.add("Name");
			   headingList.add("Address");
			   headingList.add("E-mail");
			   headingList.add("Phone");
			   headingList.add("Gender");
			   headingList.add("Father Name");
			   headingList.add("Mother Name");
			   headingList.add("Date of Birth");
			   headingList.add("Date of Join");
			   
			   HSSFRow row1 = sheet.createRow(0);
			   for(int i=0; i < headingList.size(); i++){
				   HSSFCell cell = row1.createCell(i);
				   cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cell.setCellValue(headingList.get(i));
			   }
			   HSSFCell cells;
			   Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
			   Page<Student> page = studentService.getAllStudent(searchParams, pageNumber, 100, sortType, order);
			   List<Student> studentList = page.getContent();
			   
			   for(int i = 0; i < studentList.size(); i++){
				   HSSFRow row2 = sheet.createRow(i+1);
				   Student param = studentList.get(i);
				   cells = row2.createCell(0);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getStudId());
				   cells = row2.createCell(1);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getPersonal().getpId());
				   cells = row2.createCell(2);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getDeptList().getDeptName());
				   cells = row2.createCell(3);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getBatchList().getSemName());
				   cells = row2.createCell(4);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getPersonal().getFname()+" "+param.getPersonal().getLname());
				   cells = row2.createCell(5);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getPersonal().getAddress());
				   cells = row2.createCell(6);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getPersonal().getEmail());
				   cells = row2.createCell(7);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getPersonal().getPhone());
				   cells = row2.createCell(8);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getPersonal().getGender());
				   cells = row2.createCell(9);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getPersonal().getFatherName());
				   cells = row2.createCell(10);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getPersonal().getMotherName());
				   cells = row2.createCell(11);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getPersonal().getDob());
				   cells = row2.createCell(12);
				   cells.setCellType(HSSFCell.CELL_TYPE_STRING);
				   cells.setCellValue(param.getPersonal().getDoj());
				   
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