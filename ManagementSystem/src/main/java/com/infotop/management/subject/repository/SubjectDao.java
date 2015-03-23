package com.infotop.management.subject.repository;

import com.infotop.management.subject.entity.Subject;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface SubjectDao extends PagingAndSortingRepository<Subject, Long>, JpaSpecificationExecutor<Subject>  {

}