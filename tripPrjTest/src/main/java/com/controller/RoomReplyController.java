package com.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.service.MemberService;
import com.service.RoomReviewService;
import com.service.RoomReplyService;

@Controller
public class RoomReplyController {
	
	@Autowired
	private RoomReplyService roomReplyService;
	
	@Autowired
	private RoomReviewService service;
	
	@Autowired
	private MemberService memberService;
	
	// 댓글 작성폼
	@RequestMapping("roomReplyWriteModel")
	public String roomReplyWriteModel(@RequestParam("room_rev_id") int room_rev_id,
			@RequestParam("room_id") int room_id, @RequestParam("page") int page,
			Model model, HttpServletRequest request) throws Exception{
		
		System.out.println("숙박 댓글 모달로 이동하는 컨트롤러 진입");
		System.out.println("room_rev_id="+room_rev_id);
		System.out.println("room_id="+room_id);
		
		model.addAttribute("room_rev_id",room_rev_id);
		model.addAttribute("room_id",room_id);
		model.addAttribute("page", page);
		
		return "room_reply/room_reply_write_modal";
	}
	
}
