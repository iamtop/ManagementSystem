﻿<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="roleasignment_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						    						<th><spring:message code="roleasignment_roleName" /></th>
						<td><input type="text" name="search_EQ_roleName"
							value="${ param.search_EQ_roleName}"
							id="search_EQ_roleName" /></td>   						<%-- <th><spring:message code="roleasignment_id" /></th>
						<td><input type="text" name="search_EQ_id"
							value="${ param.search_EQ_id}"
							id="search_EQ_id" /></td>   --%>						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="roleasignment_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="roleasignment_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="roleasignment_list_dg" style="display: none;"></table>
		</div>
		<div id="roleasignment_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(roleasignment_list_create_url,'roleasignment_form_inputForm',roleasignment_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加角色</a> 			
		  	  	<a href="javascript:deleteBatch(roleasignment_list_delete_url,roleasignment_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
				<a href="javascript:exportRoles();" class="easyui-linkbutton"  data-options="iconCls:'icon-page_excel',plain:false">出口数据</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var roleasignment_list_datagrid;
	//列表DataGrid ID
	var roleasignment_list_datagrid_id = 'roleasignment_list_dg';
	//列表查询表单ID
	var roleasignment_list_searchform_id = 'roleasignment_list_searchForm';
	//列表toolbar ID
	var roleasignment_list_toolbar_id = 'roleasignment_list_toolbar';
	//操作链接
	var roleasignment_list_create_url =  '${ctx}/roleasignment/create';
	var roleasignment_list_update_url =  '${ctx}/roleasignment/update/';
	var roleasignment_list_delete_url =  '${ctx}/roleasignment/delete';
	var roleasignment_list_view_url =  '${ctx}/roleasignment/view/';
	var roleasignment_list_datagrid_load_url = '${ctx}/roleasignment/findList';
	
	//定义相关的操作按钮
	function roleasignment_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'roleasignment_form_inputForm\',roleasignment_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				roleasignment_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',roleasignment_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,roleasignment_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				roleasignment_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var roleasignment_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	    	          					{field : 'roleCode',title : '<spring:message code="roleasignment_roleCode" />',width : 150,align:'center'},
			          					{field : 'roleName',title : '<spring:message code="roleasignment_roleName" />',width : 150,align:'center'},
			          	                    	{field : 'action',title : '操作',width : 80,align : 'center',formatter : roleasignment_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function roleasignment_list_loadDataGrid(){		 
		roleasignment_list_datagrid = $('#'+roleasignment_list_datagrid_id).datagrid({
			url : roleasignment_list_datagrid_load_url,
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
			columns : roleasignment_list_datagrid_columns,
			toolbar:'#'+roleasignment_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+roleasignment_list_searchform_id+' table').show();
				$('#'+roleasignment_list_datagrid_id).show();
				$('#'+roleasignment_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		roleasignment_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('roleasignment_list_searchBtn','roleasignment_list_clearBtn','roleasignment_list_searchForm',roleasignment_list_datagrid);
	};
	
	function exportRoles(){
		$('#roleasignment_list_searchForm').attr("action", "${ctx}/roleasignment/export");
		$('#roleasignment_list_searchForm').submit();
	}
</script>


