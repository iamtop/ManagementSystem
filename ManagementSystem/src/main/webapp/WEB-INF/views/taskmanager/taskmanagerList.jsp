<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="taskmanager_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						    						<th><spring:message code="taskmanager_slotStartTime" /></th>
						<td><input type="text" name="search_EQ_slotStartTime"
							value="${ param.search_EQ_slotStartTime}"
							id="search_EQ_slotStartTime" /></td>   						<th><spring:message code="taskmanager_slotEndTime" /></th>
						<td><input type="text" name="search_EQ_slotEndTime"
							value="${ param.search_EQ_slotEndTime}"
							id="search_EQ_slotEndTime" /></td>    						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="taskmanager_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="taskmanager_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="taskmanager_list_dg" style="display: none;"></table>
		</div>
		<div id="taskmanager_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(taskmanager_list_create_url,'taskmanager_form_inputForm',taskmanager_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">Asign task</a> 			
		  	  <a href="javascript:deleteBatch(taskmanager_list_delete_url,taskmanager_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">remove multiple tasks</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var taskmanager_list_datagrid;
	//列表DataGrid ID
	var taskmanager_list_datagrid_id = 'taskmanager_list_dg';
	//列表查询表单ID
	var taskmanager_list_searchform_id = 'taskmanager_list_searchForm';
	//列表toolbar ID
	var taskmanager_list_toolbar_id = 'taskmanager_list_toolbar';
	//操作链接
	var taskmanager_list_create_url =  '${ctx}/taskmanager/create';
	var taskmanager_list_update_url =  '${ctx}/taskmanager/update/';
	var taskmanager_list_delete_url =  '${ctx}/taskmanager/delete';
	var taskmanager_list_view_url =  '${ctx}/taskmanager/view/';
	var taskmanager_list_datagrid_load_url = '${ctx}/taskmanager/findList';
	
	//定义相关的操作按钮
	function taskmanager_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'taskmanager_form_inputForm\',taskmanager_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="edit"/>',
				taskmanager_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',taskmanager_list_datagrid);" src="{2}" title="delete"/>',
		                    row.id,taskmanager_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="display"/>',
				taskmanager_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var taskmanager_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 50,checkbox : true,align:'center'},
	    	          					{field : 'taskDate',title : '<spring:message code="taskmanager_taskDate" />',width : 50,align:'center'},
			          					{field : 'slotStartTime',title : '<spring:message code="taskmanager_slotStartTime" />',width : 50,align:'center'},
			          					{field : 'slotEndTime',title : '<spring:message code="taskmanager_slotEndTime" />',width : 50,align:'center'},
			          					
			          					{field : 'deptList.deptId',title : '<spring:message code="department_title" />',width : 100,align:'center',
			          						formatter : function(value, row, index){
			                    				if(row.deptList)
			                    					return row.deptList.deptName;}},
			                    					
			          					{field : 'allSemester.semId',title : '<spring:message code="batch_title" />',width : 50,align:'center',
			          						formatter : function(value, row, index){
			                    				if(row.allSemester)
			                    					return row.allSemester.semName;}},
			                    					
			          					{field : 'subList.subId',title : '<spring:message code="subject_title" />',width : 100,align:'center',
			          						formatter : function(value, row, index){
			                    				if(row.subList)
			                    					return row.subList.subName;}},
			                    					
			                    		{field : 'authorityList.personal.id',title :'Teacher' ,width : 100,align:'center',
						          			 formatter : function(value, row, index){
						                    	if(row.authorityList.personal)
						                    		return row.authorityList.personal.fname+"  "+row.authorityList.personal.lname;}},
			                    					
			          					
			          	                    	{field : 'action',title : 'Operation',width : 80,align : 'center',formatter : taskmanager_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function taskmanager_list_loadDataGrid(){		 
		taskmanager_list_datagrid = $('#'+taskmanager_list_datagrid_id).datagrid({
			url : taskmanager_list_datagrid_load_url,
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
			columns : taskmanager_list_datagrid_columns,
			toolbar:'#'+taskmanager_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+taskmanager_list_searchform_id+' table').show();
				$('#'+taskmanager_list_datagrid_id).show();
				$('#'+taskmanager_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		taskmanager_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('taskmanager_list_searchBtn','taskmanager_list_clearBtn','taskmanager_list_searchForm',taskmanager_list_datagrid);
	};
</script>


