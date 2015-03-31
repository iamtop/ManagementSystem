<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
var personaldetails_form_inputform_id = 'personaldetails_form_inputForm';

$ .parser.onComplete = function() {
		parent. $ .messager.progress('close');
		$('#'+personaldetails_form_inputform_id).form(
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

<form:form id="personaldetails_form_inputForm" name="personaldetails_form_inputForm" action="${ctx}/personaldetails/${action}"
		 modelAttribute="personaldetails" method="post" class="form-horizontal">
	<input type="hidden" name="id" id="id" value="${ personaldetails.id}" />
	<table class="content" style="width: 100%;">
	 		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_pId" /></td>
			<td><input type="text" name="pId" id="pId" value="${ personaldetails.pId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_pId" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_fname" /></td>
			<td><input type="text" name="fname" id="fname" value="${ personaldetails.fname }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_fname" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_lname" /></td>
			<td><input type="text" name="lname" id="lname" value="${ personaldetails.lname }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_lname" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_address" /></td>
			<td><input type="text" name="address" id="address" value="${ personaldetails.address }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_address" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_email" /></td>
			<td><input type="text" name="email" id="email" value="${ personaldetails.email }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_email" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_phone" /></td>
			<td><input type="text" name="phone" id="phone" value="${ personaldetails.phone }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_phone" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_gender" /></td>
			<td><input type="text" name="gender" id="gender" value="${ personaldetails.gender }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_gender" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_fatherName" /></td>
			<td><input type="text" name="fatherName" id="fatherName" value="${ personaldetails.fatherName }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_fatherName" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_motherName" /></td>
			<td><input type="text" name="motherName" id="motherName" value="${ personaldetails.motherName }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_motherName" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_dob" /></td>
			<td><input type="text" name="dob" id="dob" value="${ personaldetails.dob }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_dob" />不能为空.',required:true"   />	</td>
		</tr>
	  		<tr>
			<td class="biao_bt3"><spring:message code="personaldetails_doj" /></td>
			<td><input type="text" name="doj" id="doj" value="${ personaldetails.doj }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="personaldetails_doj" />不能为空.',required:true"   />	</td>
		</tr>
	   	</table>
</form:form>
	