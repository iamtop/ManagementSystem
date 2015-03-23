package com.infotop.management.roleasign.repository;

import com.infotop.management.roleasign.entity.RoleAsign;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface RoleAsignDao extends PagingAndSortingRepository<RoleAsign, Long>, JpaSpecificationExecutor<RoleAsign>  {

}