<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="attendance_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
					
						<th><spring:message code="attendance_department" /></th>
						<td>
						<select name="search_EQ_taskList.deptList" value="${ param.search_EQ_taskList.deptList}"
							id="deptId">
							<option value="">Select</option>
	                          <c:forEach items="${deptLs}" var="dp">
	                          <option value="${dp.deptName}">${dp.deptName}</option>
	                          </c:forEach>
	                          </select></td>
	                          
	                        <th><spring:message code="attendance_semester" /></th>
							<td>
							<select name="search_EQ_taskList.allSemester" value="${ param.search_EQ_taskList.allSemester}"
							id="batchId">
							<option value="">Select</option>
	                          <c:forEach items="${batchList}" var="bl">
	                          <option value="${bl.semName}">${bl.semName}</option>
	                          </c:forEach>
	                          </select></td>

					
							<th><spring:message code="attendance_timeSlotStart" /></th>
						<td>
						<select name="search_EQ_taskList.timeSlotStart" value="${ param.search_EQ_taskList.timeSlotStart}"
							id="timeSlotStart">
							<option value="">Select</option>
	                          <c:forEach items="${tasks}" var="task">
	                          <option value="${task.slotStartTime}">${task.slotStartTime}</option>
	                          </c:forEach>
	                          </select></td>
	
	<th><spring:message code="attendance_attendanceDate" /></th>
						<td><input type="text" name="search_EQ_attendanceDate"
						id="text1" readonly>
							
							<script type="text/javascript">  
							 var today=new Date();
                             var date=today.toISOString().slice(0, -14);
							 document.getElementById('text1').value= date;
                             </script>  
							 </td> 
							
							<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="attendance_list_searchBtn"  onclick="attendance_list_loadDataGrid()">查询</a>&nbsp;<a
							href="javascript:void(0);" id="attendance_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="attendance_list_dg" style="display: none;"></table>
		</div>
		<div id="attendance_list_toolbar" style="display: none;">
				<!-- <a href="javascript:updateForm(attendance_list_create_url,'attendance_form_inputForm',attendance_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> --> 			
				<a href="javascript:submitData(attendance_list_submit_url,attendance_list_datagrid);" class="easyui-linkbutton">Submit</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
//alert(JSON.stringify('${tasks}'));
	//列表DataGrid
	var attendance_list_datagrid;
	//列表DataGrid ID
	var attendance_list_datagrid_id = 'attendance_list_dg';
	//列表查询表单ID
	var attendance_list_searchform_id = 'attendance_list_searchForm';
	//列表toolbar ID
	var attendance_list_toolbar_id = 'attendance_list_toolbar';
	//操作链接
	var attendance_list_create_url =  '${ctx}/attendance/create';
	var attendance_list_update_url =  '${ctx}/attendance/update/';
	var attendance_list_delete_url =  '${ctx}/attendance/delete'; 
	var attendance_list_submit_url =  '${ctx}/attendance/submit'; 
	
	var attendance_list_view_url =  '${ctx}/attendance/view/';
	var attendance_list_datagrid_load_url = '${ctx}/attendance/findList';
	
	//定义相关的操作按钮
	function attendance_list_actionFormatter(value,row,index){
		
	}
	
	//DataGrid字段设置
	var attendance_list_datagrid_columns = [ [
	                    		
	    	          					{field : 'slot_start_time',title : '<spring:message code="attendance_timeSlotStart" />',width : 150,align:'center'},			          					
			          					{field : 'Department',title : '<spring:message code="attendance_department" />',width : 150,align:'center'},
			          					{field : 'StudentName',title : '<spring:message code="attendance_student" />',width : 150,align:'center'},
			          					{field : 'Semester',title : '<spring:message code="attendance_semester" />',width : 150,align:'center'},
			          					{field : 'SubjectName',title : '<spring:message code="attendance_subject" />',width : 150,align:'center'},
						                {field : 'task_date',title : '<spring:message code="attendance_attendanceDate" />',width : 150,align:'center'},
						      			{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
							          	
							          	
							          	
							          	
							          	
							          	
			          	                 /*  {field : 'action',title : '操作',width : 80,align : 'center',formatter : attendance_list_actionFormatter}  */
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function attendance_list_loadDataGrid(){			
		var timeSlotStart = $('#timeSlotStart').val();
		var deptt = $('#deptId').val();
		var batchh = $('#batchId').val();
		attendance_list_datagrid = $('#'+attendance_list_datagrid_id).datagrid({
			url : attendance_list_datagrid_load_url+"?deptId="+deptt+"&timeSlotStart="+timeSlotStart + "&batchId="+batchh,
			fit : true,
			border : false,
			fitColumns : true,
			singleSelect : false,
			striped : true,
			pagination : true,
			rownumbers : true,
			//idField : 'id',
			pageSize : 15,
			pageList : [ 5, 10,15, 20, 30, 40, 50 ],
			columns : attendance_list_datagrid_columns,
			toolbar:'#'+attendance_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+attendance_list_searchform_id+' table').show();
				$('#'+attendance_list_datagrid_id).show();
				$('#'+attendance_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		attendance_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('attendance_list_searchBtn','attendance_list_clearBtn','attendance_list_searchForm',attendance_list_datagrid);
	};
	
	
</script>


