package com.controller;

import java.util.ArrayList;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.service.PlaceReviewService;
import com.service.MemberService;
import com.model.PlaceReplyBean;
import com.model.PlaceReviewBean;
import com.model.MemberBean;
import com.service.PlaceReplyService;

@Controller
public class PlaceReplyController {

	@Autowired
	private PlaceReplyService placeReplyService;
	
	@Autowired
	private PlaceReviewService service;
	
	@Autowired
	private MemberService memberService;
	
	
	// 댓글 작성폼
	@RequestMapping("placeReplyWriteModal")
	public String placeReplyWriteModal(@RequestParam("place_rev_id") int place_rev_id, 
			@RequestParam("place_id") int place_id, @RequestParam("page") int page,
			Model model, HttpServletRequest request) throws Exception{
		
		System.out.println("댓글modal로 이동하는 controller 진입완료");
		System.out.println("place_rev_id="+place_rev_id);
		System.out.println("place_id="+place_id);
		System.out.println("page="+page);

		model.addAttribute("place_rev_id",place_rev_id);
		model.addAttribute("place_id",place_id);
		model.addAttribute("page",page);
		
		return "place_reply/place_reply_write_modal";

	}
	
	
	
	// 음식 댓글 작성
	@RequestMapping("placeReplyWrite")
	public String placeReplyWrite(@RequestParam("place_rev_id") int place_rev_id, 
			@RequestParam("page") int page,
			@RequestParam("place_id") int place_id,
			Model model, PlaceReplyBean placereply, 
			HttpServletRequest request, HttpSession session) throws Exception{
				
		String id = (String) session.getAttribute("id");
		
		System.out.println("댓글작성 controller 진입");
		System.out.println("id="+id);
		System.out.println("place_id="+place_id);
		System.out.println("place_rev_id="+place_rev_id);
		
		// 회원 상세정보 구해오기
		MemberBean member = memberService.userCheck(id);
				
		// 회원 프로필 추출
		String userphoto = member.getProfile();
		System.out.println("userphoto="+userphoto);

		// 회원 프로필 리뷰에 저장
		placereply.setUserphoto(userphoto);

		
		placereply.setId(id);
		
		placeReplyService.insertReply(placereply);
		
		return "redirect:/placeDetail?place_id=" + place_id + "&page=" + page + "&state=cont";
	}
	
	
	
	// 음식 댓글 삭제
	@RequestMapping("placeReplyDelete")
	public String placeReplyListDelete(@RequestParam("place_id") int place_id, 
			@RequestParam("place_reply_id") int place_reply_id, @RequestParam("page") int page,
			Model model) throws Exception{
		
		System.out.println("삭제 컨트롤러 진입");
		System.out.println("place_id="+place_id);
		System.out.println("place_reply_id="+place_reply_id);
		System.out.println("page="+page);
		placeReplyService.replyDelete(place_reply_id);
		System.out.println("댓글 삭제 완료");

		
		return "redirect:/placeDetail?place_id=" + place_id + "&page=" + page + "&state=cont";
	}
	
	
	
	// 댓글 리스트
	@RequestMapping("placeReplyList")
	public String placeReplyList(@RequestParam("place_rev_id") int place_rev_id,
			@RequestParam("place_id") int place_id, @RequestParam("page") int page,
			Model model, HttpServletRequest request) throws Exception{
			
		PlaceReviewBean review = service.reviewDetail(place_rev_id);
					
		System.out.println("place_rev_id="+place_rev_id);
			
		List<PlaceReplyBean> placeReplyList = new ArrayList<PlaceReplyBean>();
			
			
		// 총 리스트 갯수
		int listCount = placeReplyService.getListCount(place_rev_id);
		System.out.println("listCount="+listCount);	
		if(listCount == 0) {
				return "place_reply/place_reply_list_result";
				
		}
		
		// food_rev_id값을 전달해서 댓글 리스트 구해오기
		placeReplyList = placeReplyService.getPlaceReplyList(place_rev_id);
			
		
			
		model.addAttribute("review",review);
		model.addAttribute("placeReplyList", placeReplyList);
		model.addAttribute("listCount",listCount);
		model.addAttribute("page",page);
		model.addAttribute("place_rev_id",place_rev_id);
		model.addAttribute("place_id",place_id);
		
		System.out.println("placeReplyList="+placeReplyList);
		
		return "place_reply/place_reply_list";
	}
		
		
		
	// 음식 댓글 수정
	@RequestMapping("placeReplywModify")
	public String reviewModifyForm(@RequestParam("place_reply_id") int place_reply_id, 
			@RequestParam("place_id") int place_id, @RequestParam("page") int page,
			@RequestParam("reply_content") String reply_content,
			Model model, HttpServletRequest request, PlaceReplyBean replyBean,
			HttpSession session) throws Exception{
		
		System.out.println("reply modify controller진입");
		System.out.println("place_reply_id="+place_reply_id);
		System.out.println("place_id="+place_id);
		System.out.println("page="+page);
			
		PlaceReplyBean reply = placeReplyService.replyDetail(place_reply_id);

		reply.setReply_content(reply_content);
		
		placeReplyService.replyModify(replyBean);
		
		System.out.println("수정 완료");
		
		return "redirect:/placeDetail?place_id=" + place_id + "&page=" + page + "&state=cont";
	}

}	

