package com.controller;

import java.io.File;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model.FoodReplyBean;
import com.model.FoodReviewBean;
import com.model.FoodLikeBean;
import com.model.MemberBean;
import com.service.FoodReplyService;
import com.service.FoodReviewService;
import com.service.MemberService;

@Controller
public class FoodReviewController {
	
	@Autowired
	private FoodReviewService service;
	
	@Autowired
	private FoodReplyService foodReplyService;

	@Autowired
	private MemberService memberService;

	// 리뷰 작성 모달로 이동
	@RequestMapping(value="/foodReviewWriteModal")
	public String foodReviewWriteModal(Model model, 
			@RequestParam("food_id") int food_id, @RequestParam("page") int page) throws Exception{
		
		System.out.println("글작성 modal controller 진입");
		
		model.addAttribute("food_id", food_id);
		model.addAttribute("page", page);
		//model.addAttribute("id",id);
		
		return "food_review/food_review_write_modal";
	}
	
	
	// 리뷰 작성
	@RequestMapping("foodReviewWrite")
	public String reviewWrite(@RequestParam(value ="starpoint") double rev_rate, 
			@RequestParam("food_id") int food_id, @RequestParam("page") int page,
			MultipartHttpServletRequest mtf, Model model, HttpServletRequest request,
			FoodReviewBean foodreview, HttpSession session) throws Exception {

		//double rev_rate = Double.parseDouble("starValue");
		String id = (String) session.getAttribute("id");
		
		System.out.println("controller까지 들어옴");
		System.out.println("rev_rate="+rev_rate);
		System.out.println("page="+page);
		System.out.println("food_id="+food_id);
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
				
				return "food_review/food_review_upload_result";
				
			}else if(!file[1].equals("jpg") &&
					 !file[1].equals("gif") &&
					 !file[1].equals("png") ){
				
				result=2;
				model.addAttribute("result", result);
				
				return "food_review/food_review_upload_result";
			}
			
			System.out.println("originFileName=" + originFileName);

			String safeFile = System.currentTimeMillis() + originFileName;

			files.append(safeFile + ",");
			System.out.println("safeFile" + safeFile);

			mf.transferTo(new File(path+"/"+safeFile));
			
			}
			
		}
		
		if(size > 0) {
			foodreview.setRev_photo(files.toString());
			
		}else {
			foodreview.setRev_photo(null);

		}
			
		System.out.println("첨부파일들:"+files.toString());
			
		
		// 회원 상세정보 구해오기
		MemberBean member = memberService.userCheck(id);
		
		// 회원 프로필 추출
		String userphoto = member.getProfile();
		System.out.println("userphoto="+userphoto);

		// 회원 프로필 리뷰에 저장
		foodreview.setUserphoto(userphoto);
		
		
		foodreview.setId(id);
		foodreview.setRev_rate(rev_rate);
		service.insertReview(foodreview);
		
		
		double starAvg = service.getFoodStar(food_id);

		System.out.println("starAvg="+starAvg);
		
		System.out.println("insert 완료");

		return "redirect:/foodDetail?food_id=" + food_id + "&page=" + page + "&state=cont";

	}
	
	
	// 게시판 목록
