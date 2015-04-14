<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div id="three">
	<div class="contenttable">
		<h3>
			<spring:message code="authority_title" />
		</h3>
		<div class="contenttable1">
			<table class="content" style="width: 99%;" cellpadding="0" cellspacing="0" >
				<tr>
				<td class="biao_bt3">Personal Id</td>
				<td>${authority.personal.pId}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Department</td>
				<td>${authority.deptList.deptName}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Role</td>
				<td>${authority.roleList.roleName}</td>
				</tr>
				<tr>
				<td class="biao_bt3">First name</td>
				<td>${authority.personal.fname}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Last Name</td>
				<td>${authority.personal.lname}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Address</td>
				<td>${authority.personal.email}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Phone</td>
				<td>${authority.personal.phone}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Gender</td>
				<td>${authority.personal.gender}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Father Name</td>
				<td>${authority.personal.fatherName}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Mother Name</td>
				<td>${authority.personal.motherName}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Date of Birth</td>
				<td>${authority.personal.dob}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Date of Join</td>
				<td>${authority.personal.doj}</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
$ .parser.onComplete = function() {
	parent.$ .messager.progress('close');
};
</script>



