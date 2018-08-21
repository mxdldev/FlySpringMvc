package com.zjx.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjx.httpmodel.EasyuiDataGrid;
import com.zjx.httpmodel.EasyuiDataGridJson;
import com.zjx.httpmodel.Json;
import com.zjx.httpmodel.User;
import com.zjx.model.Article;
import com.zjx.service.ArticleServiceI;

@Controller
@RequestMapping("articleController")
public class ArticleController extends BaseController {
	private static final Logger logger = Logger.getLogger(ArticleController.class);

	private ArticleServiceI articleService;

	public ArticleServiceI getArticleService() {
		return articleService;
	}
	@Autowired
	public void setArticleService(ArticleServiceI articleService) {
		this.articleService = articleService;
	}
	
	@RequestMapping(params = "datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, Article article) {
		return articleService.datagrid(dg, article);
	}
	
	@RequestMapping(params = "add")
	@ResponseBody
	public Article add(Article article) {
		return articleService.add(article);
	}
	
	@RequestMapping(params = "del")
	@ResponseBody
	public Json del(String ids) {
		System.out.println("<<<<<<<:"+ids);
		Json j = new Json();
		articleService.del(ids);
		j.setSuccess(true);
		return j;
	}
	@RequestMapping(params = "edit")
	@ResponseBody
	public Article edit(Article article) {
		return articleService.edit(article);
	}
}
