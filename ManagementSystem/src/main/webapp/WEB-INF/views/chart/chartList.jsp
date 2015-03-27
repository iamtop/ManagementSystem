<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%-- <%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="chart_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						    						<th><spring:message code="chart_subject" /></th>
						<td><input type="text" name="search_EQ_subject"
							value="${ param.search_EQ_subject}"
							id="search_EQ_subject" /></td>   						<th><spring:message code="chart_role" /></th>
						<td><input type="text" name="search_EQ_role"
							value="${ param.search_EQ_role}"
							id="search_EQ_role" /></td>        						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="chart_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="chart_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="chart_list_dg" style="display: none;"></table>
		</div>
		<div id="chart_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(chart_list_create_url,'chart_form_inputForm',chart_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> 			
		  	  <a href="javascript:deleteBatch(chart_list_delete_url,chart_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var chart_list_datagrid;
	//列表DataGrid ID
	var chart_list_datagrid_id = 'chart_list_dg';
	//列表查询表单ID
	var chart_list_searchform_id = 'chart_list_searchForm';
	//列表toolbar ID
	var chart_list_toolbar_id = 'chart_list_toolbar';
	//操作链接
	var chart_list_create_url =  '${ctx}/chart/create';
	var chart_list_update_url =  '${ctx}/chart/update/';
	var chart_list_delete_url =  '${ctx}/chart/delete';
	var chart_list_view_url =  '${ctx}/chart/view/';
	var chart_list_datagrid_load_url = '${ctx}/chart/findList';
	
	//定义相关的操作按钮
	function chart_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'chart_form_inputForm\',chart_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				chart_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',chart_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,chart_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				chart_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var chart_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	    	          					{field : 'name',title : '<spring:message code="chart_name" />',width : 150,align:'center'},
			          					{field : 'subject',title : '<spring:message code="chart_subject" />',width : 150,align:'center'},
			          					{field : 'role',title : '<spring:message code="chart_role" />',width : 150,align:'center'},
			          					{field : 'email',title : '<spring:message code="chart_email" />',width : 150,align:'center'},
			          					{field : 'image',title : '<spring:message code="chart_image" />',width : 150,align:'center'},
			          	                    	{field : 'action',title : '操作',width : 80,align : 'center',formatter : chart_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function chart_list_loadDataGrid(){		 
		chart_list_datagrid = $('#'+chart_list_datagrid_id).datagrid({
			url : chart_list_datagrid_load_url,
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
			columns : chart_list_datagrid_columns,
			toolbar:'#'+chart_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+chart_list_searchform_id+' table').show();
				$('#'+chart_list_datagrid_id).show();
				$('#'+chart_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		chart_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('chart_list_searchBtn','chart_list_clearBtn','chart_list_searchForm',chart_list_datagrid);
	};
</script>
 --%>

 <script>parent.$.messager.progress('close');</script>

    <script type='text/javascript'> 
        $(window).load(function () {
            var options = new primitives.orgdiagram.Config();

            var items = [
                new primitives.orgdiagram.ItemConfig({
                    id: 0,
                    parent: null,
                    title: "Scott Aasrud",
                    description: "VP, Public Sector",
                    /* image: "demo/images/photos/a.png" */
                }),
                new primitives.orgdiagram.ItemConfig({
                    id: 1,
                    parent: 0,
                    title: "Ted Lucas",
                    description: "VP, Human Resources",
                    /* image: "demo/images/photos/b.png" */
                }),
                new primitives.orgdiagram.ItemConfig({
                    id: 2,
                    parent: 0,
                    title: "Joao Stuger",
                    description: "Business Solutions, US",
                    /* image: "demo/images/photos/c.png" */
                })
            ];

            options.items = items;

            $("#basicdiagram").orgDiagram(options);
        });

    </script>
    <div id="basicdiagram" /> 
    <!-- style="width: 640px; height: 480px; border-style: dotted; border-width: 1px;" --> 
 