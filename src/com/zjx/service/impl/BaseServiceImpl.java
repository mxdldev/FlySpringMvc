package com.zjx.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.zjx.service.BaseServiceI;



/**
 * 基础Service,所有ServiceImpl需要extends此Service来获得默认事务的控制
 * 
 *
 * 
 */
@Service("baseService")
@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class BaseServiceImpl implements BaseServiceI {

}
