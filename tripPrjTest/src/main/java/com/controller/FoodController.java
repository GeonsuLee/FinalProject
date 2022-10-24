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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model.FoodBean;
import com.model.FoodBookmarkBean;
import com.model.FoodLikeBean;
import com.model.FoodReviewBean;
import com.model.PlaceBean;
import com.service.FoodReplyService;
import com.service.FoodReviewService;
import com.service.FoodService;
import com.service.MemberService;

@Controller
public class FoodController {

	@Autowired
	private FoodService service;
	
	@Autowired
	private FoodReviewService reviewService;
	
	@Autowired
	private MemberService memService;
	
	@Autowired
	private FoodReplyService foodReplyService;

	@RequestMapping("foodList")
	public String foodList(Model model, HttpServletRequest request) throws Exception {
		List<FoodBean> foodList = new ArrayList<FoodBean>();

		int page = 1;
		int limit = 5;

		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		int listCount = service.getCount();
		foodList = service.getList(page);

		int pageCount = listCount / limit + ((listCount % limit == 0) ? 0 : 1);

		int startPage = ((page - 1) / 10) * limit + 1;
		int endPage = startPage + 10 - 1;

		if (endPage > pageCount)
			endPage = pageCount;

		model.addAttribute("page", page);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("listCount", listCount);
		model.addAttribute("foodList", foodList);

		return "food/food_list";
	}
	
	/* 게시판 글쓰기 폼 */
	@RequestMapping("foodWriteForm")
	public String write() {

		return "food/food_writeform";
	}

	/* 게시판 저장 */
	@RequestMapping(value = "foodWrite")
	public String foodWrite(MultipartHttpServletRequest mtf, Model model, HttpServletRequest request, FoodBean food,
			HttpSession session) throws Exception {

		String hour = "오전 " + request.getParameter("open") + " ~ 오후 " + request.getParameter("close");
		food.setFood_hour(hour);

		List<MultipartFile> fileList = mtf.getFiles("foodPhotos");
		System.out.println("controller 진입");
		String path = request.getRealPath("upload");
		System.out.println("path=" + path);

		StringBuilder files = new StringBuilder();
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename();

			String file[] = new String[2];
			StringTokenizer st = new StringTokenizer(originFileName, ".");
			file[0] = st.nextToken(); // 파일명 Koala
			file[1] = st.nextToken(); // 확장자 jpg

			int result = 0;
			int size = (int) mf.getSize();
			if (size > 10000000) { // 100KB

				result = 1;
				model.addAttribute("result", result);

				return "food/food_upload_result";

			} else if (!file[1].equals("jpg") &&
					   !file[1].equals("gif") &&
					   !file[1].equals("jpeg")&&
					   !file[1].equals("png")) {

				result = 2;
				model.addAttribute("result", result);

				return "food/food_upload_result";
			}

			System.out.println("originFileName=" + originFileName);

			String safeFile = System.currentTimeMillis() + originFileName;

			files.append(safeFile + ",");
			System.out.println("safeFile:" + safeFile);

			mf.transferTo(new File(path + "/" + safeFile));
			System.out.println("첨부파일들:" + files.toString());
		}

		System.out.println("첨부파일들:" + files.toString());

		String id = (String) session.getAttribute("id");
		food.setFood_photo(files.toString());

		System.out.println("insert전");
		service.insert(food);
		System.out.println("insert완료");

