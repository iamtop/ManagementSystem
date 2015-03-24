<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
var authority_form_inputform_id = 'authority_form_inputForm';

$ .parser.onComplete = function() {
		parent. $ .messager.progress('close');
		$('#'+authority_form_inputform_id).form(
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

<form:form id="authority_form_inputForm" name="authority_form_inputForm" action="${ctx}/authority/${action}"
		 modelAttribute="authority" method="post" class="form-horizontal">
	<input type="hidden" name="id" id="id" value="${ authority.id}" />
	<table class="content" style="width: 100%;">
	 		<tr>
			<td class="biao_bt3"><spring:message code="authority_uuid" /></td>
			<td><input type="text" name="uuid" id="uuid" value="${ authority.uuid }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_uuid" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_branchId" /></td>
			<td><input type="text" name="branchId" id="branchId" value="${ authority.branchId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_branchId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_name" /></td>
			<td><input type="text" name="name" id="name" value="${ authority.name }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_name" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_address" /></td>
			<td><input type="text" name="address" id="address" value="${ authority.address }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_address" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_empId" /></td>
			<td><input type="text" name="empId" id="empId" value="${ authority.empId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_empId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_taskNumber" /></td>
			<td><input type="text" name="taskNumber" id="taskNumber" value="${ authority.taskNumber }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_taskNumber" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_taskDate" /></td>
			<td><input type="text" name="taskDate" id="taskDate" value="${ authority.taskDate }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_taskDate" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_taskStartTime" /></td>
			<td><input type="text" name="taskStartTime" id="taskStartTime" value="${ authority.taskStartTime }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_taskStartTime" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_taskEndTime" /></td>
			<td><input type="text" name="taskEndTime" id="taskEndTime" value="${ authority.taskEndTime }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_taskEndTime" />不能为空.',required:true"   />	</td>
		</tr>
	   	</table>
</form:form>
	