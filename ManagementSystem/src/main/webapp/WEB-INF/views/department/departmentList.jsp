﻿<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="department_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						    						<th><spring:message code="department_deptName" /></th>
						<td><input type="text" name="search_EQ_deptName"
							value="${ param.search_EQ_deptName}"
							id="search_EQ_deptName" /></td>  						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="department_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="department_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="department_list_dg" style="display: none;"></table>
		</div>
		<div id="department_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(department_list_create_url,'department_form_inputForm',department_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> 			
		  	  <a href="javascript:deleteBatch(department_list_delete_url,department_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
		  	  <a href="javascript:exportDepartment();" class="easyui-linkbutton"  data-options="iconCls:'icon-page_excel',plain:false">出口数据</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var department_list_datagrid;
	//列表DataGrid ID
	var department_list_datagrid_id = 'department_list_dg';
	//列表查询表单ID
	var department_list_searchform_id = 'department_list_searchForm';
	//列表toolbar ID
	var department_list_toolbar_id = 'department_list_toolbar';
	//操作链接
	var department_list_create_url =  '${ctx}/department/create';
	var department_list_update_url =  '${ctx}/department/update/';
	var department_list_delete_url =  '${ctx}/department/delete';
	var department_list_view_url =  '${ctx}/department/view/';
	var department_list_datagrid_load_url = '${ctx}/department/findList';

	
	//定义相关的操作按钮
	function department_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'department_form_inputForm\',department_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				department_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',department_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,department_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				department_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var department_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	    	          					{field : 'deptCode',title : '<spring:message code="department_deptCode" />',width : 150,align:'center'},
			          					{field : 'deptName',title : '<spring:message code="department_deptName" />',width : 150,align:'center'},
			          	                    	{field : 'action',title : '操作',width : 80,align : 'center',formatter : department_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function department_list_loadDataGrid(){		 
		department_list_datagrid = $('#'+department_list_datagrid_id).datagrid({
			url : department_list_datagrid_load_url,
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
			columns : department_list_datagrid_columns,
			toolbar:'#'+department_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+department_list_searchform_id+' table').show();
				$('#'+department_list_datagrid_id).show();
				$('#'+department_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		department_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('department_list_searchBtn','department_list_clearBtn','department_list_searchForm',department_list_datagrid);
	};
	
	function exportDepartment() {
		$('#department_list_searchForm').attr("action", "${ctx}/department/export");
		$('#department_list_searchForm').submit();
	}
</script>


