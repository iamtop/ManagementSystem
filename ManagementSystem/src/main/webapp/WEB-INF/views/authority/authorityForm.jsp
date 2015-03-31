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
			<td class="biao_bt3"><spring:message code="authority_deptId" /></td>
			<td><input type="text" name="deptId" id="deptId" value="${ authority.deptId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_deptId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_subId" /></td>
			<td><input type="text" name="subId" id="subId" value="${ authority.subId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_subId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_roleCode" /></td>
			<td><input type="text" name="roleCode" id="roleCode" value="${ authority.roleCode }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_roleCode" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="authority_pId" /></td>
			<td><input type="text" name="pId" id="pId" value="${ authority.pId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="authority_pId" />不能为空.',required:true"   />	</td>
		</tr>
	   	</table>
</form:form>
	