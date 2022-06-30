package com.model;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("foodqna")
public class FoodQnaBean {

	private int food_qna_id;
	private String qna_title;
	private String qna_content;
	private int qna_readcnt;
	private Timestamp qna_reg;
	private int food_id;
	private String id;
}
