<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div id="three">
	<div class="contenttable">
		<h3>
			<spring:message code="roleasign_title" />
		</h3>
		<div class="contenttable1">
			<table class="content" style="width: 99%;" >
				 				<tr>
					<td class="biao_bt3"><spring:message
							code="roleasign_deptId" /></td>
					<td>${ roleasign.deptId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="roleasign_branchId" /></td>
					<td>${ roleasign.branchId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="roleasign_asignRole" /></td>
					<td>${ roleasign.asignRole }</td>
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



