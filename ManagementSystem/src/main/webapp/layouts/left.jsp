<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="easyui-accordion"
	data-options="fit:true,iconCls:'icon-ok',border:false">
	
	
	<div class="menuItem" title='3D Marker Icon' data-options="iconCls:''"
		style="padding: 10px;">
		
		<ul>
		
		<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'Main Frame ',url:'${ctx}/home/maker',iconCls:'icon-user_gray'})">
				  Main Frame:
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="opendailogbox();">
				  Inupt Text:
			</a></li>
			<li>
				
			Color  &nbsp;&nbsp;&nbsp;<input type='color' name='color2' value='#3355cc' id="coloidval" />
				 </li>
				 
				<li>Font &nbsp;&nbsp;&nbsp; <input id="cc1" class="easyui-combobox" style="width:100px;" data-options="
        valueField: 'id',
        textField: 'text',
        data :[{ id:'fzyingbixingshu-s16s',text:'fzyingbixingshu-s16s-name'},{id:'fzxiaozhuanti-s13t',text:'fzxiaozhuanti-s13t-Name'
        			},{id:'fzyaoti',text:'FZYaoTiName'},{id:'kaiti_gb2312',text:'kaitiname'},{id:'lisu',text:'LisuName'}],
        onSelect: function(rec){
        
selectFunction(rec.id);
                   }">
        </li>
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="increaseFont();">
				  Increase
			</a></li>
			
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="decreaseFont();">
				 Decrease
			</a></li>
			
			
			
			
			
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="boldFont();">
				  Bold:
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="opendailogbox();">
				  Italic:
			</a></li>
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="opendailogbox();">
				  UnderLine:
			</a></li>
			
			
			
		<%-- <c:forEach var="device" items="${devices}">
		<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'${device.deviceName}',url:'${ctx}/device/devicelist/${device.id}',iconCls:'icon-user_gray'})">
				   ${device.deviceName}
			</a></li>
		
		</c:forEach>
		
		<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'${device.deviceName}',url:'${ctx}/device/FormDate',iconCls:'icon-user_gray'})">
				  formEasy
			</a></li> --%>
		
			<%-- <li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'XXX community heart pump set',url:'${ctx}/device/devicelist',iconCls:'icon-user_gray'})">
				   XXX community heart pump set
			</a></li>
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'XXX community heart pump set1',url:'${ctx}/device/devicelist',iconCls:'icon-user_gray'})">
					XXX community heart pump set-1
			</a></li>
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'XXX community heart pump set2',url:'${ctx}/device/devicelist',iconCls:'icon-user_gray'})">
					XXX community heart pump set-2
			</a></li> --%>
		</ul>
	</div>
	
	<%-- <div class="menuItem" title='设备监控' data-options="iconCls:'icon-monitor'"
		style="padding: 10px;">
		<ul>
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'热泵空调监控管理',url:'${ctx}/account/user',iconCls:'icon-monitor_go'})">
					<img
					src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/monitor_go.png" />&nbsp;热泵空调监控
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'device',url:'${ctx}/device',iconCls:'icon-monitor_go'})">
					<img
					src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/monitor_go.png" />&nbsp;Device
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'tbcommand',url:'${ctx}/tbcommand',iconCls:'icon-monitor_go'})">
					<img
					src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/monitor_go.png" />&nbsp;Tb_Command
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'tbdevicestate',url:'${ctx}/tbdevicestate',iconCls:'icon-monitor_go'})">
					<img
					src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/monitor_go.png" />&nbsp;Tb_DeviceState
			</a></li>
			
						
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'tbfeedback',url:'${ctx}/tbfeedback',iconCls:'icon-monitor_go'})">
					<img
					src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/monitor_go.png" />&nbsp;Tb_FeedBack
			</a></li>
			
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'tbmodule',url:'${ctx}/tbmodule',iconCls:'icon-monitor_go'})">
					<img
					src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/monitor_go.png" />&nbsp;Tb_Module
			</a></li>
		</ul>
	</div> --%>
	<%-- <div class="menuItem" title='系统设置' data-options="iconCls:'icon-cog'"
		style="padding: 10px;">
		<ul>
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'用户管理',url:'${ctx}/account/user',iconCls:'icon-user_gray'})">
					<img
					src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/user_gray.png" />&nbsp;用户管理
			</a></li>
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'角色管理',url:'${ctx}/account/role',iconCls:'icon-group_key'})">
					<img
					src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/group_key.png" />&nbsp;角色管理
			</a></li>
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'权限管理',url:'${ctx}/account/permission',iconCls:'icon-key'})">
					<img src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/key.png" />&nbsp;权限管理
			</a></li>
			<li><a data-options="plain:true" href="javascript:void(0)"
				class="user easyui-linkbutton"
				onclick="indexTabsAddTab('href',{title:'参数管理',url:'${ctx}/parameter',iconCls:'icon-plugin'})">
					<img
					src="${ctx}/static/js/plugins/jquery-easyui-1.3.4/themes/icons/plugin.png" />&nbsp;参数管理
			</a></li>
		</ul>
	</div> --%>
</div>

