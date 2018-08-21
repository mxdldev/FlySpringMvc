<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
var tree;
$(function(){
	tree = $('#tt');
});
function collapseAll() {
	var node = tree.tree('getSelected');
	if (node) {
		tree.tree('collapseAll', node.target);
	}else{
		tree.tree('collapseAll');
	}
}
function expandAll() {
	var node = tree.tree('getSelected');		
	if (node) {
		tree.tree('expandAll', node.target);
	} else {
		tree.tree('expandAll');
	}
}
function loadPage(title,href){
	$.messager.progress({text : '请求数据中....',interval : 300});
	addTabFun({
		src : href,
		title : title
	});
}
</script>
<div id="aa" class="easyui-panel" fit="true" border="false">
	<div class="easyui-accordion" fit="true" border="false">
		<div title="系统菜单" iconCls="icon-tip">
			<div class="easyui-layout" fit="true">
				<div region="north" border="false" style="overflow: hidden;">
					<a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-redo" onclick="expandAll();">展开</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-undo" onclick="collapseAll();">折叠</a>
				<!-- 	<a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-reload" onclick="tree.tree('reload');">刷新</a> -->
					<hr style="border-color: #fff;" />
				</div>
				<div region="center" border="false">				
					    <ul id="tt" class="easyui-tree">  
        <li>  
            <span>首页</span>  
            <ul>  
                <li>  
                    <span>通信导航</span>  
                    <ul>  
                        <li>  
                            <span><a href="#">目的地设置</a></span>  
                        </li>  
                        <li>  
                            <span><a href="#">历史目的地</a></span>  
                        </li> 
                    </ul>  
                </li>  
                <li>  
                    <span>地图服务</span>  
                    <ul>  
                        <li>  
                            <span><a href="#">地图搜索</a></span>  
                        </li>  
                        <li>  
                            <span><a href="#">交通信息</a></span>  
                        </li> 
                        <li>  
                            <span><a href="#">驾车路线</a></span>  
                        </li> 
                        <li>  
                            <span><a href="#">公交查询</a></span>  
                        </li> 
                        <li>  
                            <span><a href="#">交叉路口</a></span>  
                        </li> 
                    </ul>  
                </li>  
                 <li>  
                    <span>会员管理</span>  
                    <ul> 
                    	 <li>  
                            <span><a href="#" onclick="return loadPage('会员列表','${pageContext.request.contextPath}/userController.do?listsyuser');">会员列表</a></span>  
                        </li> 
                        <li>  
                            <span><a href="#">产品查询</a></span>  
                        </li>                         
                    </ul>  
                </li>  
                 <li>  
                    <span>任务服务管理</span>  
                    <ul>  
                        <li>  
                            <span><a href="#">当前任务</a></span>  
                        </li>  
                        <li>  
                            <span><a href="#">未完成的任务</a></span>  
                        </li> 
                         <li>  
                            <span><a href="#">历史任务</a></span>  
                        </li> 
                         <li>  
                            <span><a href="#">历史服务</a></span>  
                        </li> 
                    </ul>  
                </li>  
                  <li>  
                    <span>实用工具</span>  
                    <ul>  
                        <li>  
                            <span><a href="#">区县归属查询</a></span>  
                        </li>  
                         <li>  
                            <span><a href="#">通用短信发送</a></span>  
                        </li>  
                         <li>  
                            <span><a href="#">外乎电话</a></span>  
                        </li>                         
                    </ul>  
                </li>  
            </ul>  
        </li> 
    </ul>  
				</div>
			</div>
		</div>
		<div title="系统帮助" href="${pageContext.request.contextPath}/zjxsite/help.jsp"></div>
	</div>
</div>