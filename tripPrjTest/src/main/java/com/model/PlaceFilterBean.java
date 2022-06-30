package com.model;

import java.util.List;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("placeFilter")
public class PlaceFilterBean {
	private String city;
	private String district;
	private List<String> act;
	private List<String> type;
	private String rate;
	private int page;
}
