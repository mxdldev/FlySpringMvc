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
<link rel="stylesheet"	href="jquery-easyui-1.3.1/themes/default/easyui.css" type="text/css"></link>
<script type="text/javascript" src="jquery-easyui-1.3.1/syUtils.js"></script>	
<script type="text/javascript">
	var loginAndRegDialog;
	var loginInputForm;
	$(function(){
		loginInputForm = $('#loginInputForm').form({
			url : 'userController.do?login',
			success : function(data) {
				console.info(data);
				var d = $.parseJSON(data);
				console.info('fafafa===========================================');
				console.info(d);
				if (d.success) {
					loginAndRegDialog.dialog('close');
					//$('#indexLayout').layout('panel', 'center').panel('setTitle', sy.fs('[{0}]，欢迎您！[{1}]', d.obj.name, d.obj.ip));
					location.href='zjxsite/';
				} else {
					loginInputForm.find('input[name=password]').focus();
				} 
				$.messager.show({
					msg : d.msg,
					title : '提示'
				});
			}
		});
		
		loginAndRegDialog = $('#login').dialog({
			width : 300,
			height : 150,
			title : '用户登录',
			modal : true,
			buttons:[{
				id:'btnReg',
				text:'注册',
				handler:function(){
					//console.info('btnReg');
				}
					
			},{
				id:'btnLogin',
				text:'登录',
				handler:function(){
					loginInputForm.submit();
					//console.info('btnLogin');
				}
			}]
		});
	});
</script>
</head>

<body id="indexLayout">
	<div id="login" title="用户登录">
		<form id="loginInputForm" method="post">
			<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<th align="right" width="25%">用户名：</th>
					<td><input name="name" type="text" value="" class="easyui-validatebox" required="true" value=""></td>
				</tr>
				<tr>
					<th align="right">密码：</th>
					<td><input name="password" type="password" class="easyui-validatebox" required="true" value=""></td>
				</tr>				
			</table>
		</form>
	</div>
</body>
</html>
