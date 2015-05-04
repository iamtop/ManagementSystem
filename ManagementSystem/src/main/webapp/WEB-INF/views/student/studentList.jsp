<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div data-options="fit:true" class="easyui-panel">
	<div class="easyui-layout" data-options="fit:true">
		<div
			data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
			style="height: 65px;overflow: hidden;">
			<form id="student_list_searchForm" method="post"
				style="width:100%;overflow:hidden;">
				<table class="search_table" style="width: 100%;">
					<tr>
						    						<th><spring:message code="student_studId" /></th>
						<td><input type="text" name="search_EQ_studId"
							value="${ param.search_EQ_studId}"
							id="search_EQ_studId" /></td>  						<th style="width:20%;">&nbsp;<a href="javascript:void(0);"
							id="student_list_searchBtn">查询</a>&nbsp;<a
							href="javascript:void(0);" id="student_list_clearBtn">清空</a></th>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="student_list_dg" style="display: none;"></table>
		</div>
		<div id="student_list_toolbar" style="display: none;">
				<a href="javascript:updateForm(student_list_create_url,'student_form_inputForm',student_list_datagrid,{title:'新增信息'});" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a> 			
		  	  <a href="javascript:deleteBatch(student_list_delete_url,student_list_datagrid);" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:false">删除</a>
			</div> 
	</div>
</div>
<script type="text/javascript">
	//列表DataGrid
	var student_list_datagrid;
	//列表DataGrid ID
	var student_list_datagrid_id = 'student_list_dg';
	//列表查询表单ID
	var student_list_searchform_id = 'student_list_searchForm';
	//列表toolbar ID
	var student_list_toolbar_id = 'student_list_toolbar';
	//操作链接
	var student_list_create_url =  '${ctx}/student/create';
	var student_list_update_url =  '${ctx}/student/update/';
	var student_list_delete_url =  '${ctx}/student/delete';
	var student_list_view_url =  '${ctx}/student/view/';
	var student_list_datagrid_load_url = '${ctx}/student/findList';
	
	//定义相关的操作按钮
	function student_list_actionFormatter(value,row,index){
		var str = '';	
		str += formatString(
				'<img onclick="updateForm(\'{0}\',\'student_form_inputForm\',student_list_datagrid,{title:\'编辑信息\'});" src="{1}" title="编辑"/>',
				student_list_update_url + row.id,
				'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_edit.png');
		str += '&nbsp;';
		str += formatString('<img onclick="deleteOne(\'{0}\',\'{1}\',student_list_datagrid);" src="{2}" title="删除"/>',
		                    row.id,student_list_delete_url,'${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/application_form_delete.png');
		str += '&nbsp;';
		str += formatString(
				'<img onclick="view(\'{0}\',\'{1}\');" src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/view.png" title="查看"/>',
				student_list_view_url + row.id);
		str += '&nbsp;';
		return str;
	}
	
	//DataGrid字段设置
	var student_list_datagrid_columns = [ [
	                    		{field : 'id',title : '编号',width : 150,checkbox : true,align:'center'},
	    	          					{field : 'studId',title : '<spring:message code="student_studId" />',width : 150,align:'center'},
	    	          					
	    	          					{field : 'personal.pId', title : 'Personal Id', width : 150, align:'center',
	    	                    			formatter : function(value, row, index){
	    	                    				if(row.personal)
	    	                    					return row.personal.pId;
	    	                    				
	    	                    			}},
	    	                    			{field : 'deptList.deptId', title : 'Department', width : 150, align:'center',
	    		                    			formatter : function(value, row, index){
	    		                    				if(row.deptList)
	    		                    					return row.deptList.deptName;
	    		                    			}},
	    		                    			
	    		                    			{field : 'batchList.semId', title : 'Semester', width : 150, align:'center',
					                    			formatter : function(value, row, index){
					                    				if(row.batchList)
					                    					return row.batchList.semName;
					                    			}},
				          					
	    			                    		{field : 'personal.fname', title : 'FirstName', width : 150, align:'center',
	    				                    		formatter : function(value, row, index){
	    				                    			if(row.personal)
	    				                    				return row.personal.fname;
	    				                    		}},
	    			                    		{field : 'personal.lname', title : 'LastName', width : 150, align:'center',
	    				                    		formatter : function(value, row, index){
	    				                    			if(row.personal)
	    				                    				return row.personal.lname;
	    				                    		}},
	    			                    		{field : 'personal.address', title : 'Address', width : 150, align:'center',
	    				                    		formatter : function(value, row, index){
	    				                    			if(row.personal)
	    				                    				return row.personal.address;
	    				                    		}},
	    			                    		{field : 'personal.email', title : 'Email', width : 150, align:'center',
	    				                    		formatter : function(value, row, index){
	    				                    			if(row.personal)
	    				                    				return row.personal.email;
	    				                    		}},
	    			                    		{field : 'personal.phone', title : 'Phone', width : 150, align:'center',
	    				                    		formatter : function(value, row, index){
	    				                    			if(row.personal)
	    				                    				return row.personal.phone;
	    				                    		}},
	    			                    		{field : 'personal.gender', title : 'Gender', width : 150, align:'center',
	    				                    		formatter : function(value, row, index){
	    				                    			if(row.personal)
	    				                    				return row.personal.gender;
	    				                    		}},
	    			                    		{field : 'personal.fatherName', title : 'Father Name', width : 150, align:'center',
	    				                    		formatter : function(value, row, index){
	    				                    			if(row.personal)
	    				                    				return row.personal.fatherName;
	    				                    		}},
	    			                    		{field : 'personal.motherName', title : 'Mother Name', width : 150, align:'center',
	    				                    		formatter : function(value, row, index){
	    				                    			if(row.personal)
	    				                    				return row.personal.motherName;
	    				                    		}},
	    			                    		{field : 'personal.dob', title : 'Date of Birth', width : 150, align:'center',
	    				                    		formatter : function(value, row, index){
	    				                    			if(row.personal)
	    				                    				return row.personal.dob;
	    				                    		}},
	    			                    		{field : 'personal.doj', title : 'Date of Join', width : 150, align:'center',
	    				                    		formatter : function(value, row, index){
	    				                    			if(row.personal)
	    				                    				return row.personal.doj;
	    				                    		}},
	    	          					
	    	          					
	    	          					
	    	          					
	    	          					
			          	                    	{field : 'action',title : '操作',width : 80,align : 'center',formatter : student_list_actionFormatter} 
	                    		] ];
	/** 初始化DataGrid,加载数据 **/		
	function student_list_loadDataGrid(){		 
		student_list_datagrid = $('#'+student_list_datagrid_id).datagrid({
			url : student_list_datagrid_load_url,
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
			columns : student_list_datagrid_columns,
			toolbar:'#'+student_list_toolbar_id,
			onLoadSuccess : function() {	
				$(this).datagrid('tooltip');
				$('#'+student_list_searchform_id+' table').show();
				$('#'+student_list_datagrid_id).show();
				$('#'+student_list_toolbar_id).show();
				parent. $ .messager.progress('close');
			}
		});
	}
	$ .parser.onComplete = function() {
		//加载DataGrid数据
		student_list_loadDataGrid();	
		//绑定按钮事件
		bindSearchBtn('student_list_searchBtn','student_list_clearBtn','student_list_searchForm',student_list_datagrid);
	};
</script>


