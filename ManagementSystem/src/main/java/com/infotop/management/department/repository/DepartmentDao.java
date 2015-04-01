package com.infotop.management.department.repository;

import com.infotop.management.department.entity.Department;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface DepartmentDao extends PagingAndSortingRepository<Department, Long>, JpaSpecificationExecutor<Department>  {

}