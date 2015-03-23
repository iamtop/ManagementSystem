package com.infotop.management.roleasign.service;

import java.util.List;
import java.util.Map;

import com.infotop.management.roleasign.entity.RoleAsign;
import com.infotop.management.roleasign.repository.RoleAsignDao;

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
 * RoleAsignManager
 * $Id: RoleAsignManager.java,v 0.0.1 2015-03-23 11:14:04  $
 */
@Component
@Transactional(readOnly = true)
public class RoleAsignService {
	
	
	@Autowired
	private RoleAsignDao roleAsignDao;
	
	@Autowired
	private BusinessLogger businessLogger;
	/**
	 * 保存一个RoleAsign，如果保存成功返回该对象的id，否则返回null
	 * @param entity
	 * @return 保存成功的对象的Id
	 */
	@Transactional(readOnly = false)
	public void save(RoleAsign entity){
		roleAsignDao.save(entity);
		Map logData = Maps.newHashMap();
		logData.put("ID", entity.getId());
		businessLogger.log("roleAsign", "SAVE", getCurrentUserName(), logData);
	}
	
	/**
	 * 根据一个ID得到RoleAsign
	 * 
	 * @param id
	 * @return
	 */
	public RoleAsign get(Long id){
		Map logData = Maps.newHashMap();
		logData.put("ID", id);
		businessLogger.log("roleAsign", "GET", getCurrentUserName(), logData);
		return roleAsignDao.findOne(id);
	}
	
	/**
	 * 删除一个RoleAsign
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = false)
    public void delete(Long id) {
        this.roleAsignDao.delete(id);
		Map logData = Maps.newHashMap();
		logData.put("ID", id);
		businessLogger.log("roleAsign", "DELETE", getCurrentUserName(), logData);
    }
	
	/**
	 * 批量删除RoleAsign
	 * @param ids
	 * @return
	 */
	@Transactional(readOnly = false)
	public void delete(List<Long> ids){
		List<RoleAsign> test = (List<RoleAsign>) this.roleAsignDao.findAll(ids);
		this.roleAsignDao.delete(test);
		Map logData = Maps.newHashMap();
		logData.put("IDS", ids);
		businessLogger.log("roleAsign", "DELETE", getCurrentUserName(), logData);
	}
	

	/**
	 * 删除操作，支持单个删除和批量删除
	 * @param ids 要删除的记录ID
	 * @param bool true:物理删除 false:逻辑删除
	 */
	/*@Transactional(readOnly = false)
	public void delete(List<Long> ids, boolean bool) {
		List<RoleAsign> temp = (List<RoleAsign>) this.roleAsignDao.findAll(ids);
		if (bool) {
			this.roleAsignDao.delete(temp);
		} else {
			if (temp != null && temp.size() > 0) {
				for (RoleAsign obj : temp) {
					obj.setFlag(1);
					this.roleAsignDao.save(obj);
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
    private Specification<RoleAsign> buildSpecification(Map<String, Object> filterParams) {
        Map<String, SearchFilter> filters = SearchFilter.parse(filterParams);
        Specification<RoleAsign> spec = DynamicSpecifications.bySearchFilter(filters.values(), RoleAsign.class);
        return spec;
    }
	
    
    public DataGrid dataGrid(Map<String, Object> searchParams, int pageNumber,
			int rows, String sortType, String order) {
		Page<RoleAsign> page = getAllRoleAsign(searchParams,
				pageNumber, rows, sortType, order);
		DataGrid dataGrid = new DataGrid();
		dataGrid.setTotal(page.getTotalElements());
		dataGrid.setRows(page.getContent());
		return dataGrid;
	}
    
    public Page<RoleAsign> getAllRoleAsign(
			Map<String, Object> filterParams, int pageNumber, int pageSize,
			String sortType, String order) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType, order);
		Specification<RoleAsign> spec = buildSpecification(filterParams);
		return roleAsignDao.findAll(spec, pageRequest);
	}
    
    /**
	 * 取出Shiro中的当前用户LoginName.
	 */
	public String getCurrentUserName() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.loginName;
	}
}
