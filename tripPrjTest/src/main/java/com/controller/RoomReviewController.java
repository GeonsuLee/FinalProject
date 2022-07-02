package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.service.MemberService;
import com.service.RoomReplyService;
import com.service.RoomReviewService;

@Controller
public class RoomReviewController {

	@Autowired
	private RoomReviewService service;
	
	@Autowired
	private RoomReplyService roomReplyService;
	
	@Autowired
	private MemberService memberService;
	
	// 리뷰 작성 모달로 이동
	@RequestMapping("/roomReviewWriteModal")
	public String roomReviewWriteModal(Model model,
			@RequestParam("room_id") int room_id, @RequestParam("page") int page) throws Exception{
		
		System.out.println("글작성 모달로 이동하는 컨트롤러 진입");
		
		model.addAttribute("room_id",room_id);
		model.addAttribute("page",page);
		
		return "room_review/room_review_write_modal";
	}
	
}
