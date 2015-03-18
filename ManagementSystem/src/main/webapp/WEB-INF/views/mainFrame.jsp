<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>天宝热泵远程监控系统</title>
<%@ include file="/common/easyui_inc.jsp"%>
<script type="text/javascript"
	src="${ctx}/static/js/extAppJs/app_index.js"></script>
<script type="text/javascript"
	src="${ctx }/static/js/extAppJs/common.js"></script>
</head>
<body>

	<div id="index_layout">
		<div
			data-options="region:'north',border:false,href:'${ctx }/layouts/header.jsp'"
			style="height: 61px;"></div>

		<div
			data-options="iconCls:'icon-application_view_tile',region:'west',title:'导航菜单',split:true"
			style="width: 210%; background-color: white;">	
			<%@ include file="/layouts/left.jsp"%>
			</div>

		<div data-options="iconCls:'icon-calendar',region:'east'" title="日历"
			style="width: 180px; overflow: hidden;">
			<div class="easyui-panel" data-options="border:false"
				style="height: 180px; overflow: hidden;">
				<div id="index_calendar" style="height: 180px; overflow: hidden;">
				
				</div>
			</div>
		</div>


		<div data-options="iconCls:'icon-logo',region:'center'"
			title="拓普网络-引领科技现代生活！" style="overflow: hidden;">
			<div id="index_tabs" style="overflow: hidden;">
			<%-- <iframe name="common" id="common" src="" width="100%" height="99%" style="border: 0" marginhieght="0" marginwidth="0" hspace="0" scrolling="0" frameborader="0"></iframe> --%>
		</div>
		</div>


		<div data-options="region:'south',border:true"
			style="height: 20px; text-align: center;">
			<span style="font-weight: bold;">技术支持：</span><span><a
				href="http://www.iamtop.com" target="_blank">临沂市拓普网络股份有限公司</a></span> <span
				style="font-weight: bold;">咨询热线：</span><span>400-006-7996,800-860-7996</span>
		</div>
	</div>
</body>
</html>