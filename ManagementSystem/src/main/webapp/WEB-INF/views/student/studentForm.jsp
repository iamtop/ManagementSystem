﻿<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
var student_form_inputform_id = 'student_form_inputForm';

$ .parser.onComplete = function() {
		parent. $ .messager.progress('close');
		$('#'+student_form_inputform_id).form(
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

<form:form id="student_form_inputForm" name="student_form_inputForm" action="${ctx}/student/${action}"
		 modelAttribute="student" method="post" class="form-horizontal">
	<input type="hidden" name="id" id="id" value="${ student.id}" />
	<table class="content" style="width: 100%;">
	 		<tr>
			<td class="biao_bt3"><spring:message code="student_studId" /></td>
			<td><input type="text" name="studId" id="studId" value="${ student.studId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="student_studId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="student_brId" /></td>
			<td><input type="text" name="brId" id="brId" value="${ student.brId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="student_brId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="student_subId" /></td>
			<td><input type="text" name="subId" id="subId" value="${ student.subId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="student_subId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="student_pId" /></td>
			<td><input type="text" name="pId" id="pId" value="${ student.pId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="student_pId" />不能为空.',required:true"   />	</td>
		</tr>
	   	</table>
</form:form>
	