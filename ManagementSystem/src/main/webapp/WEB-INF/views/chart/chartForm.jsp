<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
var chart_form_inputform_id = 'chart_form_inputForm';

$ .parser.onComplete = function() {
		parent. $ .messager.progress('close');
		$('#'+chart_form_inputform_id).form(
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

<form:form id="chart_form_inputForm" name="chart_form_inputForm" action="${ctx}/chart/${action}"
		 modelAttribute="chart" method="post" class="form-horizontal">
	<input type="hidden" name="id" id="id" value="${ chart.id}" />
	<table class="content" style="width: 100%;">
	 		<tr>
			<td class="biao_bt3"><spring:message code="chart_name" /></td>
			<td><input type="text" name="name" id="name" value="${ chart.name }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="chart_name" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="chart_subject" /></td>
			<td><input type="text" name="subject" id="subject" value="${ chart.subject }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="chart_subject" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="chart_role" /></td>
			<td><input type="text" name="role" id="role" value="${ chart.role }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="chart_role" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="chart_email" /></td>
			<td><input type="text" name="email" id="email" value="${ chart.email }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="chart_email" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="chart_image" /></td>
			<td><input type="text" name="image" id="image" value="${ chart.image }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="chart_image" />不能为空.',required:true"   />	</td>
		</tr>
	   	</table>
</form:form>
	