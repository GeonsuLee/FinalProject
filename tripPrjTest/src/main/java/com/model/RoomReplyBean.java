package com.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("roomReply")
public class RoomReplyBean {
	private int room_reply_id;
	private String reply_content;
	private Date reply_reg;
	private int room_rev_id;
	private String id;	
	private String userphoto;

}
