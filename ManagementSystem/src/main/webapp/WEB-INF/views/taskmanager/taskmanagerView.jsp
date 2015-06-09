<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div id="three">
	<div class="contenttable">
		<h3>
			<spring:message code="taskmanager_title" />
		</h3>
		<div class="contenttable1">
			<table class="content" style="width: 99%;" >
				 				<tr>
					<td class="biao_bt3"><spring:message
							code="taskmanager_taskDate" /></td>
					<td>${ taskmanager.taskDate }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="taskmanager_slotStartTime" /></td>
					<td>${ taskmanager.slotStartTime }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="taskmanager_slotEndTime" /></td>
					<td>${ taskmanager.slotEndTime }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="department_title" /></td>
					<td>${ taskmanager.deptList.deptName }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="batch_title" /></td>
					<td>${ taskmanager.allSemester.semName }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="subject_title" /></td>
					<td>${ taskmanager.subList.subName }</td>
				</tr>
				<tr>
				<td class="biao_bt3"><spring:message
							code="teacher_name" /></td>
				<td>${taskmanager.authorityList.personal.fname} ${taskmanager.authorityList.personal.lname}</td>
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



