package com.controller;

import java.io.File;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model.MemberBean;
import com.model.RoomReviewBean;
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
	
	// 리뷰 작성
		@RequestMapping("roomReviewWrite")
		public String reviewWrite(@RequestParam(value ="starpoint") double rev_rate, 
				@RequestParam("room_id") int room_id, @RequestParam("page") int page,
				MultipartHttpServletRequest mtf, Model model, HttpServletRequest request,
				RoomReviewBean roomreview, HttpSession session) throws Exception {

			//double rev_rate = Double.parseDouble("starValue");
			String id = (String) session.getAttribute("id");
			
			System.out.println("controller까지 들어옴");
			System.out.println("rev_rate="+rev_rate);
			System.out.println("page="+page);
			System.out.println("room_id="+room_id);
			System.out.println("id="+id);
			
			List<MultipartFile> fileList = mtf.getFiles("rev_photos");

			String path = request.getRealPath("upload");
			System.out.println("path=" + path);

			StringBuilder files = new StringBuilder();
			
			int size = 0;
			
			for (MultipartFile mf : fileList) {

				int result=0;
				size = (int) mf.getSize();
				
				if(size > 0) {
				
				String originFileName = mf.getOriginalFilename();
				
				String file[] = new String[2];
				StringTokenizer st = new StringTokenizer(originFileName, ".");
				file[0] = st.nextToken();		// 파일명		Koala
				file[1] = st.nextToken();		// 확장자	    jpg
				
				if(size > 10000000){				// 100KB
					result=1;
					model.addAttribute("result", result);
					
					return "room_review/room_review_upload_result";
					
				}else if(!file[1].equals("jpg") &&
						 !file[1].equals("gif") &&
						 !file[1].equals("png") ){
					
					result=2;
					model.addAttribute("result", result);
					
					return "room_review/room_review_upload_result";
				}
				
				System.out.println("originFileName=" + originFileName);

				String safeFile = System.currentTimeMillis() + originFileName;

				files.append(safeFile + ",");
				System.out.println("safeFile" + safeFile);

				mf.transferTo(new File(path+"/"+safeFile));
				
				}
				
			}
			
			if(size > 0) {
				roomreview.setRev_photo(files.toString());
				
			}else {
				roomreview.setRev_photo(null);

			}
				
			System.out.println("첨부파일들:"+files.toString());
				
			
			// 회원 상세정보 구해오기
			MemberBean member = memberService.userCheck(id);
			
			// 회원 프로필 추출
			String userphoto = member.getProfile();
			System.out.println("userphoto="+userphoto);

			// 회원 프로필 리뷰에 저장
			roomreview.setUserphoto(userphoto);
			
			
			roomreview.setId(id);
			roomreview.setRev_rate(rev_rate);
			service.insertReview(roomreview);
			
			
			double starAvg = service.getRoomStar(room_id);

			System.out.println("starAvg="+starAvg);
			
			System.out.println("insert 완료");

			return "redirect:/roomDetail?room_id=" + room_id + "&page=" + page + "&state=cont";

		}
		
		
		// 리뷰 상세정보를 구해서 수정모달 페이지로 이동
		@RequestMapping(value ="/roomReviewModifyModal")
		public String modal(@RequestParam("room_rev_id") int room_rev_id, @RequestParam("room_id") int room_id, 
							@RequestParam("page") int page, Model model) throws Exception {
			
			System.out.println("수정 modal controller 진입");
			
			RoomReviewBean roomReviewDetail = service.reviewDetail(room_rev_id);
			
			model.addAttribute("roomReviewDetail", roomReviewDetail);
			model.addAttribute("room_rev_id", room_rev_id);
			model.addAttribute("room_id", room_id);
			model.addAttribute("page", page);
			
			return "room_review/room_review_modify_modal";
		}
		
		

		// 리뷰 수정
		@RequestMapping("roomReviewModify")
		public String reviewModifyForm(@RequestParam("room_rev_id") int room_rev_id, @RequestParam("room_id") int room_id,
				@RequestParam("starpoint") double rev_rate, @RequestParam("page") int page,
				MultipartHttpServletRequest mtf, Model model, HttpServletRequest request,
				RoomReviewBean roomreview, HttpSession session) throws Exception{
			
			System.out.println("room review modify controller진입");
			System.out.println("rev_rate="+rev_rate);
			System.out.println("page="+page);
			System.out.println("room_id="+room_id);
			
			
			RoomReviewBean oldreview = service.reviewDetail(room_rev_id);

			
			
			System.out.println("rev_rate="+rev_rate);
			if(Math.abs(rev_rate) > 0) {
				roomreview.setRev_rate(rev_rate);
			}else {
				roomreview.setRev_rate(oldreview.getRev_rate());
			}
			
			
			List<MultipartFile> fileList = mtf.getFiles("rev_photos1");
			String path = request.getRealPath("upload");
			System.out.println("room_rev_id="+room_rev_id);
			
			roomreview.setRoom_rev_id(room_rev_id);
			
			
				StringBuilder files = new StringBuilder();
				int size = 0;			
				
				for (MultipartFile mf : fileList) {
					int result=0;
					
					String originFileName = mf.getOriginalFilename();
					size = (int) mf.getSize();
					
					
					if(size > 0) {
						
					String file[] = new String[2];
					StringTokenizer st = new StringTokenizer(originFileName, ".");
					file[0] = st.nextToken();		// 파일명		Koala
					file[1] = st.nextToken();		// 확장자	    jpg
					
					if(size > 10000000){				// 100KB
					
						result=1;
						model.addAttribute("result", result);
						
						return "room_review/review_upload_result";
						
					}else if(!file[1].equals("jpg") &&
							 !file[1].equals("gif") &&
							 !file[1].equals("png") ){
						
						result=2;
						model.addAttribute("result", result);
						
						return "room_review/review_upload_result";
					}
					
					}
					
					
					System.out.println("originFileName=" + originFileName);

					String safeFile = System.currentTimeMillis() + originFileName;

					files.append(safeFile + ",");
					System.out.println("safeFile" + safeFile);

					mf.transferTo(new File(path+"/"+safeFile));
				} // for end
				
				
				if(size > 0) {
					roomreview.setRev_photo(files.toString());
				}else {
					roomreview.setRev_photo(oldreview.getRev_photo());
				}

		
			service.reviewModify(roomreview);
		
			
			room_id = roomreview.getRoom_id();
			double starAvg = service.getRoomStar(room_id);

			System.out.println("starAvg="+starAvg);
			
			
			return "redirect:/roomDetail?room_id=" + room_id + "&page=" + page + "&state=cont";
		}
		
		
		
		// 리뷰 상세정보
		@RequestMapping(value ="/roomReviewDetail")
		public void roomReviewDetail(@RequestParam("room_rev_id") int room_rev_id, Model model) throws Exception {
			System.out.println("컨트롤러 진입");
			RoomReviewBean roomReviewDetail = service.reviewDetail(room_rev_id);
			model.addAttribute("roomReviewDetail", roomReviewDetail);
			
		}
		
		
		
		// 리뷰 삭제
		@RequestMapping(value ="/roomReviewDelete")
		public String roomReviewDelete(@RequestParam("room_rev_id") int room_rev_id, @RequestParam("room_id") int room_id,
									   @RequestParam("page") int page,
									  Model model) throws Exception{
			System.out.println("delete controller 진입");

			service.reviewDelete(room_rev_id);
			System.out.println("삭제완료");

			
			double starAvg = service.getRoomStar(room_id);

			System.out.println("starAvg="+starAvg);
			
			return "redirect:/roomDetail?room_id=" + room_id + "&page=" + page + "&state=cont";
		}
		
	
}
