package com.infotop.management.roleasignment.repository;

import com.infotop.management.roleasignment.entity.RoleAsignment;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface RoleAsignmentDao extends PagingAndSortingRepository<RoleAsignment, Long>, JpaSpecificationExecutor<RoleAsignment>  {

}