<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
var taskmanager_form_inputform_id = 'taskmanager_form_inputForm';

$ .parser.onComplete = function() {
		parent. $ .messager.progress('close');
		$('#'+taskmanager_form_inputform_id).form(
				{
					onSubmit : function() {
						parent. $ .messager.progress({
							title : '提示',
							text : '数据处理中，请稍后....'
						});
						var isValid = $(this).form('validate');
						if (!isValid) {
							parent. $ .messager.progress('close');
						}
						return isValid;
					},
					success : function(result) {
						parent. $ .messager.progress('close');
						result = $ .parseJSON(result);
						if (result.success) {
							parent. $ .modalDialog.openner_dataGrid
									.datagrid('reload');
							parent. $ .modalDialog.openner_dataGrid.datagrid(
									'uncheckAll').datagrid('unselectAll')
									.datagrid('clearSelections');
							parent. $ .modalDialog.handler.dialog('close');
							$ .messager.show({ // show error message
								title : '提示',
								msg : result.message
							});
						} else {
							$ .messager.alert('错误', result.message, 'error');
						}
					}
				});

	} ;
</script>

<form:form id="taskmanager_form_inputForm"
	name="taskmanager_form_inputForm" action="${ctx}/taskmanager/${action}"
	modelAttribute="taskmanager" method="post" class="form-horizontal">
	<input type="hidden" name="id" id="id" value="${ taskmanager.id}" />
	<table class="content" style="width: 100%;">
		<tr>
			<td class="biao_bt3"><spring:message code="taskmanager_taskDate" /></td>
			<td><input type="date" name="taskDate" id="taskDate"
				value="${ taskmanager.taskDate }" class="easyui-validatebox"
				data-options="missingMessage:'<spring:message code="taskmanager_taskDate" />不能为空.',required:true" />
			</td>
		</tr>
		<tr>
			<td class="biao_bt3"><spring:message
					code="taskmanager_slotStartTime" /></td>
			<td><input type="time" name="slotStartTime" id="slotStartTime"
				value="${ taskmanager.slotStartTime }" class="easyui-validatebox"
				data-options="missingMessage:'<spring:message code="taskmanager_slotStartTime" />不能为空.',required:true" />
			</td>
		</tr>
		<tr>
			<td class="biao_bt3"><spring:message
					code="taskmanager_slotEndTime" /></td>
			<td><input type="time" name="slotEndTime" id="slotEndTime"
				value="${ taskmanager.slotEndTime }" class="easyui-validatebox"
				data-options="missingMessage:'<spring:message code="taskmanager_slotEndTime" />不能为空.',required:true" />
			</td>
		</tr>

		<tr>
			<td class="biao_bt3">Department</td>
			<td><select name="deptName">
					<c:forEach items="${depts}" var="dept">
						<option value="${dept.id}"
							<c:if test="${taskmanager.deptList.id == dept.id}">selected="selected"</c:if>>${dept.deptName}</option>
					</c:forEach>
			</select></td>
		</tr>

		<tr>
			<td class="biao_bt3">Semester</td>
			<td><select name="semName">
					<c:forEach items="${sems}" var="sem">
						<option value="${sem.id}"
							<c:if test="${taskmanager.allSemester.id == sem.id}">selected="selected"</c:if>>${sem.semName}</option>
					</c:forEach>
			</select></td>
		</tr>

		<tr>
			<td class="biao_bt3">Subject</td>
			<td><select name="subName">
					<c:forEach items="${subs}" var="sub">
						<option value="${sub.id}"
							<c:if test="${taskmanager.subList.id == sub.id}">selected="selected"</c:if>>${sub.subName}</option>
					</c:forEach>
			</select></td>
		</tr>

		<tr>
			<td class="biao_bt3">Assign To</td>
			<td><select name="authname">
					<c:forEach items="${personalIdList}" var="auth">
						<option value="${auth.id}"
							<c:if test="${taskmanager.authorityList.personal.id == auth.id}">selected="selected"</c:if>>${auth.fname}
							${auth.lname }</option>
					</c:forEach>
			</select></td>
		</tr>


	</table>
</form:form>
