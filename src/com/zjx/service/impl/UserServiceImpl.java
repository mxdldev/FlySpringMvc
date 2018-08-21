package com.zjx.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zjx.dao.BaseDaoI;
import com.zjx.httpmodel.EasyuiDataGrid;
import com.zjx.httpmodel.EasyuiDataGridJson;
import com.zjx.httpmodel.User;
import com.zjx.model.Syuser;
import com.zjx.service.UserServiceI;
import com.zjx.util.Encrypt;

/**
 * 用户Service
 * 
 * 
 * 
 */
@Service("userService")
public class UserServiceImpl extends BaseServiceImpl implements UserServiceI {

	private BaseDaoI<Syuser> userDao;

	public BaseDaoI<Syuser> getUserDao() {
		return userDao;
	}

	@Autowired
	public void setUserDao(BaseDaoI<Syuser> userDao) {
		this.userDao = userDao;
	}

	@Cacheable(value = "syproUserCache", key = "'login'+#user.name+#user.password")
	@Transactional(readOnly = true)
	public User login(User user) {
		Syuser u = userDao.get("from Syuser u where u.name=? and u.password=?",
				user.getName(), Encrypt.e(user.getPassword()));
		if (u != null) {
			BeanUtils.copyProperties(u, user);
			return user;
		}
		return null;
	}

	@Transactional(readOnly = true)
	public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, User user) {
		EasyuiDataGridJson j = new EasyuiDataGridJson();
		String hql = " from Syuser t where 1=1 ";
		List<Object> values = new ArrayList<Object>();
		if (user != null) {// 添加查询条件
			if (user.getName() != null && !user.getName().trim().equals("")) {
				hql += " and t.name like '%%" + user.getName().trim() + "%%' ";
			}
			if (user.getCreatedatetimeStart() != null) {
				hql += " and t.createdatetime>=? ";
				values.add(user.getCreatedatetimeStart());
			}
			if (user.getCreatedatetimeEnd() != null) {
				hql += " and t.createdatetime<=? ";
				values.add(user.getCreatedatetimeEnd());
			}
			if (user.getModifydatetimeStart() != null) {
				hql += " and t.modifydatetime>=? ";
				values.add(user.getModifydatetimeStart());
			}
			if (user.getModifydatetimeEnd() != null) {
				hql += " and t.modifydatetime<=? ";
				values.add(user.getModifydatetimeEnd());
			}
		}
		String totalHql = " select count(*) " + hql;
		j.setTotal(userDao.count(totalHql, values));// 设置总记录数
		if (dg.getSort() != null) {// 设置排序
			hql += " order by " + dg.getSort() + " " + dg.getOrder();
		}
		List<Syuser> syusers = userDao.find(hql, dg.getPage(), dg.getRows(),
				values);// 查询分页

		List<User> users = new ArrayList<User>();
		if (syusers != null && syusers.size() > 0) {// 转换模型
			for (Syuser syuser : syusers) {
				User u = new User();
				BeanUtils.copyProperties(syuser, u);

				// Set<SyuserSyrole> syuserSyroleSet =
				// syuser.getSyuserSyroles();
				/*
				 * if (syuserSyroleSet != null && syuserSyroleSet.size() > 0) {
				 * boolean b = false; String roleId = ""; String roleText = "";
				 * for (SyuserSyrole syuserSyrole : syuserSyroleSet) { if (!b) {
				 * b = true; } else { roleId += ","; roleText += ","; } roleId
				 * += syuserSyrole.getSyrole().getId(); roleText +=
				 * syuserSyrole.getSyrole().getText(); } u.setRoleId(roleId);
				 * u.setRoleText(roleText); }
				 */
				users.add(u);
			}
		}
		j.setRows(users);// 设置返回的行
		return j;
	}

	public List<Syuser> getUsers() {
		// TODO Auto-generated method stub
		List<Syuser> listUser = userDao.find(
				"from Syuser where name =? and password=? ", "admin",
				"21232f297a57a5a743894a0e4a801fc3");
		return listUser;
	}

	@CacheEvict(value = "syproUserCache", allEntries = true)
	public User add(User user) {
		user.setId(UUID.randomUUID().toString());
		user.setPassword(Encrypt.e(user.getPassword()));
		if (user.getCreatedatetime() == null) {
			user.setCreatedatetime(new Date());
		}
		if (user.getModifydatetime() == null) {
			user.setModifydatetime(new Date());
		}
		Syuser syuser = new Syuser();
		BeanUtils.copyProperties(user, syuser);
		userDao.save(syuser);

		/*
		 * if (user.getRoleId() != null && !user.getRoleId().equals("")) { for
		 * (String id : user.getRoleId().split(",")) { SyuserSyrole syuserSyrole
		 * = new SyuserSyrole();
		 * syuserSyrole.setId(UUID.randomUUID().toString());
		 * syuserSyrole.setSyrole(roleDao.get(Syrole.class, id));
		 * syuserSyrole.setSyuser(syuser); syuserSyroleDao.save(syuserSyrole); }
		 * }
		 */

		return user;
	}

	@CacheEvict(value = "syproUserCache", allEntries = true)
	public void del(String ids) {
		for (String id : ids.split(",")) {
			Syuser syuser = userDao.get(Syuser.class, id);
			userDao.delete(syuser);
		}
	}
}
