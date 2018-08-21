package com.zjx.util;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zjx.model.Syuser;
import com.zjx.service.UserServiceI;

public class Test {
	public static void main(String[] args) {
		  ApplicationContext ctx=new ClassPathXmlApplicationContext("spring.xml");
		  UserServiceI userService=(UserServiceI) ctx.getBean("userService");
		  List<Syuser> users= userService.getUsers();
		  for(Syuser user:users){
			  System.out.println(user.getName());
		  }
		 }
}
