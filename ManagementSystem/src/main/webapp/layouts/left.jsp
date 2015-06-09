<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="easyui-accordion"
	data-options="fit:true,iconCls:'icon-ok',border:false">

	
	<div class="menuItem" title='管理' data-options="iconCls:''"
		style="padding: 10px;">
		
		<ul>
		<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'员工管理 ',url:'${ctx}/authority',iconCls:'icon-user_gray'})">
				  员工管理
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'学生管理 ',url:'${ctx}/student',iconCls:'icon-user_gray'})">
				  学生管理
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
                onclick="indexTabsAddTab('href',{title:'角色分配 ',url:'${ctx}/roleasignment',iconCls:'icon-user_gray'})">
				  角色分配
                </a></li>
                
                <li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
                onclick="indexTabsAddTab('href',{title:'部 ',url:'department',iconCls:'icon-user_gray'})">
				  部
                </a></li>
                
            <li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
                onclick="indexTabsAddTab('href',{title:'学期 ',url:'${ctx}/batch',iconCls:'icon-user_gray'})">
				   学期
                </a></li>
              
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'科目',url:'${ctx}/subject',iconCls:'icon-user_gray'})">
				  科目
			</a></li>
			
			
			</ul>
	</div>
			<div class="menuItem" title='工作人员' data-options="iconCls:''"
		style="padding: 10px;">
		
		<ul>
		<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'任务管理',url:'${ctx}/taskmanager',iconCls:'icon-user_gray'})">
				  任务管理
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'出勤',url:'${ctx}/attendance',iconCls:'icon-user_gray'})">
				  出勤
			</a></li>

			
			
			</ul>
	</div>
</div>

