package com.zjx.service;

import java.util.List;

import com.zjx.httpmodel.EasyuiDataGrid;
import com.zjx.httpmodel.EasyuiDataGridJson;
import com.zjx.httpmodel.User;
import com.zjx.model.Syuser;


/**
 * 用户Service
 * 
 * @author 孙宇
 * 
 */
public interface UserServiceI extends BaseServiceI {

	/**
	 * 用户注册
	 * 
	 * @param user
	 *            用户信息
	 * @return User
	 */
//	public User reg(User user);

	/**
	 * 用户登录
	 * 
	 * @param user
	 *            用户信息
	 * @return User
	 */
	public User login(User user);
	public List<Syuser> getUsers();
	public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, User user);
	public User add(User user);
	public void del(String ids);
	/*public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, User user);

	public List<User> combobox(String q);

	

	public User edit(User user);

	

	public void editUsersRole(String userIds, String roleId);

	public User getUserInfo(User user);

	public User editUserInfo(User user);*/

}
