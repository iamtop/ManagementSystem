<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
var department_form_inputform_id = 'department_form_inputForm';

$ .parser.onComplete = function() {
		parent. $ .messager.progress('close');
		$('#'+department_form_inputform_id).form(
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

<form:form id="department_form_inputForm" name="department_form_inputForm" action="${ctx}/department/${action}"
		 modelAttribute="department" method="post" class="form-horizontal">
	<input type="hidden" name="id" id="id" value="${ department.id}" />
	<table class="content" style="width: 100%;">
	 		<tr>
			<td class="biao_bt3"><spring:message code="department_deptCode" /></td>
			<td><input type="text" name="deptCode" id="deptCode" value="${ department.deptCode }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="department_deptCode" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="department_deptName" /></td>
			<td><input type="text" name="deptName" id="deptName" value="${ department.deptName }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="department_deptName" />不能为空.',required:true"   />	</td>
		</tr>
	   	</table>
</form:form>
	