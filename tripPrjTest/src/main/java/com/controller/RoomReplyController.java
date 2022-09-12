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

import com.model.MemberBean;
import com.model.PlaceReplyBean;
import com.model.PlaceReviewBean;
import com.model.RoomReplyBean;
import com.model.RoomReviewBean;
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
	
	
	// 숙박 댓글 작성
	@RequestMapping("roomReplyWrite")
	public String placeReplyWrite(@RequestParam("room_rev_id") int room_rev_id, 
			@RequestParam("page") int page,
			@RequestParam("room_id") int room_id,
			Model model, RoomReplyBean roomreply, 
			HttpServletRequest request, HttpSession session) throws Exception{
				
		String id = (String) session.getAttribute("id");
		
		System.out.println("댓글작성 controller 진입");
		System.out.println("id="+id);
		System.out.println("room_id="+room_id);
		System.out.println("room_rev_id="+room_rev_id);
		
		// 회원 상세정보 구해오기
		MemberBean member = memberService.userCheck(id);
				
		// 회원 프로필 추출
		String userphoto = member.getProfile();
		System.out.println("userphoto="+userphoto);

		// 회원 프로필 리뷰에 저장
		roomreply.setUserphoto(userphoto);

		
		roomreply.setId(id);
		
		roomReplyService.insertReply(roomreply);
		
		return "redirect:/roomDetail?room_id=" + room_id + "&page=" + page + "&state=cont";
	}
	
	// 숙박 댓글 삭제
	@RequestMapping("roomReplyDelete")
	public String roomReplyListDelete(@RequestParam("page") int page,
			@RequestParam("room_id") int room_id,
			@RequestParam("room_reply_id") int room_reply_id,
			Model model) throws Exception{
		
		System.out.println("숙박댓글 삭제 컨트롤러 진입");
		roomReplyService.replyDelete(room_reply_id);
		
		System.out.println("숙박댓글 삭제 완료");
		
		return "redirect:/roomDetail?room_id="+room_id+"&page="+page+"&state=cont";
	}
	
	
	// 댓글 리스트
		@RequestMapping("roomReplyList")
		public String placeReplyList(@RequestParam("room_rev_id") int room_rev_id,
				@RequestParam("room_id") int room_id, @RequestParam("page") int page,
				Model model, HttpServletRequest request) throws Exception{
				
			RoomReviewBean review = service.reviewDetail(room_rev_id);
						
			System.out.println("room_rev_id="+room_rev_id);
				
			List<RoomReplyBean> roomReplyList = new ArrayList<RoomReplyBean>();
				
				
			// 총 리스트 갯수
			int listCount = roomReplyService.getListCount(room_rev_id);
			System.out.println("listCount="+listCount);	
			if(listCount == 0) {
					return "room_reply/room_reply_list_result";
					
			}
			
			// food_rev_id값을 전달해서 댓글 리스트 구해오기
			roomReplyList = roomReplyService.getRoomReplyList(room_rev_id);
				
			
				
			model.addAttribute("review",review);
			model.addAttribute("roomReplyList", roomReplyList);
			model.addAttribute("listCount",listCount);
			model.addAttribute("page",page);
			model.addAttribute("room_rev_id",room_rev_id);
			model.addAttribute("room_id",room_id);
			
			System.out.println("roomReplyList="+roomReplyList);
			
			return "room_reply/room_reply_list";
		}
}
