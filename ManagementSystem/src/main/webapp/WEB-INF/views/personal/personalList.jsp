<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="personal_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						    						<th><spring:message code="personal_address" /></th>
						<td><input type="text" name="search_EQ_address"
							value="${ param.search_EQ_address}"
							id="search_EQ_address" /></td>   						<th><spring:message code="personal_ph_number" /></th>
						<td><input type="text" name="search_EQ_ph_number"
							value="${ param.search_EQ_ph_number}"
							id="search_EQ_ph_number" /></td>      						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="personal_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="personal_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="personal_list_dg" style="display: none;"></table>
		</div>
		<div id="personal_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(personal_list_create_url,'personal_form_inputForm',personal_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> 			
		  	  <a href="javascript:deleteBatch(personal_list_delete_url,personal_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var personal_list_datagrid;
	//列表DataGrid ID
	var personal_list_datagrid_id = 'personal_list_dg';
	//列表查询表单ID
	var personal_list_searchform_id = 'personal_list_searchForm';
	//列表toolbar ID
	var personal_list_toolbar_id = 'personal_list_toolbar';
	//操作链接
	var personal_list_create_url =  '${ctx}/personal/create';
	var personal_list_update_url =  '${ctx}/personal/update/';
	var personal_list_delete_url =  '${ctx}/personal/delete';
	var personal_list_view_url =  '${ctx}/personal/view/';
	var personal_list_datagrid_load_url = '${ctx}/personal/findList';
	
	//定义相关的操作按钮
	function personal_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'personal_form_inputForm\',personal_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				personal_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',personal_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,personal_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				personal_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var personal_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	    	          					{field : 'name',title : '<spring:message code="personal_name" />',width : 150,align:'center'},
			          					{field : 'address',title : '<spring:message code="personal_address" />',width : 150,align:'center'},
			          					{field : 'ph_number',title : '<spring:message code="personal_ph_number" />',width : 150,align:'center'},
			          					{field : 'email_id',title : '<spring:message code="personal_email_id" />',width : 150,align:'center'},
			          	                    	{field : 'action',title : '操作',width : 80,align : 'center',formatter : personal_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function personal_list_loadDataGrid(){		 
		personal_list_datagrid = $('#'+personal_list_datagrid_id).datagrid({
			url : personal_list_datagrid_load_url,
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
			columns : personal_list_datagrid_columns,
			toolbar:'#'+personal_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+personal_list_searchform_id+' table').show();
				$('#'+personal_list_datagrid_id).show();
				$('#'+personal_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		personal_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('personal_list_searchBtn','personal_list_clearBtn','personal_list_searchForm',personal_list_datagrid);
	};
</script>


