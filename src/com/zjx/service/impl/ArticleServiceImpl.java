package com.zjx.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.zjx.dao.BaseDaoI;
import com.zjx.httpmodel.EasyuiDataGrid;
import com.zjx.httpmodel.EasyuiDataGridJson;
import com.zjx.httpmodel.User;
import com.zjx.model.Article;
import com.zjx.model.Syuser;
import com.zjx.service.ArticleServiceI;

@Service("articleService")
public class ArticleServiceImpl extends BaseServiceImpl implements ArticleServiceI {
	private BaseDaoI<Article> articleDao;
	
	public BaseDaoI<Article> getArticleDao() {
		return articleDao;
	}
	
	@Autowired
	public void setArticleDao(BaseDaoI<Article> articleDao) {
		this.articleDao = articleDao;
	}

	@Transactional(readOnly = true)
	public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, Article article) {
		EasyuiDataGridJson j = new EasyuiDataGridJson();
		String hql = " from Article t where 1=1 ";
		List<Object> values = new ArrayList<Object>();
		if(article != null) {// 添加查询条件
			if(article.getTitle() != null && !article.getTitle().trim().equals("")) {
				hql += " and t.title like '%%" + article.getTitle().trim() + "%%' ";
			}			
		}
		String totalHql = " select count(*) " + hql;
		j.setTotal(articleDao.count(totalHql, values));// 设置总记录数
		if (dg.getSort() != null) {// 设置排序
			hql += " order by " + dg.getSort() + " " + dg.getOrder();
		}
		List<Article> articles = articleDao.find(hql, dg.getPage(), dg.getRows(), values);// 查询分页		
		j.setRows(articles);// 设置返回的行
		return j;
	}

	public Article add(Article article) {
		// TODO Auto-generated method stub
		if (article.getRegtime() == null) {
			article.setRegtime(new Date());
		}
		articleDao.save(article);
		return article;
	}

	public void del(String ids) {
		for (String id : ids.split(",")) {
			Article article = articleDao.get(Article.class, Integer.parseInt(id));
			articleDao.delete(article);
		}
	}

	public Article edit(Article article) {
		//Article syuser = articleDao.get(Article.class, article.getArtid());
		articleDao.update(article);	
		return article;
	}

}
