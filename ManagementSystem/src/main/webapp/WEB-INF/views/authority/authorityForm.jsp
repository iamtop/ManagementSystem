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
	<td class="biao_bt3">Role</td>
	<td>
	<select name=roleName">
	<c:forEach items="${roles}" var="role">
	<option value="${role.id}"
	<c:if test="${authority.roleList.id == role.id}">selected="selected"</c:if>>${role.roleName}</option>
	</c:forEach>
	</select>
	</td>
	</tr>
	
	<tr>
	<td class="biao_bt3">Department</td>
	<td>
	<select name=deptName">
	<c:forEach items="${depts}" var="dept">
	<option value="${dept.id}"
	<c:if test="${authority.deptList.id == dept.id}">selected="selected"</c:if>>${dept.deptName}</option>
	</c:forEach>
	</select>
	</td>
	</tr>
	
	<tr>
	<td class="biao_bt3">Personal Id</td>
	<td><input type="text" name="pId" id="pId" value="${ personal.pId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	
	<tr>
	<td class="biao_bt3">First Name</td>
	<td><input type="text" name="fname" id="fname" value="${ personal.fname }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Last Name</td>
	<td><input type="text" name="lname" id="lname" value="${ personal.lname }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Address</td>
	<td><input type="text" name="address" id="address" value="${ personal.address }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Email</td>
	<td><input type="text" name="email" id="email" value="${ personal.email }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Phone</td>
	<td><input type="text" name="phone" id="phone" value="${ personal.phone }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Gender</td>
	<td valign="middle">
	<input type="radio" name="gender" id="gender" value="Male" ${authority.personal.gender == 'Male'?'checked':''}/>Male
	<input type="radio" name="gender" id="gender" value="Female" ${authority.personal.gender == 'Female'?'checked':''}/>Female
	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Father Name</td>
	<td><input type="text" name="fathername" id="fathername" value="${ personal.fatherName }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Mother Name</td>
	<td><input type="text" name="mothername" id="mothername" value="${ personal.motherName }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Date of Birth</td>
	<td><input type="text" name="dob" id="dob" value="${ personal.dob }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Date of Join</td>
	<td><input type="text" name="doj" id="doj" value="${ personal.doj }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	</table>
</form:form>
	