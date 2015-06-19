package com.infotop.management.attendance.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.infotop.management.attendance.entity.Attendance;
import com.infotop.management.attendance.repository.AttendanceDao;
import com.infotop.management.batch.entity.Batch;
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
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.DynamicSpecifications;
import org.springside.modules.persistence.SearchFilter;

/**
 * AttendanceManager
 * $Id: AttendanceManager.java,v 0.0.1 2015-04-21 08:17:51  $
 */
@Component
@Transactional(readOnly = true)
public class AttendanceService {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	@Autowired
	private AttendanceDao attendanceDao;
	
	@Autowired
	private BusinessLogger businessLogger;
	/**
	 * 保存一个Attendance，如果保存成功返回该对象的id，否则返回null
	 * @param entity
	 * @return 保存成功的对象的Id
	 */
	@Transactional(readOnly = false)
	public void save(Attendance entity){
		attendanceDao.save(entity);
		Map logData = Maps.newHashMap();
		logData.put("ID", entity.getId());
		businessLogger.log("attendance", "SAVE", getCurrentUserName(), logData);
	}
	
	/**
	 * 根据一个ID得到Attendance
	 * 
	 * @param id
	 * @return
	 */
	public Attendance get(Long id){
		Map logData = Maps.newHashMap();
		logData.put("ID", id);
		businessLogger.log("attendance", "GET", getCurrentUserName(), logData);
		return attendanceDao.findOne(id);
	}
	
	/**
	 * 删除一个Attendance
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = false)
    public void delete(Long id) {
        this.attendanceDao.delete(id);
		Map logData = Maps.newHashMap();
		logData.put("ID", id);
		businessLogger.log("attendance", "DELETE", getCurrentUserName(), logData);
    }
	
	/**
	 * 批量删除Attendance
	 * @param ids
	 * @return
	 */
	@Transactional(readOnly = false)
	public void delete(List<Long> ids){
		List<Attendance> test = (List<Attendance>) this.attendanceDao.findAll(ids);
		this.attendanceDao.delete(test);
		Map logData = Maps.newHashMap();
		logData.put("IDS", ids);
		businessLogger.log("attendance", "DELETE", getCurrentUserName(), logData);
	}
	

	/**
	 * 删除操作，支持单个删除和批量删除
	 * @param ids 要删除的记录ID
	 * @param bool true:物理删除 false:逻辑删除
	 */
	/*@Transactional(readOnly = false)
	public void delete(List<Long> ids, boolean bool) {
		List<Attendance> temp = (List<Attendance>) this.attendanceDao.findAll(ids);
		if (bool) {
			this.attendanceDao.delete(temp);
		} else {
			if (temp != null && temp.size() > 0) {
				for (Attendance obj : temp) {
					obj.setFlag(1);
					this.attendanceDao.save(obj);
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
    private Specification<Attendance> buildSpecification(Map<String, Object> filterParams) {
        Map<String, SearchFilter> filters = SearchFilter.parse(filterParams);
        Specification<Attendance> spec = DynamicSpecifications.bySearchFilter(filters.values(), Attendance.class);
        return spec;
    }
	
    
    public DataGrid dataGrid(Map<String, Object> searchParams, int pageNumber,
			int rows, String sortType, String order,String deptId, String batchId, String timeSlotStart) {
		/*Page<Attendance> page = getAllAttendance(searchParams,
				pageNumber, rows, sortType, order);*/
		DataGrid dataGrid = new DataGrid();
		
		Calendar dt= Calendar.getInstance();
		SimpleDateFormat smdf = new SimpleDateFormat("yyyy-MM-dd");
		String curDate = smdf.format(dt.getTime());

		String sql = "select * from attendancelist";
		String whereSql="";
		String sql1 = "select * from attendancelist a where a.id =-999";
		
		if(deptId.isEmpty() || batchId.isEmpty() || timeSlotStart.isEmpty()){
			dataGrid.setRows(jdbcTemplate.queryForList(sql1));
		}
		if(!deptId.isEmpty() && !batchId.isEmpty() && !timeSlotStart.isEmpty()){
			 whereSql+=" where ";
		}
		
		if(!deptId.isEmpty() && !batchId.isEmpty() && (!timeSlotStart.isEmpty())){
			whereSql+= "Department=\""+deptId+"\" AND Semester= \""+batchId+"\" AND slot_start_time=\""+timeSlotStart+"\" AND task_date=\""+curDate+"\"";
			dataGrid.setRows(jdbcTemplate.queryForList(sql+whereSql));
		}

//		dataGrid.setRows(jdbcTemplate.queryForList(sql));
		
		
		return dataGrid;
	}
    
    public Page<Attendance> getAllAttendance(
			Map<String, Object> filterParams, int pageNumber, int pageSize,
			String sortType, String order) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType, order);
		Specification<Attendance> spec = buildSpecification(filterParams);
		return attendanceDao.findAll(spec, pageRequest);
	}
    
    /**
	 * 取出Shiro中的当前用户LoginName.
	 */
	public String getCurrentUserName() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.loginName;
	}
	
	public List<Attendance> getAllAttendance() {
		return (List<Attendance>) attendanceDao.findAll();
	}
}
