package com.infotop.management.branch.entity;

	
	import javax.persistence.Entity;
	import javax.persistence.Table;
    import com.infotop.common.IdEntity;
	@Entity
	@Table(name="ms_branch")
	public class Branch extends IdEntity{
		private String brId;
		private String brName;
		private String deptId;
		
		public String getBrId() {
			return brId;
		}
		public void setBrId(String brId) {
			this.brId = brId;
		}
		public String getBrName() {
			return brName;
		}
		public void setBrName(String brName) {
			this.brName = brName;
		}
		public String getDeptId() {
			return deptId;
		}
		public void setDeptId(String deptId) {
			this.deptId = deptId;
		}

}
