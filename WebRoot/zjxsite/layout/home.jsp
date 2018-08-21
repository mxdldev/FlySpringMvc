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
   	var articleDialog;	
   	$(function() { 
   	articleForm = $('#articleForm').form();   
   	datagrid = $('#datagrid').datagrid({
			url : 'articleController.do?datagrid',//数据源
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
			idField : 'artid',//跨页删除
			frozenColumns : [ [ {
				title : 'artid',//第一列的checkbox
				field : 'artid',//对应模型中的字段名
				width : 50,
				checkbox : true
			}, {
				field : 'title',
				title : '标题',
				width : 100,
				sortable : true
			} ] ],
			columns : [ [ {
				field : 'content',
				title : '内容',
				width : 100	
			},{
				field : 'regtime',
				title : '发布时间',
				width : 200,				
			} ] ]			
		});
		
		articleDialog = $('#articleDialog').show().dialog({
			modal : true,
			title : '文章信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (articleForm.find('[name=artid]').val() != '') {
						articleForm.form('submit', {
							url : 'articleController.do?edit',
							success : function(data) {
								articleDialog.dialog('close');
								$.messager.show({
									msg : '文章编辑成功！',
									title : '提示'
								});
								datagrid.datagrid('reload');
							}
						});
					} else {
						articleForm.form('submit', {
							url : 'articleController.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										articleDialog.dialog('close');
										$.messager.show({
											msg : '文章创建成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									$.messager.show({
										msg : '文章已存在！',
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
	
	
	//=================================================
	function remove() {
		var ids = [];
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].artid);
					}
					$.ajax({
						url : 'articleController.do?del',
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
	//=================================================
	//=======================================================
	function edit() {		
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
				msg : '只能择一篇文章进行编辑！您已经选择了【' + names.join(',') + '】' + rows.length + '个文章',
				title : '提示'
			});
		} else if (rows.length == 1) {	
			articleDialog.dialog('open');
			articleForm.form('clear');
			articleForm.form('load', {
				artid : rows[0].artid,
				title : rows[0].title,
				content : rows[0].content,
				regtime : rows[0].regtime
			});
		}
	}	
	//=================================================
	function append() {
		//当点击添加按钮的时候触发该事件，打开添加对话框		
		articleForm.form('clear');
		articleDialog.dialog('open');				
	}
	//=================================================
	function searchFun() {		
		datagrid.datagrid('load', {title : $('#toolbar input[name=title]').val()});		
	}
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
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
						<th>标题名称</th>
						<td colspan="2"><input name="title" style="width:305px;" />
						<td>
							<a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a>
							<a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="clearFun();" href="javascript:void(0);">清空</a>
						</td>
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
<!-- 文章添加 -->
<div id="articleDialog" style="display: none;overflow: hidden;">
		<form id="articleForm" method="post">
			<table class="tableForm">
				
				<tr>
					<th>标题<input name="artid" type="hidden" /></th>
					<td><input name="title" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>正文内容</th>
					<td><input name="content" type="text" /></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input name="regtime" class="easyui-datetimebox" style="width: 156px;" /></td>
				</tr>				
			</table>
		</form>
	</div>
</body>
</html>
