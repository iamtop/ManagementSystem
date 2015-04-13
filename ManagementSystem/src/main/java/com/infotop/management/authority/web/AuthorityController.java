package com.infotop.management.authority.web;


import com.infotop.management.authority.service.AuthorityService;
import com.infotop.management.authority.entity.Authority;
import com.infotop.management.department.entity.Department;
import com.infotop.management.department.service.DepartmentService;
import com.infotop.management.personaldetails.entity.PersonalDetails;
import com.infotop.management.personaldetails.service.PersonalDetailsService;
import com.infotop.management.roleasignment.entity.RoleAsignment;
import com.infotop.management.roleasignment.service.RoleAsignmentService;
import com.infotop.system.account.entity.User;
import com.infotop.system.account.service.ShiroDbRealm.ShiroUser;
import com.infotop.common.BasicController;

import net.infotop.web.easyui.DataGrid;
import net.infotop.web.easyui.Message;
import ch.qos.logback.classic.Logger;

import org.springside.modules.web.Servlets;









import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
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
 * AuthorityAction
 * $Id: AuthorityAction.java,v 0.0.1 2015-04-08 09:24:25  $
 */
@Controller
@RequestMapping(value = "/authority")
public class AuthorityController extends BasicController {
    
	@Autowired
    private PersonalDetailsService detailsService;
	
	@Autowired
	private DepartmentService deptService;
	
	@Autowired
	private RoleAsignmentService roleAsignmentService;
	
    @Autowired
    private AuthorityService authorityService;
	
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
       return "authority/authorityList";
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
				dataGrid = authorityService.dataGrid(searchParams, pageNumber,
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
				 Authority entity = new Authority(); 
				 List<RoleAsignment> roleList = roleAsignmentService.getRoles();
				 List<Department> deptList = deptService.getAllDepts();
			     model.addAttribute("roles", roleList);
			     model.addAttribute("depts", deptList);
			     model.addAttribute("authority", entity);
			     model.addAttribute("action", "create");
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
	     return "authority/authorityForm";
	 }
	 
	/**
	 * 保存表单数据
	 * @return
	 */
	 @RequestMapping(value = "create", method = RequestMethod.POST)
	 @ResponseBody
	 public Message create(@Valid Authority authority, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		try {
			ShiroUser su = super.getLoginUser();
			User user = accountService.findUserByLoginName(su.getLoginName());
			if (user != null) {
				
				Long iid = null;
				
				PersonalDetails personal = new PersonalDetails();
				
				String pId = request.getParameter("pId");
//				String fName = request.getParameter("fname");
//				String lName = request.getParameter("lname");
//				String addr = request.getParameter("address");
//				String email = request.getParameter("email");
//				String phone = request.getParameter("phone");
//				String gender = request.getParameter("gender");
//				String father = request.getParameter("fathername");
//				String mother = request.getParameter("mothername");
//				String dob = request.getParameter("dob");
//				String doj = request.getParameter("doj");
				String dept = request.getParameter("deptName");
				String role = request.getParameter("roleName");
				
				
				personal.setpId(pId);
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
				
				List<PersonalDetails> pd= detailsService.findSpecificId();
				for (PersonalDetails i: pd){
					if(pId.equals(i.getpId())){
						iid = i.getId();	
					}
				}
				personal = detailsService.get(iid);
				Department dpt = deptService.get(Long.parseLong(dept));
				RoleAsignment rol = roleAsignmentService.get(Long.parseLong(role));
				
				authority.setPersonal(personal);
				authority.setDeptList(dpt);
				authority.setRoleList(rol);
		    	authorityService.save(authority);
				msg.setSuccess(true);
				msg.setMessage("信息添加成功");
				msg.setData(authority);
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
				
				List<RoleAsignment> roleList = roleAsignmentService.getRoles();
				List<Department> deptList = deptService.getAllDepts();
				List<PersonalDetails> personal = detailsService.findSpecificId();
				
				Authority entity = authorityService.get(id); 
				model.addAttribute("depts", deptList);
				model.addAttribute("roles", roleList);
		        model.addAttribute("authority", entity);
		        model.addAttribute("action", "update");
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
	        return "authority/authorityForm";
	    }
	 
	 
	 /**
	 * 更新表单数据
	 * @param user
	 * @return
	 */
	 @RequestMapping(value = "update", method = RequestMethod.POST)
	 @ResponseBody
	    public Message update(@Valid @ModelAttribute("preloadAuthority") Authority authority,
	            RedirectAttributes redirectAttributes) {
		 try {
			 	ShiroUser su = super.getLoginUser();
				User user = accountService.findUserByLoginName(su.getLoginName());
				if (user != null) {
			    	authorityService.save(authority);
					msg.setSuccess(true);
					msg.setMessage("信息更新成功");
					msg.setData(authority);
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
					authorityService.delete(ids);
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
			 	Authority entity = authorityService.get(id); 
			 	model.addAttribute("authority", entity);
			} else {
				logger.log(this.getClass(),Logger.ERROR_INT,"登陆帐号无效!","",null);
				return "redirect:/login";
			}
		 	return "authority/authorityView";
	    }
	 
	 
	   @ModelAttribute("preloadAuthority")
	    public Authority getAuthority(@RequestParam(value = "id", required = false) Long id) {
	        if (id != null) {
	            return authorityService.get(id);
	        }
	        return null;
	    }

}