package com.infotop.management.attendance.repository;

import com.infotop.management.attendance.entity.Attendance;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface AttendanceDao extends PagingAndSortingRepository<Attendance, Long>, JpaSpecificationExecutor<Attendance>  {

}