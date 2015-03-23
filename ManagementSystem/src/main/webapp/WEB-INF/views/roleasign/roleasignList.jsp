<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="roleasign_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						    						<th><spring:message code="roleasign_branchId" /></th>
						<td><input type="text" name="search_EQ_branchId"
							value="${ param.search_EQ_branchId}"
							id="search_EQ_branchId" /></td>   						<th><spring:message code="roleasign_asignRole" /></th>
						<td><input type="text" name="search_EQ_asignRole"
							value="${ param.search_EQ_asignRole}"
							id="search_EQ_asignRole" /></td>    						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="roleasign_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="roleasign_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="roleasign_list_dg" style="display: none;"></table>
		</div>
		<div id="roleasign_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(roleasign_list_create_url,'roleasign_form_inputForm',roleasign_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> 			
		  	  <a href="javascript:deleteBatch(roleasign_list_delete_url,roleasign_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var roleasign_list_datagrid;
	//列表DataGrid ID
	var roleasign_list_datagrid_id = 'roleasign_list_dg';
	//列表查询表单ID
	var roleasign_list_searchform_id = 'roleasign_list_searchForm';
	//列表toolbar ID
	var roleasign_list_toolbar_id = 'roleasign_list_toolbar';
	//操作链接
	var roleasign_list_create_url =  '${ctx}/roleasign/create';
	var roleasign_list_update_url =  '${ctx}/roleasign/update/';
	var roleasign_list_delete_url =  '${ctx}/roleasign/delete';
	var roleasign_list_view_url =  '${ctx}/roleasign/view/';
	var roleasign_list_datagrid_load_url = '${ctx}/roleasign/findList';
	
	//定义相关的操作按钮
	function roleasign_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'roleasign_form_inputForm\',roleasign_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				roleasign_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',roleasign_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,roleasign_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				roleasign_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var roleasign_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	    	          					{field : 'deptId',title : '<spring:message code="roleasign_deptId" />',width : 150,align:'center'},
			          					{field : 'branchId',title : '<spring:message code="roleasign_branchId" />',width : 150,align:'center'},
			          					{field : 'asignRole',title : '<spring:message code="roleasign_asignRole" />',width : 150,align:'center'},
			          	                    	{field : 'action',title : '操作',width : 80,align : 'center',formatter : roleasign_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function roleasign_list_loadDataGrid(){		 
		roleasign_list_datagrid = $('#'+roleasign_list_datagrid_id).datagrid({
			url : roleasign_list_datagrid_load_url,
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
			columns : roleasign_list_datagrid_columns,
			toolbar:'#'+roleasign_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+roleasign_list_searchform_id+' table').show();
				$('#'+roleasign_list_datagrid_id).show();
				$('#'+roleasign_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		roleasign_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('roleasign_list_searchBtn','roleasign_list_clearBtn','roleasign_list_searchForm',roleasign_list_datagrid);
	};
</script>


