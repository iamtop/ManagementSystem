package com.infotop.management.taskmanager.repository;

import com.infotop.management.taskmanager.entity.TaskManager;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface TaskManagerDao extends PagingAndSortingRepository<TaskManager, Long>, JpaSpecificationExecutor<TaskManager>  {

}