//	@RequestMapping(value = "/foodReviewList")
//	public String list(Model model,@RequestParam("food_id") int food_id ,
//			           HttpServletRequest request) throws Exception {
//
//		System.out.println("review list controller 진입");
//		List<FoodReviewBean> foodReviewList = new ArrayList<FoodReviewBean>();
//
//		String path = request.getRealPath("upload");
//
//		System.out.println("path="+path);
//		
//		
//		
//		int page = 1;
//		int limit = 10; // 한 화면에 출력할 레코드수
//
//		if (request.getParameter("page") != null) {
//			page = Integer.parseInt(request.getParameter("page"));
//		}
//
//		// 총 리스트 수를 받아옴.
//		int listCount = service.getListCount(food_id);
//
//		// 페이지 번호(page)를 DAO클래스에게 전달한다.
//		foodReviewList = service.getFoodReviewList(page); // 리스트를 받아옴.
//
//		// 총 페이지 수.
//		int maxPage = (int) ((double) listCount / limit + 0.95); // 0.95를 더해서 올림
//																	// 처리.
//		// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
//		int startPage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
//		// 현재 페이지에 보여줄 마지막 페이지 수.(10, 20, 30 등...)
//		int endPage = maxPage;
//
//		if (endPage > startPage + 10 - 1)
//			endPage = startPage + 10 - 1;
//
//		
//		
//		model.addAttribute("page", page);
//		model.addAttribute("startPage", startPage);
//		model.addAttribute("endPage", endPage);
//		model.addAttribute("maxPage", maxPage);
//		model.addAttribute("listCount", listCount);
//		model.addAttribute("foodReviewList", foodReviewList);
//
//
//		return "redirect:/foodDetail?food_id=" + food_id + "&page=" + page + "&state=cont";
//	}
	
	
	
	
	// 리뷰 상세정보를 구해서 수정모달 페이지로 이동
	@RequestMapping(value ="/foodReviewModifyModal")
	public String modal(@RequestParam("food_rev_id") int food_rev_id, @RequestParam("food_id") int food_id, 
						@RequestParam("page") int page, Model model) throws Exception {
		
		System.out.println("수정 modal controller 진입");
		
		FoodReviewBean foodReviewDetail = service.reviewDetail(food_rev_id);
		
		model.addAttribute("foodReviewDetail", foodReviewDetail);
		model.addAttribute("food_rev_id", food_rev_id);
		model.addAttribute("food_id", food_id);
		model.addAttribute("page", page);
		
		return "food_review/food_review_modify_modal";
	}
	
	

	// 리뷰 수정
	@RequestMapping("foodReviewModify")
	public String reviewModifyForm(@RequestParam("food_rev_id") int food_rev_id, @RequestParam("food_id") int food_id,
			@RequestParam("starpoint") double rev_rate, @RequestParam("page") int page,
			MultipartHttpServletRequest mtf, Model model, HttpServletRequest request,
			FoodReviewBean foodreview, HttpSession session) throws Exception{
		
		System.out.println("review modify controller진입");
		System.out.println("rev_rate="+rev_rate);
		System.out.println("page="+page);
		System.out.println("food_id="+food_id);
		
		
		FoodReviewBean oldreview = service.reviewDetail(food_rev_id);

		
		
		System.out.println("rev_rate="+rev_rate);
		if(Math.abs(rev_rate) > 0) {
			foodreview.setRev_rate(rev_rate);
		}else {
			foodreview.setRev_rate(oldreview.getRev_rate());
		}
		
		
		List<MultipartFile> fileList = mtf.getFiles("rev_photos1");
		String path = request.getRealPath("upload");
		System.out.println("food_rev_id="+food_rev_id);
		
		foodreview.setFood_rev_id(food_rev_id);
		
		
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
					
					return "food_review/review_upload_result";
					
				}else if(!file[1].equals("jpg") &&
						 !file[1].equals("gif") &&
						 !file[1].equals("png") ){
					
					result=2;
					model.addAttribute("result", result);
					
					return "food_review/review_upload_result";
				}
				
				}
				
				
				System.out.println("originFileName=" + originFileName);

				String safeFile = System.currentTimeMillis() + originFileName;

				files.append(safeFile + ",");
				System.out.println("safeFile" + safeFile);

				mf.transferTo(new File(path+"/"+safeFile));
			} // for end
			
			
			if(size > 0) {
				foodreview.setRev_photo(files.toString());
			}else {
				foodreview.setRev_photo(oldreview.getRev_photo());
			}

	
		service.reviewModify(foodreview);
	
		
		food_id = foodreview.getFood_id();
		double starAvg = service.getFoodStar(food_id);

		System.out.println("starAvg="+starAvg);
		
		
		return "redirect:/foodDetail?food_id=" + food_id + "&page=" + page + "&state=cont";
	}
	
	
	
	// 리뷰 상세정보
	@RequestMapping(value ="/foodReviewDetail")
	public void foodReviewDetail(@RequestParam("food_rev_id") int food_rev_id, Model model) throws Exception {
		System.out.println("컨트롤러 진입");
		FoodReviewBean foodReviewDetail = service.reviewDetail(food_rev_id);
		model.addAttribute("foodReviewDetail", foodReviewDetail);
		
	}
	
	
	
	// 리뷰 삭제
	@RequestMapping(value ="/foodReviewDelete")
	public String foodReviewDelete(@RequestParam("food_rev_id") int food_rev_id, @RequestParam("food_id") int food_id,
								   @RequestParam("page") int page,
								  Model model) throws Exception{
		System.out.println("delete controller 진입");

		service.reviewDelete(food_rev_id);
		System.out.println("삭제완료");

		
		double starAvg = service.getFoodStar(food_id);

		System.out.println("starAvg="+starAvg);
		
		return "redirect:/foodDetail?food_id=" + food_id + "&page=" + page + "&state=cont";
	}
	
	// 리뷰 좋아요
	@RequestMapping(value="/foodReviewLike")
	public String foodReviewLike(@RequestParam("food_rev_id") int food_rev_id, @RequestParam("food_id") int food_id,
								 @RequestParam("page") int page, HttpSession session, @RequestParam("id") String id,
								 FoodLikeBean likebean) throws Exception{
		System.out.println("좋아요 증가 컨트롤러 진입");
//		String id = (String) session.getAttribute("id");

		System.out.println("food_rev_id="+food_rev_id);
		System.out.println("food_id="+food_id);
		System.out.println("page="+page);
		System.out.println("id="+id);
		
		// 리뷰에 좋아요컬럼(rev_like) 1증가
		service.foodLikeUpdate(food_rev_id);
		System.out.println("좋아요 +1 증가 완료");
		
		// 리뷰좋아요 테이블에 데이터 저장
		likebean.setFood_rev_id(food_rev_id);
		likebean.setId(id);
		System.out.println("id , food_rev_id Bean에 저장완료");
		service.foodLikeInsert(likebean);
		
		System.out.println("좋아요 완료");
		
		return "redirect:/foodDetail?food_id=" + food_id + "&page=" + page + "&state=cont";
	}
	

}
