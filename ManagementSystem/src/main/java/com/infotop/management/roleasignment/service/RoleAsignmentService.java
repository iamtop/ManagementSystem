package com.infotop.management.roleasignment.service;

import java.util.List;
import java.util.Map;

import com.infotop.management.roleasignment.entity.RoleAsignment;
import com.infotop.management.roleasignment.repository.RoleAsignmentDao;

import com.google.common.collect.Maps;
import com.infotop.common.log.BusinessLogger;
import com.infotop.system.account.service.ShiroDbRealm.ShiroUser;

import net.infotop.web.easyui.DataGrid;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.DynamicSpecifications;
import org.springside.modules.persistence.SearchFilter;

/**
 * RoleAsignmentManager
 * $Id: RoleAsignmentManager.java,v 0.0.1 2015-03-31 11:20:32  $
 */
@Component
@Transactional(readOnly = true)
public class RoleAsignmentService {
	
	
	@Autowired
	private RoleAsignmentDao roleAsignmentDao;
	
	@Autowired
	private BusinessLogger businessLogger;
	/**
	 * 保存一个RoleAsignment，如果保存成功返回该对象的id，否则返回null
	 * @param entity
	 * @return 保存成功的对象的Id
	 */
	@Transactional(readOnly = false)
	public void save(RoleAsignment entity){
		roleAsignmentDao.save(entity);
		Map logData = Maps.newHashMap();
		logData.put("ID", entity.getId());
		businessLogger.log("roleAsignment", "SAVE", getCurrentUserName(), logData);
	}
	
	/**
	 * 根据一个ID得到RoleAsignment
	 * 
	 * @param id
	 * @return
	 */
	public RoleAsignment get(Long id){
		Map logData = Maps.newHashMap();
		logData.put("ID", id);
		businessLogger.log("roleAsignment", "GET", getCurrentUserName(), logData);
		return roleAsignmentDao.findOne(id);
	}
	
	/**
	 * 删除一个RoleAsignment
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = false)
    public void delete(Long id) {
        this.roleAsignmentDao.delete(id);
		Map logData = Maps.newHashMap();
		logData.put("ID", id);
		businessLogger.log("roleAsignment", "DELETE", getCurrentUserName(), logData);
    }
	
	/**
	 * 批量删除RoleAsignment
	 * @param ids
	 * @return
	 */
	@Transactional(readOnly = false)
	public void delete(List<Long> ids){
		List<RoleAsignment> test = (List<RoleAsignment>) this.roleAsignmentDao.findAll(ids);
		this.roleAsignmentDao.delete(test);
		Map logData = Maps.newHashMap();
		logData.put("IDS", ids);
		businessLogger.log("roleAsignment", "DELETE", getCurrentUserName(), logData);
	}
	

	/**
	 * 删除操作，支持单个删除和批量删除
	 * @param ids 要删除的记录ID
	 * @param bool true:物理删除 false:逻辑删除
	 */
	/*@Transactional(readOnly = false)
	public void delete(List<Long> ids, boolean bool) {
		List<RoleAsignment> temp = (List<RoleAsignment>) this.roleAsignmentDao.findAll(ids);
		if (bool) {
			this.roleAsignmentDao.delete(temp);
		} else {
			if (temp != null && temp.size() > 0) {
				for (RoleAsignment obj : temp) {
					obj.setFlag(1);
					this.roleAsignmentDao.save(obj);
				}
			}
		}
	}*/
   
   
    /**
	 * 创建分页请求.
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize,
			String sortType, String order) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			if ("asc".equalsIgnoreCase(order)) {
				sort = new Sort(Direction.ASC, "id");
			} else {
				sort = new Sort(Direction.DESC, "id");
			}
		} else {
			if ("asc".equalsIgnoreCase(order)) {
				sort = new Sort(Direction.ASC, sortType);
			} else {
				sort = new Sort(Direction.DESC, sortType);
			}
		}
		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}

    /**
     * 创建动态查询条件组合.
     */
    private Specification<RoleAsignment> buildSpecification(Map<String, Object> filterParams) {
        Map<String, SearchFilter> filters = SearchFilter.parse(filterParams);
        Specification<RoleAsignment> spec = DynamicSpecifications.bySearchFilter(filters.values(), RoleAsignment.class);
        return spec;
    }
	
    
    public DataGrid dataGrid(Map<String, Object> searchParams, int pageNumber,
			int rows, String sortType, String order) {
		Page<RoleAsignment> page = getAllRoleAsignment(searchParams,
				pageNumber, rows, sortType, order);
		DataGrid dataGrid = new DataGrid();
		dataGrid.setTotal(page.getTotalElements());
		dataGrid.setRows(page.getContent());
		return dataGrid;
	}
    
    public Page<RoleAsignment> getAllRoleAsignment(
			Map<String, Object> filterParams, int pageNumber, int pageSize,
			String sortType, String order) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType, order);
		Specification<RoleAsignment> spec = buildSpecification(filterParams);
		return roleAsignmentDao.findAll(spec, pageRequest);
	}
    
    /**
	 * 取出Shiro中的当前用户LoginName.
	 */
	public String getCurrentUserName() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.loginName;
	}

	public List<RoleAsignment> getRoles() {
		return (List<RoleAsignment>) roleAsignmentDao.findAll();
	}
}
