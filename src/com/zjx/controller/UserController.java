package com.zjx.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjx.httpmodel.EasyuiDataGrid;
import com.zjx.httpmodel.EasyuiDataGridJson;
import com.zjx.httpmodel.Json;
import com.zjx.httpmodel.SessionInfo;
import com.zjx.httpmodel.User;
import com.zjx.service.UserServiceI;
import com.zjx.util.IpUtil;
import com.zjx.util.ResourceUtil;


@Controller
@RequestMapping("/userController")
public class UserController extends BaseController{
	private static final Logger logger = Logger.getLogger(UserController.class);

	private UserServiceI userService;

	public UserServiceI getUserService() {
		return userService;
	}

	@Autowired
	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}
	@RequestMapping(params = "west")
	public String west() {
		return "/layout/west";
	}
	@RequestMapping(params = "listsyuser")
	public String listuser() {
		return "zjxsite/syuser/listsyuser";
	}
	@RequestMapping(params = "home")
	public String home(){
		return "/zjxsite/layout/home";
	}
	/*@RequestMapping(params = "loginTest")
	public String loginTest() {
		 List<Syuser> users= userService.getUsers();
		  for(Syuser user:users){
			  System.out.println(user.getName());
		  }
		return "/login";
	}*/
	
	@RequestMapping(params = "login")
	@ResponseBody
	public Json login(User user, HttpSession session, HttpServletRequest request) {
		Json j = new Json();
		User u = userService.login(user);
		if (u != null) {
			j.setSuccess(true);
			j.setMsg("登录成功!");

			u.setIp(IpUtil.getIpAddr(request));
			SessionInfo sessionInfo = new SessionInfo();
			sessionInfo.setUser(u);
			session.setAttribute(ResourceUtil.getSessionInfoName(), sessionInfo);
			j.setObj(u);
		} else {
			j.setMsg("用户名或密码错误!");
		}
		return j;
	}

	@RequestMapping(params = "datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, User user) {
		return userService.datagrid(dg, user);
	}

	@RequestMapping(params = "add")
	@ResponseBody
	public User add(User user) {
		return userService.add(user);
	}
	
	/**
	 * 删除用户
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public Json del(String ids) {
		Json j = new Json();
		userService.del(ids);
		j.setSuccess(true);
		return j;
	}

}
