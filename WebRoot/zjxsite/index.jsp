<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript"
	src="../jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
<script type="text/javascript"
	src="../jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="../jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="../jquery-easyui-1.3.1/themes/icon.css"
	type="text/css"></link></head>
<link rel="stylesheet"
	href="../jquery-easyui-1.3.1/themes/default/easyui.css" type="text/css"></link>
<script type="text/javascript" src="../jquery-easyui-1.3.1/syUtils.js"></script>
<body>
	<div id="cc" class="easyui-layout" fit="true">  
    <div data-options="region:'west',title:'坐席系统后台管理',split:false" style="width:200px;" href="${pageContext.request.contextPath}/zjxsite/layout/west.jsp"></div>  
    <div data-options="region:'center',title:'管理中心'" href="layout/center.jsp" style="overflow: hidden;"></div>  
</div>
</body>
</html>
