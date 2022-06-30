package com.model;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("roombookmark")
public class RoomBookmarkBean {
	private int room_mark_id;
	private int room_id;
	private String id;
	private String room_name;
	private String room_photo;
	private String room_addr;
	private String room_tel;
	private String room_type;
	private String room_star;
	private String room_cost;
	private String room_rate;
}
