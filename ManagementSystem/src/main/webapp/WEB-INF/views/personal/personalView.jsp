<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div id="three">
	<div class="contenttable">
		<h3>
			<spring:message code="personal_title" />
		</h3>
		<div class="contenttable1">
			<table class="content" style="width: 99%;" >
				 				<tr>
					<td class="biao_bt3"><spring:message
							code="personal_name" /></td>
					<td>${ personal.name }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personal_address" /></td>
					<td>${ personal.address }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personal_ph_number" /></td>
					<td>${ personal.ph_number }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personal_email_id" /></td>
					<td>${ personal.email_id }</td>
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



