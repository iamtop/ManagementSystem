<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
	<td class="biao_bt3">Department</td>
	<td>
	<select name="deptName">
	<c:forEach items="${depts}" var="dept">
	<option value="${dept.id}"
	<c:if test="${student.deptList.id == dept.id}">selected="selected"</c:if>>${dept.deptName}</option>
	</c:forEach>
	</select>
	</td>
	</tr>
	
	<tr>
	<td class="biao_bt3">Semester</td>
	<td>
	<select name="semName">
	<c:forEach items="${sems}" var="sems">
	<option value="${sems.id}"
	<c:if test="${student.batchList.id == sems.id}">selected="selected"</c:if>>${sems.semName}</option>
	</c:forEach>
	</select>
	</td>
	</tr>
	
	<tr>
	<td class="biao_bt3">Personal Id</td>
	<td><input type="text" name="pId" id="pId" value="${ student.personal.pId }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	
	<tr>
	<td class="biao_bt3">First Name</td>
	<td><input type="text" name="fname" id="fname" value="${ student.personal.fname }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Last Name</td>
	<td><input type="text" name="lname" id="lname" value="${ student.personal.lname }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Address</td>
	<td><input type="text" name="address" id="address" value="${ student.personal.address }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Email</td>
	<td><input type="text" name="email" id="email" value="${ student.personal.email }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Phone</td>
	<td><input type="text" name="phone" id="phone" value="${ student.personal.phone }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Gender</td>
	<td valign="middle">
	<input type="radio" name="gender" id="gender" value="Male" ${student.personal.gender == 'Male'?'checked':''}/>Male
	<input type="radio" name="gender" id="gender" value="Female" ${student.personal.gender == 'Female'?'checked':''}/>Female
	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Father Name</td>
	<td><input type="text" name="fathername" id="fathername" value="${ student.personal.fatherName }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Mother Name</td>
	<td><input type="text" name="mothername" id="mothername" value="${ student.personal.motherName }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Date of Birth</td>
	<td><input type="date" name="dob" id="dob" value="${ student.personal.dob }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	<tr>
	<td class="biao_bt3">Date of Join</td>
	<td><input type="date" name="doj" id="doj" value="${ student.personal.doj }" class="easyui-validatebox" data-options="missingMessage:'<spring:message code="batch_semId" />不能为空.',required:true"   />	</td>
	</tr>
	
	   	</table>
</form:form>
	