package com.infotop.management.student.repository;

import com.infotop.management.student.entity.Student;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface StudentDao extends PagingAndSortingRepository<Student, Long>, JpaSpecificationExecutor<Student>  {

}