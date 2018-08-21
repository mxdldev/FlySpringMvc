package com.zjx.dao.impl;

import org.springframework.stereotype.Repository;

import com.zjx.dao.BaseDaoI;
@Repository("articleDao") 
public class ArticleDaoImpl<T> extends BaseDaoImpl<T> implements BaseDaoI<T> {

}
