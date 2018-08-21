package com.zjx.httpmodel;

/**
 * session信息模型
 * 
 * @author 孙宇
 * 
 */
public class SessionInfo implements java.io.Serializable {

	private User user;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
