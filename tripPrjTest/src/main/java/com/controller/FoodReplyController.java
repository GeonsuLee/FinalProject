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


import com.service.FoodReviewService;
import com.service.MemberService;
import com.model.FoodReplyBean;
import com.model.FoodReviewBean;
import com.model.MemberBean;
import com.service.FoodReplyService;

@Controller
public class FoodReplyController {

	@Autowired
	private FoodReplyService foodReplyService;
	
	@Autowired
	private FoodReviewService service;
	
	@Autowired
	private MemberService memberService;
	
	
	// 댓글 작성폼
	@RequestMapping("foodReplyWriteModal")
	public String foodReplyWriteModal(@RequestParam("food_rev_id") int food_rev_id, 
			@RequestParam("food_id") int food_id, @RequestParam("page") int page,
			Model model, HttpServletRequest request) throws Exception{
		
		System.out.println("댓글modal로 이동하는 controller 진입완료");
		System.out.println("food_rev_id="+food_rev_id);
		System.out.println("food_id="+food_id);
		System.out.println("page="+page);

		model.addAttribute("food_rev_id",food_rev_id);
		model.addAttribute("food_id",food_id);
		model.addAttribute("page",page);
		
		return "food_reply/food_reply_write_modal";

	}
	
	
	
	// 음식 댓글 작성
	@RequestMapping("foodReplyWrite")
	public String foodReplyWrite(@RequestParam("food_rev_id") int food_rev_id, 
			@RequestParam("page") int page,
			@RequestParam("food_id") int food_id,
			Model model, FoodReplyBean foodreply, 
			HttpServletRequest request, HttpSession session) throws Exception{
				
		String id = (String) session.getAttribute("id");
		
		System.out.println("댓글작성 controller 진입");
		System.out.println("id="+id);
		System.out.println("food_id="+food_id);
		System.out.println("food_rev_id="+food_rev_id);
		
		// 회원 상세정보 구해오기
		MemberBean member = memberService.userCheck(id);
				
		// 회원 프로필 추출
		String userphoto = member.getProfile();
		System.out.println("userphoto="+userphoto);

		// 회원 프로필 리뷰에 저장
		foodreply.setUserphoto(userphoto);

		
		foodreply.setId(id);
		
		foodReplyService.insertReply(foodreply);
		
		return "redirect:/foodDetail?food_id=" + food_id + "&page=" + page + "&state=cont";
	}
	
	
	
	// 음식 댓글 삭제
	@RequestMapping("foodReplyDelete")
	public String foodReplyListDelete(@RequestParam("food_id") int food_id, 
			@RequestParam("food_reply_id") int food_reply_id, @RequestParam("page") int page,
			Model model) throws Exception{
		
		System.out.println("삭제 컨트롤러 진입");
		System.out.println("food_id="+food_id);
		System.out.println("food_reply_id="+food_reply_id);
		System.out.println("page="+page);
		foodReplyService.replyDelete(food_reply_id);
		System.out.println("댓글 삭제 완료");

		
		return "redirect:/foodDetail?food_id=" + food_id + "&page=" + page + "&state=cont";
	}
	
	
	
	// 댓글 리스트
	@RequestMapping("foodReplyList")
	public String foodReplyList(@RequestParam("food_rev_id") int food_rev_id,
			@RequestParam("food_id") int food_id, @RequestParam("page") int page,
			Model model, HttpServletRequest request) throws Exception{
			
		FoodReviewBean review = service.reviewDetail(food_rev_id);
					
		System.out.println("food_rev_id="+food_rev_id);
			
		List<FoodReplyBean> foodReplyList = new ArrayList<FoodReplyBean>();
			
			
		// 총 리스트 갯수
		int listCount = foodReplyService.getListCount(food_rev_id);
		System.out.println("listCount="+listCount);	
		if(listCount == 0) {
				return "food_reply/food_reply_list_result";
				
		}
		
		// food_rev_id값을 전달해서 댓글 리스트 구해오기
		foodReplyList = foodReplyService.getFoodReplyList(food_rev_id);
			
		
			
		model.addAttribute("review",review);
		model.addAttribute("foodReplyList", foodReplyList);
		model.addAttribute("listCount",listCount);
		model.addAttribute("page",page);
		model.addAttribute("food_rev_id",food_rev_id);
		model.addAttribute("food_id",food_id);
		
		System.out.println("foodReplyList="+foodReplyList);
		
		return "food_reply/food_reply_list";
	}
		
		
		
	// 음식 댓글 수정
	@RequestMapping("foodReplywModify")
	public String reviewModifyForm(@RequestParam("food_reply_id") int food_reply_id, 
			@RequestParam("food_id") int food_id, @RequestParam("page") int page,
			@RequestParam("reply_content") String reply_content,
			Model model, HttpServletRequest request, FoodReplyBean replyBean,
			HttpSession session) throws Exception{
		
		System.out.println("reply modify controller진입");
		System.out.println("food_reply_id="+food_reply_id);
		System.out.println("food_id="+food_id);
		System.out.println("page="+page);
			
		FoodReplyBean reply = foodReplyService.replyDetail(food_reply_id);

		reply.setReply_content(reply_content);
		
		foodReplyService.replyModify(replyBean);
		
		System.out.println("수정 완료");
		
		return "redirect:/foodDetail?food_id=" + food_id + "&page=" + page + "&state=cont";
	}

}	

