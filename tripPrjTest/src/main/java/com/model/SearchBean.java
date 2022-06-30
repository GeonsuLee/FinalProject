package com.model;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("search")
public class SearchBean {
	/*
	 * private String name; private String photo; private String addr; private
	 * String tel;
	 */
	private String input;	
	private int page;
}
