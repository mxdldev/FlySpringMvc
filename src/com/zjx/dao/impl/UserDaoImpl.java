package com.zjx.dao.impl;

import org.springframework.stereotype.Repository;

import com.zjx.dao.UserDaoI;



@Repository("userDao")
public class UserDaoImpl<T> extends BaseDaoImpl<T> implements UserDaoI<T> {

}
