<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div id="three">
	<div class="contenttable">
		<h3>
			<spring:message code="authority_title" />
		</h3>
		<div class="contenttable1">
			<table class="content" style="width: 99%;" >
				 				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_uuid" /></td>
					<td>${ authority.uuid }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_branchId" /></td>
					<td>${ authority.branchId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_name" /></td>
					<td>${ authority.name }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_address" /></td>
					<td>${ authority.address }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_empId" /></td>
					<td>${ authority.empId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_taskNumber" /></td>
					<td>${ authority.taskNumber }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_taskDate" /></td>
					<td>${ authority.taskDate }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_taskStartTime" /></td>
					<td>${ authority.taskStartTime }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_taskEndTime" /></td>
					<td>${ authority.taskEndTime }</td>
				</tr>
				   			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
$ .parser.onComplete = function() {
	parent.$ .messager.progress('close');
};
</script>



