<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="subject_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						    						<th><spring:message code="subject_subName" /></th>
						<td><input type="text" name="search_EQ_subName"
							value="${ param.search_EQ_subName}"
							id="search_EQ_subName" /></td>   						<th><spring:message code="subject_id" /></th>
						<td><input type="text" name="search_EQ_id"
							value="${ param.search_EQ_id}"
							id="search_EQ_id" /></td>  						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="subject_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="subject_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="subject_list_dg" style="display: none;"></table>
		</div>
		<div id="subject_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(subject_list_create_url,'subject_form_inputForm',subject_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> 			
		  	  <a href="javascript:deleteBatch(subject_list_delete_url,subject_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
		  	  <a href="javascript:exportSubject();" class="easyui-linkbutton"  data-options="iconCls:'icon-page_excel',plain:false">Export Data</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var subject_list_datagrid;
	//列表DataGrid ID
	var subject_list_datagrid_id = 'subject_list_dg';
	//列表查询表单ID
	var subject_list_searchform_id = 'subject_list_searchForm';
	//列表toolbar ID
	var subject_list_toolbar_id = 'subject_list_toolbar';
	//操作链接
	var subject_list_create_url =  '${ctx}/subject/create';
	var subject_list_update_url =  '${ctx}/subject/update/';
	var subject_list_delete_url =  '${ctx}/subject/delete';
	var subject_list_view_url =  '${ctx}/subject/view/';
	var subject_list_datagrid_load_url = '${ctx}/subject/findList';
	
	//定义相关的操作按钮
	function subject_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'subject_form_inputForm\',subject_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				subject_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',subject_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,subject_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				subject_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var subject_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	    	          					{field : 'subId',title : '<spring:message code="subject_subId" />',width : 150,align:'center'},
			          					{field : 'subName',title : '<spring:message code="subject_subName" />',width : 150,align:'center'},
			          					{field : 'deptList.deptCode', title : 'Department', width : 150, align:'center',
			                    			formatter : function(value, row, index){
			                    				if(row.deptList)
			                    					return row.deptList.deptName;
			                    			}},
			          					
			                    			{field : 'batchList.semId', title : 'Semester', width : 150, align:'center',
				                    			formatter : function(value, row, index){
				                    				if(row.batchList)
				                    					return row.batchList.semName;
				                    			}},
			          					
			          	                    	{field : 'action',title : '操作',width : 80,align : 'center',formatter : subject_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function subject_list_loadDataGrid(){		 
		subject_list_datagrid = $('#'+subject_list_datagrid_id).datagrid({
			url : subject_list_datagrid_load_url,
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
			columns : subject_list_datagrid_columns,
			toolbar:'#'+subject_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+subject_list_searchform_id+' table').show();
				$('#'+subject_list_datagrid_id).show();
				$('#'+subject_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		subject_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('subject_list_searchBtn','subject_list_clearBtn','subject_list_searchForm',subject_list_datagrid);
	};
	
	function exportSubject() {
		$('#batch_list_searchForm').attr("action", "${ctx}/subject/export");
		$('#batch_list_searchForm').submit();
	}
</script>


