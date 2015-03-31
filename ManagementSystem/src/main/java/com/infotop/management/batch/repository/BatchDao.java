package com.infotop.management.batch.repository;

import com.infotop.management.batch.entity.Batch;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface BatchDao extends PagingAndSortingRepository<Batch, Long>, JpaSpecificationExecutor<Batch>  {

}