﻿<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
						    						<th><spring:message code="attendance_studId" /></th>
						<td><input type="text" name="search_EQ_studId"
							value="${ param.search_EQ_studId}"
							id="search_EQ_studId" /></td>   						<th><spring:message code="attendance_deptId" /></th>
						<td><input type="text" name="search_EQ_deptId"
							value="${ param.search_EQ_deptId}"
							id="search_EQ_deptId" /></td>              						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="attendance_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="attendance_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="attendance_list_dg" style="display: none;"></table>
		</div>
		<div id="attendance_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(attendance_list_create_url,'attendance_form_inputForm',attendance_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> 			
		  	  <a href="javascript:deleteBatch(attendance_list_delete_url,attendance_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
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
	var attendance_list_view_url =  '${ctx}/attendance/view/';
	var attendance_list_datagrid_load_url = '${ctx}/attendance/findList';
	
	//定义相关的操作按钮
	function attendance_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'attendance_form_inputForm\',attendance_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				attendance_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',attendance_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,attendance_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				attendance_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var attendance_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	    	          					{field : 'empId',title : '<spring:message code="attendance_empId" />',width : 150,align:'center'},
			          					{field : 'studId',title : '<spring:message code="attendance_studId" />',width : 150,align:'center'},
			          					{field : 'deptId',title : '<spring:message code="attendance_deptId" />',width : 150,align:'center'},
			          					{field : 'subId',title : '<spring:message code="attendance_subId" />',width : 150,align:'center'},
			          					{field : 'timeSlot',title : '<spring:message code="attendance_timeSlot" />',width : 150,align:'center'},
			          					{field : 'attendanceDate',title : '<spring:message code="attendance_attendanceDate" />',width : 150,align:'center'},
			          					{field : 'attendance',title : '<spring:message code="attendance_attendance" />',width : 150,align:'center'},
			          					{field : 'flag',title : '<spring:message code="attendance_flag" />',width : 150,align:'center'},
			          	                    	{field : 'action',title : '操作',width : 80,align : 'center',formatter : attendance_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function attendance_list_loadDataGrid(){		 
		attendance_list_datagrid = $('#'+attendance_list_datagrid_id).datagrid({
			url : attendance_list_datagrid_load_url,
			fit : true,
			border : false,
			fitColumns : true,
			singleSelect : false,
			striped : true,
			pagination : true,
			rownumbers : true,
			idField : 'id',
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

