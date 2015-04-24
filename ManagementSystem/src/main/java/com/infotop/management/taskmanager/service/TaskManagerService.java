package com.infotop.management.taskmanager.service;

import java.util.List;
import java.util.Map;

import com.infotop.management.authority.entity.Authority;
import com.infotop.management.taskmanager.entity.TaskManager;
import com.infotop.management.taskmanager.repository.TaskManagerDao;
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
 * TaskManagerManager
 * $Id: TaskManagerManager.java,v 0.0.1 2015-04-09 14:44:22  $
 */
@Component
@Transactional(readOnly = true)
public class TaskManagerService {
	
	
	@Autowired
	private TaskManagerDao taskManagerDao;
	
	@Autowired
	private BusinessLogger businessLogger;
	/**
	 * 保存一个TaskManager，如果保存成功返回该对象的id，否则返回null
	 * @param entity
	 * @return 保存成功的对象的Id
	 */
	@Transactional(readOnly = false)
	public void save(TaskManager entity){
		taskManagerDao.save(entity);
		Map logData = Maps.newHashMap();
		logData.put("ID", entity.getId());
		businessLogger.log("taskManager", "SAVE", getCurrentUserName(), logData);
	}
	
	/**
	 * 根据一个ID得到TaskManager
	 * 
	 * @param id
	 * @return
	 */
	public TaskManager get(Long id){
		Map logData = Maps.newHashMap();
		logData.put("ID", id);
		businessLogger.log("taskManager", "GET", getCurrentUserName(), logData);
		return taskManagerDao.findOne(id);
	}
	
	/**
	 * 删除一个TaskManager
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = false)
    public void delete(Long id) {
        this.taskManagerDao.delete(id);
		Map logData = Maps.newHashMap();
		logData.put("ID", id);
		businessLogger.log("taskManager", "DELETE", getCurrentUserName(), logData);
    }
	
	/**
	 * 批量删除TaskManager
	 * @param ids
	 * @return
	 */
	@Transactional(readOnly = false)
	public void delete(List<Long> ids){
		List<TaskManager> test = (List<TaskManager>) this.taskManagerDao.findAll(ids);
		this.taskManagerDao.delete(test);
		Map logData = Maps.newHashMap();
		logData.put("IDS", ids);
		businessLogger.log("taskManager", "DELETE", getCurrentUserName(), logData);
	}
	

	/**
	 * 删除操作，支持单个删除和批量删除
	 * @param ids 要删除的记录ID
	 * @param bool true:物理删除 false:逻辑删除
	 */
	/*@Transactional(readOnly = false)
	public void delete(List<Long> ids, boolean bool) {
		List<TaskManager> temp = (List<TaskManager>) this.taskManagerDao.findAll(ids);
		if (bool) {
			this.taskManagerDao.delete(temp);
		} else {
			if (temp != null && temp.size() > 0) {
				for (TaskManager obj : temp) {
					obj.setFlag(1);
					this.taskManagerDao.save(obj);
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
    private Specification<TaskManager> buildSpecification(Map<String, Object> filterParams) {
        Map<String, SearchFilter> filters = SearchFilter.parse(filterParams);
        Specification<TaskManager> spec = DynamicSpecifications.bySearchFilter(filters.values(), TaskManager.class);
        return spec;
    }
	
    
    public DataGrid dataGrid(Map<String, Object> searchParams, int pageNumber,
			int rows, String sortType, String order) {
		Page<TaskManager> page = getAllTaskManager(searchParams,
				pageNumber, rows, sortType, order);
		DataGrid dataGrid = new DataGrid();
		dataGrid.setTotal(page.getTotalElements());
		dataGrid.setRows(page.getContent());
		return dataGrid;
	}
    
    public Page<TaskManager> getAllTaskManager(
			Map<String, Object> filterParams, int pageNumber, int pageSize,
			String sortType, String order) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType, order);
		Specification<TaskManager> spec = buildSpecification(filterParams);
		return taskManagerDao.findAll(spec, pageRequest);
	}
    
    /**
	 * 取出Shiro中的当前用户LoginName.
	 */
	public String getCurrentUserName() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.loginName;
	}
	public List<TaskManager> findSpecificId() {
		return (List<TaskManager>) taskManagerDao.findAll();
		}
	
}