		return "redirect:/foodList";
	}
	
	/* 상세 페이지, 수정 페이지, 삭제 페이지 */
	@RequestMapping(value = "foodDetail")
	public String foodDetail(@RequestParam("food_id") int food_id,
							 @RequestParam("page") int page,
							 @RequestParam("state") String state,
							 FoodBookmarkBean foodmark,
							 FoodLikeBean foodLike,
							 HttpSession session,
							 HttpServletRequest request,
							 Model model) throws Exception {
		
		String id = (String) session.getAttribute("id");
		foodmark.setId(id);
		foodmark.setFood_id(food_id);
		
		System.out.println(id);
		System.out.println(food_id);
		
		int markCount = service.getMarkCount(foodmark);
		System.out.println(markCount);
		boolean isMark = false;
		if (markCount == 1) {
			isMark = true;
		} else if(markCount == 0) {
			isMark = false;
		}
		
		List<PlaceBean> queryList = new ArrayList<PlaceBean>();

		FoodBean food = service.detail(food_id);
		
		

		double starAvg = 0;
		
		// 리뷰 리스트 객체 선언
		List<FoodReviewBean> reviewlist = new ArrayList<FoodReviewBean>();

		// 리뷰 개수 구해오기
		int listCount = reviewService.getListCount(food_id);
		
		if(listCount > 0) {
			
			// 별점 평균 구해오기와서 starAvg에 저장
			starAvg = reviewService.getFoodStar(food_id);
			
		}else {
			listCount = 0;
		}
		
		// 리뷰 별점 평균을 저장 및 업데이트
		food.setFood_rate(starAvg);
		service.starUpdata(food_id);
		

		String[] addr = food.getFood_addr().split(" ");
		String city = addr[1];
		String[] hour = food.getFood_hour().split(" ");
		String open = hour[1];
		String close = hour[4];
		System.out.println(city);
		queryList = service.getQueryList(city);
		System.out.println(queryList);
		
		model.addAttribute("food", food);
		model.addAttribute("page", page);

		if (state.equals("cont")) {// 내용보기일때
			

			String foodDetail = food.getFood_content().replace("\n", "<br/>");
			// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
			model.addAttribute("foodDetail", foodDetail);
			model.addAttribute("queryList", queryList);
			model.addAttribute("city", city);
			model.addAttribute("isMark", isMark);
			model.addAttribute("food_id", food_id);
			
				
			// 리뷰 리스트 구해오기
			reviewlist = reviewService.getFoodReviewList(food_id);
			food.setFood_rate(food_id);

			int limit = 10; // 한 화면에 출력할 레코드수
			
			
			if (request.getParameter("page") == null) {
				page = 1;
			}
			
			
			// 총 리스트 수를 받아옴.
			int relistCount = reviewService.getListCount(food_id);
			// 총 페이지 수.
			int maxPage = (int) ((double) relistCount / limit + 0.95); // 0.95를 더해서 올림
																		// 처리.
			// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
			int startPage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
			// 현재 페이지에 보여줄 마지막 페이지 수.(10, 20, 30 등...)
			int endPage = maxPage;
	
			if (endPage > startPage + 10 - 1)
				endPage = startPage + 10 - 1;

			model.addAttribute("page", page);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("maxPage", maxPage);
			
			
			
			
			
//			if(id != null) {
//				
//			// 좋아요 리스트 구해오기
//			List<FoodLikeBean> reviewLike = new ArrayList<FoodLikeBean>();
//			reviewLike = reviewService.getFoodLikeList(id);
//			
//			// 좋아요 food_rev_id 값 구해오기
////			int food_rev_id = reviewService.getFoodRevId(id);
//			
////			model.addAttribute("food_rev_id", food_rev_id);
//			model.addAttribute("reviewLike", reviewLike);
//			System.out.println("reviewLike="+reviewLike);
//
//			}
			
			
			
			// view페이지에 공유
			model.addAttribute("reviewlist", reviewlist);
			model.addAttribute("starAvg", starAvg);
			model.addAttribute("listCount", listCount);
			
	
			return "food/food_detail"; // 내용보기 페이지 설정

		} else if (state.equals("modify")) {// 수정폼
			model.addAttribute("open", open);
			model.addAttribute("close", close);
			return "food/food_modifyform";
		}
		
		return null;
	}

	/* 글 수정 */
	@RequestMapping(value = "foodModify", method = RequestMethod.POST)
	public String foodModify(MultipartHttpServletRequest mtf, HttpServletRequest request,
							 @ModelAttribute FoodBean foodBean, 
							 @RequestParam("page") String page, 
							 Model model, HttpSession session) throws Exception {

		String hour = "오전 " + request.getParameter("open") + " ~ 오후 " + request.getParameter("close");
		foodBean.setFood_hour(hour);

		List<MultipartFile> fileList = mtf.getFiles("food_photos");
		System.out.println("controller 진입");
		String path = request.getRealPath("upload");
		System.out.println("path=" + path);

		StringBuilder files = new StringBuilder();
		int size = 0;
		
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename();
			
			int result = 0;
			size = (int) mf.getSize();
			
			if (size > 0) {
			String file[] = new String[2];
			StringTokenizer st = new StringTokenizer(originFileName, ".");
			file[0] = st.nextToken(); // 파일명 Koala
			file[1] = st.nextToken(); // 확장자 jpg
			
			if (size > 10000000) { // 100KB

				result = 1;
				
				model.addAttribute("result", result);
				return "food/food_upload_result";

			} else if (!file[1].equals("jpg") && 
					   !file[1].equals("gif") && 
					   !file[1].equals("jpeg")&&
					   !file[1].equals("png")) {

				result = 2;
				model.addAttribute("result", result);

				return "food/food_upload_result";
			}

			System.out.println("originFileName=" + originFileName);

			String safeFile = System.currentTimeMillis() + originFileName;

			files.append(safeFile + ",");
			System.out.println("safeFile:" + safeFile);

			mf.transferTo(new File(path + "/" + safeFile));
			
			} // size() end
		}
		System.out.println("첨부파일들:" + files.toString());

		String id = (String) session.getAttribute("id");
		
		FoodBean old = service.detail(foodBean.getFood_id());
		if (size > 0) {
			foodBean.setFood_photo(files.toString());
		} else {
			foodBean.setFood_photo(old.getFood_photo());
		}
		
		service.modify(foodBean);

		return "redirect:/foodDetail?food_id=" + foodBean.getFood_id() + "&page=" + page + "&state=cont";
	}

	/* 게시판 삭제 */
	@RequestMapping(value = "foodDelete", method = RequestMethod.POST)
	public String foodDelete(@RequestParam("food_id") int food_id,
							 @RequestParam("page") int page, 
							 Model model) throws Exception {

		FoodBean food = service.detail(food_id);

		service.delete(food_id);

		return "redirect:/foodList?page=" + page;
	}
	
	@RequestMapping("addFoodMark")
	public String addFoodMark(@RequestParam("food_id") int food_id,
			 			  	  @RequestParam("page") String page,
			 			  	  @RequestParam("state") String state,
			 			  	  Model model, FoodBookmarkBean foodmark,
			 			  	  HttpSession session) throws Exception {
		System.out.println("북마크 클릭");
		
		String id = (String) session.getAttribute("id");
		foodmark.setId(id);
		foodmark.setFood_id(food_id);
		System.out.println(id);
		System.out.println(food_id);
		int markCount = service.getMarkCount(foodmark);
		System.out.println(markCount);
		
		if (markCount == 0) {
			service.addMark(foodmark);
		} else {
			service.delMark(foodmark);
		}
		
		boolean isMark = false;
		if (markCount == 1) {
			isMark = false;
		} else if(markCount == 0) {
			isMark = true;
		}
		
		List<FoodBean> queryList = new ArrayList<FoodBean>();
		FoodBean food = service.detail(food_id);

		String[] addr = food.getFood_addr().split(" ");
		String city = addr[1];

		model.addAttribute("food", food);
		model.addAttribute("page", page);

		// 내용보기일때

		String foodDetail = food.getFood_content().replace("\n", "<br/>");
			// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
		model.addAttribute("foodDetail", foodDetail);
		model.addAttribute("queryList", queryList);
		model.addAttribute("city", city);
		model.addAttribute("isMark", isMark);
		
		return "food/food_detail"; // 내용보기 페이지 설정
	}

}
