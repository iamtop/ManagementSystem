package com.infotop.management.authority.repository;

import com.infotop.management.authority.entity.Authority;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface AuthorityDao extends PagingAndSortingRepository<Authority, Long>, JpaSpecificationExecutor<Authority>  {

}