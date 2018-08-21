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
   	var datagrid;
   	var userDialog;
   	var userForm;
   	var passwordInput;
   	$(function() {
   	userForm = $('#userForm').form();
  	passwordInput = userForm.find('[name=password]').validatebox({required : true});   	
   	datagrid = $('#datagrid').datagrid({
			url : 'userController.do?datagrid',//数据源
			toolbar : '#toolbar',//检索和增删改查
			title : '',//标题
			iconCls : 'icon-save',//标题前面的按钮
			pagination : true,//是否显示分页按钮
			pageSize : 2,//每页显示的条目数
			pageList : [2,4,8 ],//分页下拉菜单
			fit : true,//自适应
			fitColumns : true,//自适应列（如果真则不会出现左右滚动条）
			nowrap : false,//文字自动换行
			border : false,//边框
			idField : 'id',//跨页删除
			frozenColumns : [ [ {
				title : 'id',//第一列的checkbox
				field : 'id',//对应模型中的字段名
				width : 50,
				checkbox : true
			}, {
				field : 'name',
				title : '用户名称',
				width : 100,
				sortable : true
			} ] ],
			columns : [ [ {
				field : 'password',
				title : '密码',
				width : 100,
				formatter : function(value, rowData, rowIndex) {
					return '******';
				}
			}, {
				field : 'createdatetime',
				title : '创建时间',
				width : 150,
				sortable : true
			}, {
				field : 'modifydatetime',
				title : '最后修改时间',
				width : 150,
				sortable : true
			}, {
				field : 'roleText',
				title : '角色',
				width : 200
			}, {
				field : 'roleId',
				title : '角色',
				width : 200,
				hidden : true
			} ] ],
			//当鼠标右单击某一行的时候会触发该方法
			onRowContextMenu : function(e, rowIndex, rowData) {
				console.info("-->"+e+"|"+rowData+"|"+rowIndex);				
				e.preventDefault();//禁用默认菜单
				$(this).datagrid('unselectAll');//数据表格全部不选中
				$(this).datagrid('selectRow', rowIndex);//只选中右单击行
				$('#menu').menu('show', {//显示菜单
					left : e.pageX,
					top : e.pageY
				});
			}
		});
		
		userDialog = $('#userDialog').show().dialog({
			modal : true,
			title : '用户信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (userForm.find('[name=id]').val() != '') {
						userForm.form('submit', {
							url : 'userController.do?edit',
							success : function(data) {
								userDialog.dialog('close');
								$.messager.show({
									msg : '用户编辑成功！',
									title : '提示'
								});
								datagrid.datagrid('reload');
							}
						});
					} else {
						userForm.form('submit', {
							url : 'userController.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										userDialog.dialog('close');
										$.messager.show({
											msg : '用户创建成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									$.messager.show({
										msg : '用户名称已存在！',
										title : '提示'
									});
								}
							}
						});
					}
				}
			} ]
		}).dialog('close');

	});
	//=======================================================
	function remove() {
		var ids = [];
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : 'userController.do?del',
						data : {
							ids : ids.join(',')
						},
						cache : false,
						dataType : "json",
						success : function(response) {
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('reload');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
		}
	}
	
	//=====================================================
	function append() {
		//当点击添加按钮的时候触发该事件，打开添加对话框
		//alert('ok');
		userDialog.dialog('open');		
		passwordInput.validatebox({required : true});
		userForm.find('[name=name]').removeAttr('readonly');
		userForm.form('clear');
	}
	//=======================================================
	function edit() {
		//alert('fafa');
		var rows = datagrid.datagrid('getSelections');
		if(rows.length==0){
			$.messager.alert('提示', '请选择要编辑的记录！', 'error');
		}
		if (rows.length != 1 && rows.length != 0) {
			var names = [];
			for ( var i = 0; i < rows.length; i++) {
				names.push(rows[i].name);
			}
			$.messager.show({
				msg : '只能择一个用户进行编辑！您已经选择了【' + names.join(',') + '】' + rows.length + '个用户',
				title : '提示'
			});
		} else if (rows.length == 1) {
			passwordInput.validatebox({
				required : false
			});
			userForm.find('[name=name]').attr('readonly', 'readonly');
			userDialog.dialog('open');
			userForm.form('clear');
			userForm.form('load', {
				id : rows[0].id,
				name : rows[0].name,
				password : '',
				createdatetime : rows[0].createdatetime,
				modifydatetime : rows[0].modifydatetime,
				roleId : sy.getList(rows[0].roleId)
			});
		}
	}

	function editRole() {
		var ids = [];
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			for ( var i = 0; i < rows.length; i++) {
				ids.push(rows[i].id);
			}
			userRoleForm.find('input[name=userIds]').val(ids.join(','));
			userRoleDialog.dialog('open');
		} else {
			$.messager.alert('提示', '请选择要编辑的记录！', 'error');
		}
	}
	
   </script>
  </head>
  
<body class="easyui-layout" fit="true">
<div region="center" border="false" style="overflow: hidden;">
  	<div id="toolbar" class="datagrid-toolbar" style="height: auto;display: none;">
  			<!-- 检索 -->
			<fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<th>用户名称</th>
						<td colspan="2"><input name="name" style="width: 305px;" />
						</td>
					</tr>
					<tr>
						<th>创建时间</th>
						<td colspan="2"><input name="createdatetimeStart" class="easyui-datetimebox" editable="false" style="width: 150px;" />-<input name="createdatetimeEnd" class="easyui-datetimebox" editable="false" style="width: 150px;" />
						</td>
					</tr>
					<tr>
						<th>最后修改时间</th>
						<td><input name="modifydatetimeStart" class="easyui-datetimebox" editable="false" style="width: 150px;" />-<input name="modifydatetimeEnd" class="easyui-datetimebox" editable="false" style="width: 150px;" /></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="clearFun();" href="javascript:void(0);">清空</a>
						</td>
					</tr>
				</table>
			</fieldset>
			<!-- 增删改查 -->
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add" onclick="append();" plain="true" href="javascript:void(0);">增加</a>
				<a class="easyui-linkbutton" iconCls="icon-remove" onclick="remove();" plain="true" href="javascript:void(0);">删除</a>
				<a class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();" plain="true" href="javascript:void(0);">编辑</a> 
				<a class="easyui-linkbutton" iconCls="icon-undo" onclick="datagrid.datagrid('unselectAll');" plain="true" href="javascript:void(0);">取消选中</a>
			</div>
	</div>
	<!-- 列表 -->	
   <table id="datagrid"></table>
</div>
<!-- 右键菜单 -->
	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="append();" iconCls="icon-add">增加</div>
		<div onclick="remove();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>
	
<!-- 用户添加 -->
	<div id="userDialog" style="display: none;overflow: hidden;">
		<form id="userForm" method="post">
			<table class="tableForm">
				<tr>
					<th>用户ID</th>
					<td><input name="id" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>登录名称</th>
					<td><input name="name" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr title="如果不更改密码,请留空!">
					<th>登录密码</th>
					<td><input name="password" type="password" /></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input name="createdatetime" class="easyui-datetimebox" style="width: 156px;" /></td>
				</tr>
				<tr>
					<th>最后修改时间</th>
					<td><input name="modifydatetime" class="easyui-datetimebox" style="width: 156px;" /></td>
				</tr>
				<tr>
					<th>所属角色</th>
					<td><select name="roleId" style="width: 156px;"></select></td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>
