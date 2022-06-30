package com.model;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("placeqna")
public class PlaceQnaBean {

	private int place_qna_id;
	private String qna_title;
	private String qna_content;
	private int qna_readcnt;
	private Timestamp qna_reg;
	private int place_id;
	private String id;
}
