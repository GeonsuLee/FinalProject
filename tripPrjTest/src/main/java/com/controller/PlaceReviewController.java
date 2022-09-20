package com.controller;

import java.io.File;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model.MemberBean;
import com.model.PlaceReviewBean;
import com.service.MemberService;
import com.service.PlaceReplyService;
import com.service.PlaceReviewService;

@Controller
public class PlaceReviewController {

	@Autowired
	private PlaceReviewService service;
	
	@Autowired
	private PlaceReplyService placeReplyService;
	
	@Autowired
	private MemberService memberService;
	
	// 리뷰 작성 모달로 이동
	@RequestMapping(value="/placeReviewWriteModal")
	public String placeReviewModal(Model model, @RequestParam("place_id") int place_id,
			@RequestParam("page") int page) throws Exception{
		
		System.out.println("글작성 modal controller 진입");

		model.addAttribute("place_id", place_id);
		model.addAttribute("page", page);
		
		System.out.println("공유 완료");
		
		return "place_review/place_review_write_modal";
	}
	
	
	// 리뷰 작성
	@RequestMapping(value="/placeReviewWrite")
	public String reviewWrite(@RequestParam(value ="starpoint") double rev_rate, 
			@RequestParam("place_id") int place_id, @RequestParam("page") int page,
			MultipartHttpServletRequest mtf, Model model, HttpServletRequest request,
			PlaceReviewBean placereview, HttpSession session) throws Exception {

		//double rev_rate = Double.parseDouble("starValue");
		String id = (String) session.getAttribute("id");
		
		System.out.println("controller까지 들어옴");
		System.out.println("rev_rate="+rev_rate);
		System.out.println("page="+page);
		System.out.println("place_id="+place_id);
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
				
				return "place_review/place_review_upload_result";
				
			}else if(!file[1].equals("jpg") &&
					 !file[1].equals("gif") &&
					 !file[1].equals("png") ){
				
				result=2;
				model.addAttribute("result", result);
				
				return "place_review/place_review_upload_result";
			}
			
			System.out.println("originFileName=" + originFileName);

			String safeFile = System.currentTimeMillis() + originFileName;

			files.append(safeFile + ",");
			System.out.println("safeFile" + safeFile);

			mf.transferTo(new File(path+"/"+safeFile));
			
			}
			
		}
		
		if(size > 0) {
			placereview.setRev_photo(files.toString());
			
		}else {
			placereview.setRev_photo(null);

		}
			
		System.out.println("첨부파일들:"+files.toString());
			
		
		// 회원 상세정보 구해오기
		MemberBean member = memberService.userCheck(id);
		
		// 회원 프로필 추출
		String userphoto = member.getProfile();
		System.out.println("userphoto="+userphoto);

		// 회원 프로필 리뷰에 저장
		placereview.setUserphoto(userphoto);
		
		
		
		
		placereview.setId(id);
		placereview.setRev_rate(rev_rate);
		service.insertReview(placereview);
		
		
		double starAvg = service.getPlaceStar(place_id);

		System.out.println("starAvg="+starAvg);
		
		System.out.println("insert 완료");

		return "redirect:/placeDetail?place_id=" + place_id + "&page=" + page + "&state=cont";

	}
	
	
	// 리뷰 상세정보를 구해서 수정모달 페이지로 이동
		@RequestMapping(value ="/placeReviewModifyModal")
		public String modal(@RequestParam("place_rev_id") int place_rev_id, @RequestParam("place_id") int place_id, 
							@RequestParam("page") int page, Model model) throws Exception {
			
			System.out.println("place 수정 modal controller 진입");
			
			PlaceReviewBean placeReviewDetail = service.reviewDetail(place_rev_id);
			
			model.addAttribute("placeReviewDetail", placeReviewDetail);
			model.addAttribute("place_rev_id", place_rev_id);
			model.addAttribute("place_id", place_id);
			model.addAttribute("page", page);
			
			return "place_review/place_review_modify_modal";
		}
		
		

		// 리뷰 수정
		@RequestMapping("placeReviewModify")
		public String reviewModifyForm(@RequestParam("place_rev_id") int place_rev_id, @RequestParam("place_id") int place_id,
				@RequestParam("starpoint") double rev_rate, @RequestParam("page") int page,
				MultipartHttpServletRequest mtf, Model model, HttpServletRequest request,
				PlaceReviewBean placereview, HttpSession session) throws Exception{
			
			System.out.println("review modify controller진입");
			System.out.println("rev_rate="+rev_rate);
			System.out.println("page="+page);
			System.out.println("place_id="+place_id);
			
			
			PlaceReviewBean oldreview = service.reviewDetail(place_rev_id);

			
			
			System.out.println("rev_rate="+rev_rate);
			if(Math.abs(rev_rate) > 0) {
				placereview.setRev_rate(rev_rate);
			}else {
				placereview.setRev_rate(oldreview.getRev_rate());
			}
			
			
			List<MultipartFile> fileList = mtf.getFiles("rev_photos1");
			String path = request.getRealPath("upload");
			System.out.println("place_rev_id="+place_rev_id);
			
			placereview.setPlace_rev_id(place_rev_id);
			
			
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
						
						return "place_review/review_upload_result";
						
					}else if(!file[1].equals("jpg") &&
							 !file[1].equals("gif") &&
							 !file[1].equals("png") ){
						
						result=2;
						model.addAttribute("result", result);
						
						return "place_review/review_upload_result";
					}
					
					}
					
					
					System.out.println("originFileName=" + originFileName);

					String safeFile = System.currentTimeMillis() + originFileName;

					files.append(safeFile + ",");
					System.out.println("safeFile" + safeFile);

					mf.transferTo(new File(path+"/"+safeFile));
				} // for end
				
				
				if(size > 0) {
					placereview.setRev_photo(files.toString());
				}else {
					placereview.setRev_photo(oldreview.getRev_photo());
				}

		
			service.reviewModify(placereview);
		
			
			place_id = placereview.getPlace_id();
			double starAvg = service.getPlaceStar(place_id);

			System.out.println("starAvg="+starAvg);
			
			
			return "redirect:/placeDetail?place_id=" + place_id + "&page=" + page + "&state=cont";
		}
		
		// 리뷰 상세정보
		@RequestMapping(value ="/placeReviewDetail")
		public void placeReviewDetail(@RequestParam("place_rev_id") int place_rev_id, Model model) throws Exception {
			System.out.println("컨트롤러 진입");
			PlaceReviewBean placeReviewDetail = service.reviewDetail(place_rev_id);
			model.addAttribute("placeReviewDetail", placeReviewDetail);
			
		}
		
		
		
		// 리뷰 삭제
		@RequestMapping(value ="/placeReviewDelete")
		public String foodReviewDelete(@RequestParam("place_rev_id") int place_rev_id, @RequestParam("place_id") int place_id,
									   @RequestParam("page") int page,
									  Model model) throws Exception{
			System.out.println("place delete controller 진입");

			service.reviewDelete(place_rev_id);
			
			double starAvg = service.getPlaceStar(place_id);

			System.out.println("삭제완료");

			

	//		System.out.println("starAvg="+starAvg);
			
			return "redirect:/placeDetail?place_id=" + place_id + "&page=" + page + "&state=cont";
		}
		
		
	
}
