package com.infotop.management.branch.repository;

import com.infotop.management.branch.entity.Branch;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface BranchDao extends PagingAndSortingRepository<Branch, Long>, JpaSpecificationExecutor<Branch>  {

}