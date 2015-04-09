<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="authority_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						   						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="authority_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="authority_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="authority_list_dg" style="display: none;"></table>
		</div>
		<div id="authority_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(authority_list_create_url,'authority_form_inputForm',authority_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> 			
		  	  <a href="javascript:deleteBatch(authority_list_delete_url,authority_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var authority_list_datagrid;
	//列表DataGrid ID
	var authority_list_datagrid_id = 'authority_list_dg';
	//列表查询表单ID
	var authority_list_searchform_id = 'authority_list_searchForm';
	//列表toolbar ID
	var authority_list_toolbar_id = 'authority_list_toolbar';
	//操作链接
	var authority_list_create_url =  '${ctx}/authority/create';
	var authority_list_update_url =  '${ctx}/authority/update/';
	var authority_list_delete_url =  '${ctx}/authority/delete';
	var authority_list_view_url =  '${ctx}/authority/view/';
	var authority_list_datagrid_load_url = '${ctx}/authority/findList';
	
	//定义相关的操作按钮
	function authority_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'authority_form_inputForm\',authority_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				authority_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',authority_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,authority_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				authority_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var authority_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	                    		{field : 'personal.p_id', title : 'Personal Id', width : 150, align:'center',
	                    			formatter : function(value, row, index){
	                    				if(row.personal)
	                    					return row.personal.p_id;
	                    			}},
	                    			
	                    			{field : 'deptList.dept_id', title : 'Department', width : 150, align:'center',
		                    			formatter : function(value, row, index){
		                    				if(row.deptList)
		                    					return row.deptList.dept_code;
		                    			}},
		                    			
		                    			{field : 'roleList.role_code', title : 'Role', width : 150, align:'center',
			                    			formatter : function(value, row, index){
			                    				if(row.personal)
			                    					return row.roleList.role_code;
			                    			}},
	    	          	        {field : 'action',title : '操作',width : 80,align : 'center',formatter : authority_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function authority_list_loadDataGrid(){		 
		authority_list_datagrid = $('#'+authority_list_datagrid_id).datagrid({
			url : authority_list_datagrid_load_url,
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
			columns : authority_list_datagrid_columns,
			toolbar:'#'+authority_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+authority_list_searchform_id+' table').show();
				$('#'+authority_list_datagrid_id).show();
				$('#'+authority_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		authority_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('authority_list_searchBtn','authority_list_clearBtn','authority_list_searchForm',authority_list_datagrid);
	};
</script>


