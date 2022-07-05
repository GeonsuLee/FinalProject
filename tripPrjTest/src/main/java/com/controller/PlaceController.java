package com.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.model.FoodLikeBean;
import com.model.FoodReviewBean;
import com.model.PlaceBean;
import com.model.PlaceBookmarkBean;
import com.model.PlaceFilterBean;
import com.model.PlaceReviewBean;
import com.model.RoomBean;
import com.model.RoomFilterBean;
import com.service.PlaceReviewService;
import com.service.PlaceService;

@Controller
public class PlaceController {

	@Autowired
	private PlaceService service;
	
	@Autowired
	private PlaceReviewService reviewService;
	

	@RequestMapping("placeList")
	public String placeList(Model model, HttpServletRequest request) throws Exception {
		List<PlaceBean> placeList = new ArrayList<PlaceBean>();

		int page = 1;
		int limit = 5;

		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		int listCount = service.getCount();
		placeList = service.getList(page);

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
		model.addAttribute("placeList", placeList);

		return "place/place_list";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("placeFilter")
	public String roomFilter(@RequestParam HashMap<String, String> map, PlaceFilterBean placeFilter, Model model,
			HttpServletRequest request) throws Exception {
		
		Map<String, ?> fmIn = RequestContextUtils.getInputFlashMap(request);
		if (fmIn != null) {
			map = (HashMap<String, String>) fmIn.get("map");
		}
		System.out.println(map);

		ArrayList<String> act = new ArrayList<>();
		ArrayList<String> type = new ArrayList<>();
		for (String key : map.keySet()) {
			if (key.contains("city"))
				placeFilter.setCity(map.get("city"));
			if (key.contains("district"))
				placeFilter.setDistrict(map.get("district"));
			if (key.contains("rate"))
				placeFilter.setRate(map.get("rate"));
			
			if (key.contains("act"))
				act.add(map.get(key));
			if (key.contains("type"))
				type.add(map.get(key));
		}
		placeFilter.setAct(act);
		placeFilter.setType(type);

		int page = 1;
		int limit = 5;

		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		if (fmIn != null) {
			page = (Integer) fmIn.get("page");
		}
		placeFilter.setPage(page);

		List<PlaceBean> placeList = new ArrayList<PlaceBean>();
		int listCount = service.getFilterCount(placeFilter);
		placeList = service.getFilterList(placeFilter);

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
		model.addAttribute("placeList", placeList);

		return "place/place_async";
	}

	@RequestMapping("placeFilterPage")
	public String placeFilterPage(@RequestParam HashMap<String, String> map, HttpServletRequest request)
			throws Exception {
		FlashMap fmOut = RequestContextUtils.getOutputFlashMap(request);

		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		fmOut.put("map", map);
		fmOut.put("page", page);

		return "redirect:placeFilter";
	}
	
	/* 게시판 글쓰기 폼 */
	@RequestMapping("placeWriteForm")
	public String write() {
		
		return "place/place_writeform";
	}
	
	/* 게시판 저장 */
	@RequestMapping(value = "placeWrite")
	public String placeWrite(MultipartHttpServletRequest mtf, Model model, HttpServletRequest request,
			PlaceBean place, HttpSession session)
			throws Exception {
		
		String hour = "오전 " + request.getParameter("open") + " ~ 오후 " + request.getParameter("close");
		place.setPlace_hour(hour);
		
		List<MultipartFile> fileList = mtf.getFiles("placePhotos");
		System.out.println("controller 진입");
		String path = request.getRealPath("upload");
		System.out.println("path=" + path);

		StringBuilder files = new StringBuilder();
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename();
			
			String file[] = new String[2];
			StringTokenizer st = new StringTokenizer(originFileName, ".");
			file[0] = st.nextToken();		// 파일명		Koala
			file[1] = st.nextToken();		// 확장자	    jpg
			
			int result=0;
			int size = (int) mf.getSize();
			if(size > 10000000){				// 100KB
				
				result=1;
				model.addAttribute("result", result);
				
				return "place/place_upload_result";
				
			}else if(!file[1].equals("jpg") &&
					 !file[1].equals("jpeg") &&
					 !file[1].equals("gif") &&
					 !file[1].equals("png") ){
				
				result=2;
				model.addAttribute("result", result);
				
				return "place/place_upload_result";
			}
			
			System.out.println("originFileName=" + originFileName);

			String safeFile = System.currentTimeMillis() + originFileName;

			files.append(safeFile + ",");
			System.out.println("safeFile" + safeFile);

			mf.transferTo(new File(path+"/"+safeFile));
		}
		System.out.println("첨부파일들:"+files.toString());

		String id = (String) session.getAttribute("id");
		place.setPlace_photo(files.toString());

		
		service.insert(place);
		
		return "redirect:/placeList";
	}
	
