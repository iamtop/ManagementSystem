<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
var roleasign_form_inputform_id = 'roleasign_form_inputForm';

$ .parser.onComplete = function() {
		parent. $ .messager.progress('close');
		$('#'+roleasign_form_inputform_id).form(
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

<form:form id="roleasign_form_inputForm" name="roleasign_form_inputForm" action="${ctx}/roleasign/${action}"
		 modelAttribute="roleasign" method="post" class="form-horizontal">
	<input type="hidden" name="id" id="id" value="${ roleasign.id}" />
	<table class="content" style="width: 100%;">
	 		<tr>
			<td class="biao_bt3"><spring:message code="roleasign_deptId" /></td>
			<td><input type="text" name="deptId" id="deptId" value="${ roleasign.deptId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="roleasign_deptId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="roleasign_branchId" /></td>
			<td><input type="text" name="branchId" id="branchId" value="${ roleasign.branchId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="roleasign_branchId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="roleasign_asignRole" /></td>
			<td><input type="text" name="asignRole" id="asignRole" value="${ roleasign.asignRole }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="roleasign_asignRole" />不能为空.',required:true"   />	</td>
		</tr>
	   	</table>
</form:form>
	