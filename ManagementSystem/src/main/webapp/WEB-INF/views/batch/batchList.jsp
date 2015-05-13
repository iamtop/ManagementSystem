<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="batch_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						    						<th><spring:message code="batch_semName" /></th>
						<td><input type="text" name="search_EQ_semName"
							value="${ param.search_EQ_semName}"
							id="search_EQ_semName" /></td>   										<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="batch_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="batch_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="batch_list_dg" style="display: none;"></table>
		</div>
		<div id="batch_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(batch_list_create_url,'batch_form_inputForm',batch_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> 			
		  	  <a href="javascript:deleteBatch(batch_list_delete_url,batch_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
		  	  <a href="javascript:exportBatch();" class="easyui-linkbutton"  data-options="iconCls:'icon-page_excel',plain:true">删除</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var batch_list_datagrid;
	//列表DataGrid ID
	var batch_list_datagrid_id = 'batch_list_dg';
	//列表查询表单ID
	var batch_list_searchform_id = 'batch_list_searchForm';
	//列表toolbar ID
	var batch_list_toolbar_id = 'batch_list_toolbar';
	//操作链接
	var batch_list_create_url =  '${ctx}/batch/create';
	var batch_list_update_url =  '${ctx}/batch/update/';
	var batch_list_delete_url =  '${ctx}/batch/delete';
	var batch_list_view_url =  '${ctx}/batch/view/';
	var batch_list_datagrid_load_url = '${ctx}/batch/findList';
	
	//定义相关的操作按钮
	function batch_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'batch_form_inputForm\',batch_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				batch_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',batch_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,batch_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				batch_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var batch_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	    	          					{field : 'semId',title : '<spring:message code="batch_semId" />',width : 150,align:'center'},
			          					{field : 'semName',title : '<spring:message code="batch_semName" />',width : 150,align:'center'},
			          	                    	{field : 'action',title : '操作',width : 80,align : 'center',formatter : batch_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function batch_list_loadDataGrid(){		 
		batch_list_datagrid = $('#'+batch_list_datagrid_id).datagrid({
			url : batch_list_datagrid_load_url,
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
			columns : batch_list_datagrid_columns,
			toolbar:'#'+batch_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+batch_list_searchform_id+' table').show();
				$('#'+batch_list_datagrid_id).show();
				$('#'+batch_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		batch_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('batch_list_searchBtn','batch_list_clearBtn','batch_list_searchForm',batch_list_datagrid);
	};
	
	function exportBatch() {
		$('#batch_list_searchForm').attr("action", "${ctx}/batch/export");
		$('#batch_list_searchForm').submit();
	}
</script>


