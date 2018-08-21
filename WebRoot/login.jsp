<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript"
	src="jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
<script type="text/javascript"
	src="jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="jquery-easyui-1.3.1/themes/icon.css"
	type="text/css"></link>
<link rel="stylesheet"
	href="jquery-easyui-1.3.1/themes/default/easyui.css" type="text/css"></link>
<script type="text/javascript">
	$(function() {
		$('#login').dialog({
			width : 300,
			height : 150,
			title : '用户登录',
			modal : true
		});
	});
</script>
</head>

<body>
	<div id="login" title="用户登录">
		<form action="">
			<table width="100%" cellpadding="4" cellspacing="4">
				<tr>
					<th align="right" width="25%">用户名：</th>
					<td><input type="text"></td>
				</tr>
				<tr>
					<th align="right">密码：</th>
					<td><input type="password"></td>
				</tr>
				<tr>
					<td align="right"><input type="button" value="注册"></td>
					<td><input type="submit" value="登录"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
