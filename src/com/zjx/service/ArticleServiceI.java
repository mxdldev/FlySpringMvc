package com.zjx.service;

import com.zjx.httpmodel.EasyuiDataGrid;
import com.zjx.httpmodel.EasyuiDataGridJson;
import com.zjx.httpmodel.User;
import com.zjx.model.Article;

public interface ArticleServiceI extends BaseServiceI {
	public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, Article article);
	public Article add(Article article);
	public void del(String ids);
	public Article edit(Article article);
}
