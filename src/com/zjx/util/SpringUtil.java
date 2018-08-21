package com.zjx.util;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * spring工具类
 * 
 * @author 孙宇
 * 
 */
public class SpringUtil {

	private static final ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:spring.xml");

	public static ApplicationContext getApplicationContext() {
		return ac;
	}

	public static Object getBean(String beanName) {
		return ac.getBean(beanName);
	}

}
