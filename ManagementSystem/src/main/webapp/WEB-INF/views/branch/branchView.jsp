<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div id="three">
	<div class="contenttable">
		<h3>
			<spring:message code="branch_title" />
		</h3>
		<div class="contenttable1">
			<table class="content" style="width: 99%;" >
				 				<tr>
					<td class="biao_bt3"><spring:message
							code="branch_brId" /></td>
					<td>${ branch.brId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="branch_brName" /></td>
					<td>${ branch.brName }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="branch_deptId" /></td>
					<td>${ branch.deptId }</td>
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



