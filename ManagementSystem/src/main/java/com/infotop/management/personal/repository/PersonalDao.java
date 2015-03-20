package com.infotop.management.personal.repository;

import com.infotop.management.personal.entity.Personal;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface PersonalDao extends PagingAndSortingRepository<Personal, Long>, JpaSpecificationExecutor<Personal>  {

}