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
				<td class="biao_bt3"><spring:message code="personaldetails_pId" /></td>
				<td>${authority.personal.pId}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="department_title" /></td>
				<td>${authority.deptList.deptName}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="roleasignment_roleName" /></td>
				<td>${authority.roleList.roleName}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="personaldetails_fname" /></td>
				<td>${authority.personal.fname}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="personaldetails_lname" /></td>
				<td>${authority.personal.lname}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="personaldetails_email" /></td>
				<td>${authority.personal.email}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="personaldetails_phone" /></td>
				<td>${authority.personal.phone}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="personaldetails_gender" /></td>
				<td>${authority.personal.gender}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="personaldetails_fatherName" /></td>
				<td>${authority.personal.fatherName}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="personaldetails_motherName" /></td>
				<td>${authority.personal.motherName}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="personaldetails_dob" /></td>
				<td>${authority.personal.dob}</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message code="personaldetails_doj" /></td>
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



