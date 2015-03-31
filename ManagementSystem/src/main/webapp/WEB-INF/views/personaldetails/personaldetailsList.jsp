<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="personaldetails_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						    						<th><spring:message code="personaldetails_fname" /></th>
						<td><input type="text" name="search_EQ_fname"
							value="${ param.search_EQ_fname}"
							id="search_EQ_fname" /></td>   						<th><spring:message code="personaldetails_lname" /></th>
						<td><input type="text" name="search_EQ_lname"
							value="${ param.search_EQ_lname}"
							id="search_EQ_lname" /></td>                    						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="personaldetails_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="personaldetails_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="personaldetails_list_dg" style="display: none;"></table>
		</div>
		<div id="personaldetails_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(personaldetails_list_create_url,'personaldetails_form_inputForm',personaldetails_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> 			
		  	  <a href="javascript:deleteBatch(personaldetails_list_delete_url,personaldetails_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var personaldetails_list_datagrid;
	//列表DataGrid ID
	var personaldetails_list_datagrid_id = 'personaldetails_list_dg';
	//列表查询表单ID
	var personaldetails_list_searchform_id = 'personaldetails_list_searchForm';
	//列表toolbar ID
	var personaldetails_list_toolbar_id = 'personaldetails_list_toolbar';
	//操作链接
	var personaldetails_list_create_url =  '${ctx}/personaldetails/create';
	var personaldetails_list_update_url =  '${ctx}/personaldetails/update/';
	var personaldetails_list_delete_url =  '${ctx}/personaldetails/delete';
	var personaldetails_list_view_url =  '${ctx}/personaldetails/view/';
	var personaldetails_list_datagrid_load_url = '${ctx}/personaldetails/findList';
	
	//定义相关的操作按钮
	function personaldetails_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'personaldetails_form_inputForm\',personaldetails_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				personaldetails_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',personaldetails_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,personaldetails_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				personaldetails_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var personaldetails_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	    	          					{field : 'pId',title : '<spring:message code="personaldetails_pId" />',width : 150,align:'center'},
			          					{field : 'fname',title : '<spring:message code="personaldetails_fname" />',width : 150,align:'center'},
			          					{field : 'lname',title : '<spring:message code="personaldetails_lname" />',width : 150,align:'center'},
			          					{field : 'address',title : '<spring:message code="personaldetails_address" />',width : 150,align:'center'},
			          					{field : 'email',title : '<spring:message code="personaldetails_email" />',width : 150,align:'center'},
			          					{field : 'phone',title : '<spring:message code="personaldetails_phone" />',width : 150,align:'center'},
			          					{field : 'gender',title : '<spring:message code="personaldetails_gender" />',width : 150,align:'center'},
			          					{field : 'fatherName',title : '<spring:message code="personaldetails_fatherName" />',width : 150,align:'center'},
			          					{field : 'motherName',title : '<spring:message code="personaldetails_motherName" />',width : 150,align:'center'},
			          					{field : 'dob',title : '<spring:message code="personaldetails_dob" />',width : 150,align:'center'},
			          					{field : 'doj',title : '<spring:message code="personaldetails_doj" />',width : 150,align:'center'},
			          	                    	{field : 'action',title : '操作',width : 80,align : 'center',formatter : personaldetails_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function personaldetails_list_loadDataGrid(){		 
		personaldetails_list_datagrid = $('#'+personaldetails_list_datagrid_id).datagrid({
			url : personaldetails_list_datagrid_load_url,
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
			columns : personaldetails_list_datagrid_columns,
			toolbar:'#'+personaldetails_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+personaldetails_list_searchform_id+' table').show();
				$('#'+personaldetails_list_datagrid_id).show();
				$('#'+personaldetails_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		personaldetails_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('personaldetails_list_searchBtn','personaldetails_list_clearBtn','personaldetails_list_searchForm',personaldetails_list_datagrid);
	};
</script>