	/* 상세 페이지, 수정 페이지, 삭제 페이지 */ 
	@RequestMapping(value = "placeDetail")
	public String placeDetail(@RequestParam("place_id") int place_id,
							 @RequestParam("page") String page,
							 @RequestParam("state") String state, 
							 PlaceBookmarkBean placemark,
							 HttpSession session,
							 Model model) throws Exception {
		System.out.println("place_id="+place_id);
		
		 String id = (String) session.getAttribute("id");
		  placemark.setId(id);
		  placemark.setPlace_id(place_id);
		  
		  System.out.println(id); 
		  System.out.println(place_id);
		  
		  int markCount = service.getMarkCount(placemark);
		  System.out.println(markCount);
		  
		  boolean isMark = false; 
		  if (markCount == 1) {
			  
			  isMark = true; 
			  
		  } else if(markCount == 0) {
			
			  isMark = false; 
			
		  }
		
		List<PlaceBean> queryList = new ArrayList<PlaceBean>(); 
		
		PlaceBean place = service.detail(place_id);
		
		double starAvg = 0;
		
		// 리뷰 리스트 객체 선언
		List<PlaceReviewBean> reviewlist = new ArrayList<PlaceReviewBean>();
		
		// 리뷰 개수 구해오기
		int listCount = reviewService.getListCount(place_id);
		System.out.println("리스트 개수="+listCount);
		
		if(listCount > 0) {
			
			System.out.println("리뷰 리스트가 있는 경우");
			//starAvg = reviewService.getPlaceStar(place_id);
		
		}else {
			listCount = 0;
			System.out.println("리뷰 리스트가 없는 경우");
		}
		
		System.out.println("리뷰 갯수 구해와서 if문 빠져나옴");
		
		// 리뷰 별점 평균을 저장 및 업데이트
		place.setPlace_rate(starAvg);
		service.starUpdata(place_id);
		
		String[] addr = place.getPlace_addr().split(" ");
		String city = addr[1];
		String[] hour = place.getPlace_hour().split(" ");
		String open = hour[1];
		String close = hour[4];
		
		queryList = service.getQueryList(city);
		
		model.addAttribute("place", place);
		model.addAttribute("page", page);

		if (state.equals("cont")) { // 내용보기일때
			
			String placeDetail = place.getPlace_content().replace("\n","<br/>");
		//	글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
			model.addAttribute("placeDetail", placeDetail);
			model.addAttribute("queryList", queryList);
			model.addAttribute("city", city);
			model.addAttribute("isMark", isMark);
			model.addAttribute("place_id", place_id);
			
			
			// 리뷰 리스트 구해오기
			reviewlist = reviewService.getPlaceReviewList(place_id);
			place.setPlace_rate(place_id);
			System.out.println("reviewlist="+reviewlist);
			
//			if(id != null) {
//				
//			// 좋아요 리스트 구해오기
//			List<PlaceLikeBean> reviewLike = new ArrayList<PlaceLikeBean>();
//			reviewLike = reviewService.getPlaceLikeList(id);
//			
//			// 좋아요 food_rev_id 값 구해오기
////			int food_rev_id = reviewService.getFoodRevId(id);
//			
////			model.addAttribute("food_rev_id", food_rev_id);
//			model.addAttribute("reviewLike", reviewLike);
//			System.out.println("reviewLike="+reviewLike);
//
//			}
			
			System.out.println("view페이지 공유 전까지 성공");
			
			// view페이지에 공유
			model.addAttribute("reviewlist", reviewlist);
			model.addAttribute("starAvg", starAvg);
			model.addAttribute("listCount", listCount);	

			
			return "place/place_detail";			// 내용보기 페이지 설정
		
		} 	else if (state.equals("modify")) { // 수정폼
			model.addAttribute("open", open);
			model.addAttribute("close", close);
			return "place/place_modifyform";
			
		}
			return null;
	}
	
	@RequestMapping(value = "placeQuery")
	public String placeQuery(@RequestParam("place_id") int place_id, Model model) throws Exception {
		List<PlaceBean> queryList = new ArrayList<PlaceBean>();

		PlaceBean place = service.detail(place_id);
		String[] addr = place.getPlace_addr().split(" ");
		String city = addr[1];

		queryList = service.getQueryList(city);

		model.addAttribute("queryList", queryList);
		model.addAttribute("city", city);
		return "place/place_detail"; // 내용보기 페이지 설정

	}
	
