<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
var subject_form_inputform_id = 'subject_form_inputForm';

$ .parser.onComplete = function() {
		parent. $ .messager.progress('close');
		$('#'+subject_form_inputform_id).form(
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

<form:form id="subject_form_inputForm" name="subject_form_inputForm" action="${ctx}/subject/${action}"
		 modelAttribute="subject" method="post" class="form-horizontal">
	<input type="hidden" name="id" id="id" value="${ subject.id}" />
	<table class="content" style="width: 100%;">
	 		<tr>
			<td class="biao_bt3"><spring:message code="subject_subId" /></td>
			<td><input type="text" name="subId" id="subId" value="${ subject.subId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="subject_subId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="subject_subName" /></td>
			<td><input type="text" name="subName" id="subName" value="${ subject.subName }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="subject_subName" />不能为空.',required:true"   />	</td>
		</tr>
		
		
	<tr>
	<td class="biao_bt3"><spring:message
							code="department_title" /></td>
	<td>
	<select name="deptName">
	<c:forEach items="${depts}" var="dept">
	<option value="${dept.id}"
	<c:if test="${subject.deptList.id == dept.id}">selected="selected"</c:if>>${dept.deptName}</option>
	</c:forEach>
	</select>
	</td>
	</tr>
	
	
	
	<tr>
	<td class="biao_bt3"><spring:message
							code="batch_title" /></td>
	<td>
	<select name="semName">
	<c:forEach items="${sem}" var="sem">
	<option value="${sem.id}"
	<c:if test="${subject.batchList.id == sem.id}">selected="selected"</c:if>>${sem.semName}</option>
	</c:forEach>
	</select>
	</td>
	</tr>
		
		
	   	</table>
</form:form>
	