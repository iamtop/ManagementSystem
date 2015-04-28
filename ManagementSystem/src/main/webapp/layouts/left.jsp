<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="easyui-accordion"
	data-options="fit:true,iconCls:'icon-ok',border:false">

	
	<div class="menuItem" title='Management' data-options="iconCls:''"
		style="padding: 10px;">
		
		<ul>
		<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Manage Employee ',url:'${ctx}/authority',iconCls:'icon-user_gray'})">
				  Manage Employee
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Manage Student ',url:'${ctx}/student',iconCls:'icon-user_gray'})">
				  Manage Student
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
                onclick="indexTabsAddTab('href',{title:'Designation ',url:'${ctx}/roleasignment',iconCls:'icon-user_gray'})">
				  Designation
                </a></li>
                
                <li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
                onclick="indexTabsAddTab('href',{title:'Department ',url:'department',iconCls:'icon-user_gray'})">
				  Departments
                </a></li>
                
            <li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
                onclick="indexTabsAddTab('href',{title:'Batch ',url:'${ctx}/batch',iconCls:'icon-user_gray'})">
				   Batch
                </a></li>
              
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Subject',url:'${ctx}/subject',iconCls:'icon-user_gray'})">
				  Subject gallery
			</a></li>
			
			
			</ul>
	</div>
			<div class="menuItem" title='Staff' data-options="iconCls:''"
		style="padding: 10px;">
		
		<ul>
		<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Task Manager',url:'${ctx}/taskmanager',iconCls:'icon-user_gray'})">
				  Task Manager
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Attendance',url:'${ctx}/attendance',iconCls:'icon-user_gray'})">
				  Attendance
			</a></li>

			
			
			</ul>
	</div>
</div>