	/* 글 수정 */
	@RequestMapping(value = "placeModify", method = RequestMethod.POST)
	public String placeModify(MultipartHttpServletRequest mtf, HttpServletRequest request,
							 @ModelAttribute PlaceBean placeBean,
							 @RequestParam("page") String page,
							 Model model, HttpSession session) throws Exception {
		
		String hour = "오전 " + request.getParameter("open") + " ~ 오후 " + request.getParameter("close");
		placeBean.setPlace_hour(hour);
		
		List<MultipartFile> fileList = mtf.getFiles("place_photos");
		System.out.println("controller 진입");
		String path = request.getRealPath("upload");
		System.out.println("path=" + path);

		StringBuilder files = new StringBuilder();
		int size = 0;
		
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename();
			
			int result=0;
			size = (int) mf.getSize();
			
			if(size > 0) {
			String file[] = new String[2];
			StringTokenizer st = new StringTokenizer(originFileName, ".");
			file[0] = st.nextToken();		// 파일명		Koala
			file[1] = st.nextToken();		// 확장자	    jpg
			
			if(size > 10000000){				// 100KB
				
				result=1;
				
				model.addAttribute("result", result);
				return "place/place_upload_result";
				
			}else if(!file[1].equals("jpg") &&
					 !file[1].equals("gif") &&
					 !file[1].equals("jpeg") &&
					 !file[1].equals("png") ){
					
				result=2;
				model.addAttribute("result", result);
				
				return "place/place_upload_result";
			}
			
			System.out.println("originFileName=" + originFileName);

			String safeFile = System.currentTimeMillis() + originFileName;
			
			files.append(safeFile + ",");
			System.out.println("safeFile:" + safeFile);

			mf.transferTo(new File(path+"/"+safeFile));
		
			} // size() end
		}
		System.out.println("첨부파일들:" + files.toString());

		String id = (String) session.getAttribute("id");
		
		PlaceBean old = service.detail(placeBean.getPlace_id());
		
		if (size > 0) {
			placeBean.setPlace_photo(files.toString());
		} else {
			placeBean.setPlace_photo(old.getPlace_photo()); // null 값으로 오류
		}
		
		service.modify(placeBean);
		
		return "redirect:/placeDetail?place_id=" + placeBean.getPlace_id()
		+ "&page=" + page + "&state=cont";
	}
	
	/* 게시판 삭제 */
	@RequestMapping(value = "placeDelete", method = RequestMethod.POST)
	public String placeDelete(@RequestParam("place_id") int place_id,
							  @RequestParam("page") int page,
							  Model model) throws Exception {
		
		PlaceBean place = service.detail(place_id);
		
		service.delete(place_id);
		
		return "redirect:/placeList?page=" + page;
	}
	
	@RequestMapping("addPlaceMark") 
	  public String addPlaceMark(@RequestParam("place_id") int place_id,
			  					 @RequestParam("page") String page,
			  					 @RequestParam("state") String state, 
			  					 Model model, PlaceBookmarkBean placemark, 
			  					 HttpSession session) throws Exception {
	  
		System.out.println("북마크 클릭");
	  
	  String id = (String) session.getAttribute("id"); 
	  placemark.setId(id);
	  placemark.setPlace_id(place_id); 
	  System.out.println(id);
	  System.out.println(place_id); 
	  int markCount = service.getMarkCount(placemark); 
	  System.out.println(markCount);
	  
	  if (markCount == 0) { 
		  service.addMark(placemark); 
	  } else {
	  	  service.delMark(placemark); 
	  } 
	
		boolean isMark = false; 
		if (markCount == 1) {
			isMark = false; 
	  } else if(markCount == 0) { 
		  isMark = true;
	  }
	  
	  List<PlaceBean> queryList = new ArrayList<PlaceBean>();
	  PlaceBean place = service.detail(place_id);
	  
	  String[] addr = place.getPlace_addr().split(" "); 
	  String city = addr[1];
	  
	  model.addAttribute("place", place); 
	  model.addAttribute("page", page);
	  
	  String placeDetail = place.getPlace_content().replace("\n", "<br/>"); 
	  
	  model.addAttribute("placeDetail", placeDetail);
	  model.addAttribute("queryList", queryList); 
	  model.addAttribute("city", city);
	  model.addAttribute("isMark", isMark);
	  
	  return "place/place_detail"; 
	 
	}

}
