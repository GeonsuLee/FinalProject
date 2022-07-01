package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.service.MemberService;
import com.service.PlaceReplyService;
import com.service.PlaceReviewService;

@Controller
public class PlaceReviewController {

	@Autowired
	private PlaceReviewService serviec;
	
	@Autowired
	private PlaceReplyService placeReplyService;
	
	@Autowired
	private MemberService memberService;
	
	// 리뷰 작성 모달로 이동
	@RequestMapping(value="/placeReviewWriteModal")
	public String placeReviewModal(Model model, @RequestParam("place_id") int place_id,
			@RequestParam("page") int page) throws Exception{
		
		System.out.println("컨트롤러 진입(글작성 모달로이동)");

		model.addAttribute("place_id", place_id);
		model.addAttribute("page", page);
		
		return "place_review/place_review_write_modal";
	}
	
	
	
}
