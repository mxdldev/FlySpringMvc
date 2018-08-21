package com.zjx.model;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.zjx.util.JsonDateSerializer;

/**
 * Article entity. @author MyEclipse Persistence Tools
 */

public class Article implements java.io.Serializable {

	// Fields

	private Integer artid;
	private String title;
	private String content;
	private Date regtime;

	// Constructors

	/** default constructor */
	public Article() {
	}

	/** full constructor */
	public Article(String title, String content, Date regtime) {
		this.title = title;
		this.content = content;
		this.regtime = regtime;
	}

	// Property accessors

	public Integer getArtid() {
		return this.artid;
	}

	public void setArtid(Integer artid) {
		this.artid = artid;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	@JsonSerialize(using = JsonDateSerializer.class)
	public Date getRegtime() {
		return this.regtime;
	}

	public void setRegtime(Date regtime) {
		this.regtime = regtime;
	}

}