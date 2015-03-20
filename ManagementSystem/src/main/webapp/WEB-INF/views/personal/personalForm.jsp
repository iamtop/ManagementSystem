<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
var personal_form_inputform_id = 'personal_form_inputForm';

$ .parser.onComplete = function() {
		parent. $ .messager.progress('close');
		$('#'+personal_form_inputform_id).form(
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

<form:form id="personal_form_inputForm" name="personal_form_inputForm" action="${ctx}/personal/${action}"
		 modelAttribute="personal" method="post" class="form-horizontal">
	<input type="hidden" name="id" id="id" value="${ personal.id}" />
	<table class="content" style="width: 100%;">
	 		<tr>
			<td class="biao_bt3"><spring:message code="personal_name" /></td>
			<td><input type="text" name="name" id="name" value="${ personal.name }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personal_name" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personal_address" /></td>
			<td><input type="text" name="address" id="address" value="${ personal.address }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personal_address" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personal_ph_number" /></td>
			<td><input type="text" name="ph_number" id="ph_number" value="${ personal.ph_number }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personal_ph_number" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personal_email_id" /></td>
			<td><input type="text" name="email_id" id="email_id" value="${ personal.email_id }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personal_email_id" />不能为空.',required:true"   />	</td>
		</tr>
	   	</table>
</form:form>
	