package com.zjx.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * Syuser entity. @author MyEclipse Persistence Tools
 */

public class Syuser implements java.io.Serializable {

	// Fields

	private String id;
	private String name;
	private String password;
	private Date createdatetime;
	private Date modifydatetime;

	// Constructors

	/** default constructor */
	public Syuser() {
	}

	/** minimal constructor */
	public Syuser(String name, String password) {
		this.name = name;
		this.password = password;
	}

	/** full constructor */
	public Syuser(String name, String password, Timestamp createdatetime,
			Timestamp modifydatetime) {
		this.name = name;
		this.password = password;
		this.createdatetime = createdatetime;
		this.modifydatetime = modifydatetime;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public Date getCreatedatetime() {
		return createdatetime;
	}

	public void setCreatedatetime(Date createdatetime) {
		this.createdatetime = createdatetime;
	}

	public Date getModifydatetime() {
		return modifydatetime;
	}

	public void setModifydatetime(Date modifydatetime) {
		this.modifydatetime = modifydatetime;
	}

	
	

}