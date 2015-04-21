<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
var attendance_form_inputform_id = 'attendance_form_inputForm';

$ .parser.onComplete = function() {
		parent. $ .messager.progress('close');
		$('#'+attendance_form_inputform_id).form(
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

<form:form id="attendance_form_inputForm" name="attendance_form_inputForm" action="${ctx}/attendance/${action}"
		 modelAttribute="attendance" method="post" class="form-horizontal">
	<input type="hidden" name="id" id="id" value="${ attendance.id}" />
	<table class="content" style="width: 100%;">
	 		<tr>
			<td class="biao_bt3"><spring:message code="attendance_timeSlotStart" /></td>
			<td><input type="text" name="timeSlotStart" id="timeSlotStart" value="${ attendance.timeSlotStart }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="attendance_timeSlotStart" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="attendance_timeSlotEnd" /></td>
			<td><input type="text" name="timeSlotEnd" id="timeSlotEnd" value="${ attendance.timeSlotEnd }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="attendance_timeSlotEnd" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="attendance_attendanceDate" /></td>
			<td><input type="text" name="attendanceDate" id="attendanceDate" value="${ attendance.attendanceDate }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="attendance_attendanceDate" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="attendance_attendance" /></td>
			<td><input type="text" name="attendance" id="attendance" value="${ attendance.attendance }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="attendance_attendance" />不能为空.',required:true"   />	</td>
		</tr>
	   	</table>
</form:form>
	