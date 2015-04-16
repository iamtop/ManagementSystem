<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div id="three">
	<div class="contenttable">
		<h3>
			<spring:message code="student_title" />
		</h3>
		<div class="contenttable1">
			<table class="content" style="width: 99%;" >
				 				<tr>
					<td class="biao_bt3"><spring:message
							code="student_studId" /></td>
					<td>${ student.studId }</td>
				</tr>
				<tr>
					<tr>
				<td class="biao_bt3">Personal Id</td>
				<td>${student.personal.pId}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Department</td>
				<td>${student.deptList.deptName}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Semester</td>
				<td>${student.batchList.semName}</td>
				</tr>
				<tr>
				<td class="biao_bt3">First name</td>
				<td>${student.personal.fname}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Last Name</td>
				<td>${student.personal.lname}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Address</td>
				<td>${student.personal.email}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Phone</td>
				<td>${student.personal.phone}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Gender</td>
				<td>${student.personal.gender}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Father Name</td>
				<td>${student.personal.fatherName}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Mother Name</td>
				<td>${student.personal.motherName}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Date of Birth</td>
				<td>${student.personal.dob}</td>
				</tr>
				<tr>
				<td class="biao_bt3">Date of Join</td>
				<td>${student.personal.doj}</td>
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



