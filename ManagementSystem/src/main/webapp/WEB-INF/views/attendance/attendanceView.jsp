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
							code="attendance_timeSlotStart" /></td>
					<td>${ attendance.timeSlotStart }</td>
				</tr>
				  				<tr>
					<td class="biao_bt3"><spring:message
							code="attendance_timeSlotEnd" /></td>
					<td>${ attendance.timeSlotEnd }</td>
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
				   			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
$ .parser.onComplete = function() {
	parent.$ .messager.progress('close');
};
</script>



