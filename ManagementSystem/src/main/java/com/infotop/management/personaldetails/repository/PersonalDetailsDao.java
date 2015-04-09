package com.infotop.management.personaldetails.repository;

import com.infotop.management.personaldetails.entity.PersonalDetails;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface PersonalDetailsDao extends PagingAndSortingRepository<PersonalDetails, Long>, JpaSpecificationExecutor<PersonalDetails>  {


}