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
							code="authority_deptId" /></td>
					<td>${ authority.deptId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_subId" /></td>
					<td>${ authority.subId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_roleCode" /></td>
					<td>${ authority.roleCode }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="authority_pId" /></td>
					<td>${ authority.pId }</td>
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



