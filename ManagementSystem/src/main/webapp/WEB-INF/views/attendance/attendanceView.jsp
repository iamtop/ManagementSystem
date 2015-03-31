<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div id="three">
	<div class="contenttable">
		<h3>
			<spring:message code="attendance_title" />
		</h3>
		<div class="contenttable1">
			<table class="content" style="width: 99%;" >
				 				<tr>
					<td class="biao_bt3"><spring:message
							code="attendance_pId" /></td>
					<td>${ attendance.pId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="attendance_studId" /></td>
					<td>${ attendance.studId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="attendance_deptId" /></td>
					<td>${ attendance.deptId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="attendance_subId" /></td>
					<td>${ attendance.subId }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="attendance_timeSlot" /></td>
					<td>${ attendance.timeSlot }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="attendance_attendanceDate" /></td>
					<td>${ attendance.attendanceDate }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="attendance_attendance" /></td>
					<td>${ attendance.attendance }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="attendance_flag" /></td>
					<td>${ attendance.flag }</td>
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



