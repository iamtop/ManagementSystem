package com.infotop.management.batch.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.infotop.common.IdEntity;

@Entity
@Table(name="ms_batch")
public class Batch extends IdEntity{
	
	private String semId;
	private String semName;
	public String getSemId() {
		return semId;
	}
	public void setSemId(String semId) {
		this.semId = semId;
	}
	public String getSemName() {
		return semName;
	}
	public void setSemName(String semName) {
		this.semName = semName;
	}

}
