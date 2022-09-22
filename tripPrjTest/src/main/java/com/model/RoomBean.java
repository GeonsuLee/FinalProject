package com.model;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("room")
public class RoomBean {
	private int room_id;
	private String room_name;
	private String room_content;
	private String room_photo;
	private String room_addr;
	private String room_tel;
	private String room_option;
	private String room_type;
	private String room_star;
	private int room_cost;
	private double room_rate;
	private String admin_id;
}
