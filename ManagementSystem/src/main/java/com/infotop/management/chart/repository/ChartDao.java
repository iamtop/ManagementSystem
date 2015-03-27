package com.infotop.management.chart.repository;

import com.infotop.management.chart.entity.Chart;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface ChartDao extends PagingAndSortingRepository<Chart, Long>, JpaSpecificationExecutor<Chart>  {

}