<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div id="three">
	<div class="contenttable">
		<h3>
			<spring:message code="chart_title" />
		</h3>
		<div class="contenttable1">
			<table class="content" style="width: 99%;" >
				 				<tr>
					<td class="biao_bt3"><spring:message
							code="chart_name" /></td>
					<td>${ chart.name }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="chart_subject" /></td>
					<td>${ chart.subject }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="chart_role" /></td>
					<td>${ chart.role }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="chart_email" /></td>
					<td>${ chart.email }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="chart_image" /></td>
					<td>${ chart.image }</td>
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



