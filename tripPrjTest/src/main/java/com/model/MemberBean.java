package com.model;

import java.util.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("member")
public class MemberBean {
	private String id;
	private String pw;
	private String name;
	private String tel;
	private String mail;
	private String post;
	private String addr1;
	private String addr2;
	private Date reg;
	private String profile;
	private String quit;
}
