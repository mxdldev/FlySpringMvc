 <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%> 
<script type="text/javascript">
var centerTabs;
	function addTabFun(opts) {
		//console.log("href:"+opts.src);
		
		var options = $.extend({
			title : '',
			content : '<iframe src="' + opts.src + '" frameborder="0" style="border:0;width:100%;height:99.2%;"></iframe>',
			closable : true,
			iconCls : ''
		}, opts);
		if (centerTabs.tabs('exists', options.title)) {
			centerTabs.tabs('close', options.title);
		}
		
		centerTabs.tabs('add', options);
	};
	$(function() {
		centerTabs = $('#centerTabs').tabs({
			border : false,
			fit : true
		});
		 setTimeout(function() {
			var src = 'userController.do?home';		
			console.info(sy.bp() + "/" + src );			
			centerTabs.tabs('add', {
				title : '新闻列表',
				content : '<iframe src="'+ sy.bp() + "/" + src + '" frameborder="0" style="border:0;width:100%;height:99.2%;"></iframe>',
				closable : true,
				iconCls : ''
			});
		}, 0);
	});
</script>
 <div id="centerTabs"></div>