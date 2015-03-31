package com.infotop.management.taskmanager.entity;

import java.util.Date;

import com.infotop.common.IdEntity;

public class TaskManager extends IdEntity {
	
	private String deptId;
	private String pId;
	private String subId;
	private String semId;
	private String slotStartTime;
	private String slotEndTime;
	private Date taskDate;
	private boolean Flag;

}