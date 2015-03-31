<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div id="three">
	<div class="contenttable">
		<h3>
			<spring:message code="personaldetails_title" />
		</h3>
		<div class="contenttable1">
			<table class="content" style="width: 99%;" >
				 				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_pId" /></td>
					<td>${ personaldetails.pId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_fname" /></td>
					<td>${ personaldetails.fname }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_lname" /></td>
					<td>${ personaldetails.lname }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_address" /></td>
					<td>${ personaldetails.address }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_email" /></td>
					<td>${ personaldetails.email }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_phone" /></td>
					<td>${ personaldetails.phone }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_gender" /></td>
					<td>${ personaldetails.gender }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_fatherName" /></td>
					<td>${ personaldetails.fatherName }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_motherName" /></td>
					<td>${ personaldetails.motherName }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_dob" /></td>
					<td>${ personaldetails.dob }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="personaldetails_doj" /></td>
					<td>${ personaldetails.doj }</td>
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



