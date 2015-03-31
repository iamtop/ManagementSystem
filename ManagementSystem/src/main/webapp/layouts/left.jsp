<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="easyui-accordion"
	data-options="fit:true,iconCls:'icon-ok',border:false">

	
	<div class="menuItem" title='Management' data-options="iconCls:''"
		style="padding: 10px;">
		
		<ul>
		<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Authority ',url:'${ctx}/authority',iconCls:'icon-user_gray'})">
				  Authority
			</a></li>
		
		<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Personal ',url:'${ctx}/personaldetails',iconCls:'icon-user_gray'})">
				  Personal Details
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Student ',url:'${ctx}/student',iconCls:'icon-user_gray'})">
				  Student
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
                onclick="indexTabsAddTab('href',{title:'AsignRole ',url:'${ctx}/roleasignment',iconCls:'icon-user_gray'})">
				  Asign Role
                </a></li>
                
            <li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
                onclick="indexTabsAddTab('href',{title:'Batch ',url:'${ctx}/batch',iconCls:'icon-user_gray'})">
				  Batch
                </a></li>
              
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Subject',url:'${ctx}/subject',iconCls:'icon-user_gray'})">
				  Subject
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Attendance',url:'${ctx}/attendance',iconCls:'icon-user_gray'})">
				  Attendance
			</a></li>

			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Chart',url:'${ctx}/chart',iconCls:'icon-user_gray'})">
				  Chart
			</a></li>
			
			</ul>
	</div>
</div>

