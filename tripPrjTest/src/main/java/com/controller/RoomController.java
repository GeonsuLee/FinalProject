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

import com.model.FoodReviewBean;
import com.model.PlaceBean;
import com.model.RoomBean;
import com.model.RoomFilterBean;
import com.model.RoomReviewBean;
import com.service.RoomReviewService;
import com.service.RoomService;

@Controller
public class RoomController {

	@Autowired
	private RoomService service;
	
	@Autowired
	private RoomReviewService reviewService;

	@RequestMapping("roomList")
	public String roomList(Model model, HttpServletRequest request) throws Exception {
		List<RoomBean> roomList = new ArrayList<RoomBean>();

		int page = 1;
		int limit = 9;

		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		int listCount = service.getCount();
		roomList = service.getList(page);

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
		model.addAttribute("roomList", roomList);

		return "room/room_list";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("roomFilter")
	public String roomFilter(@RequestParam HashMap<String, String> map, RoomFilterBean roomFilter, Model model,
			HttpServletRequest request) throws Exception {
		
		Map<String, ?> fmIn = RequestContextUtils.getInputFlashMap(request);
		if (fmIn != null) {
			map = (HashMap<String, String>) fmIn.get("map");
		}
		System.out.println(map);

		ArrayList<String> type = new ArrayList<>();
		ArrayList<String> star = new ArrayList<>();
		for (String key : map.keySet()) {
			if (key.contains("city"))
				roomFilter.setCity(map.get("city"));
			if (key.contains("district"))
				roomFilter.setDistrict(map.get("district"));
			if (key.contains("minCost"))
				roomFilter.setMinCost(Integer.parseInt(map.get("minCost")));
			if (key.contains("maxCost"))
				roomFilter.setMaxCost(Integer.parseInt(map.get("maxCost")));
			if (key.contains("rate"))
				roomFilter.setRate(map.get("rate"));
			
			if (key.contains("type"))
				type.add(map.get(key));
			if (key.contains("star"))
				star.add(map.get(key));
		}
		roomFilter.setType(type);
		roomFilter.setStar(star);

		int page = 1;
		int limit = 9;

		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		if (fmIn != null) {
			page = (Integer) fmIn.get("page");
		}
		roomFilter.setPage(page);

		List<RoomBean> roomList = new ArrayList<RoomBean>();
		int listCount = service.getFilterCount(roomFilter);
		roomList = service.getFilterList(roomFilter);

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
		model.addAttribute("roomList", roomList);

		return "room/room_async";
	}

	@RequestMapping("roomFilterPage")
	public String roomFilterPage(@RequestParam HashMap<String, String> map, HttpServletRequest request)
			throws Exception {
		FlashMap fmOut = RequestContextUtils.getOutputFlashMap(request);

		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		fmOut.put("map", map);
		fmOut.put("page", page);

		return "redirect:roomFilter";
	}
	
	/* 게시판 글쓰기 폼 */
	@RequestMapping("roomWriteForm")
	public String write() {

		return "room/room_writeform";
	}

	/* 게시판 저장 */
	@RequestMapping(value = "roomWrite")
	public String roomWrite(MultipartHttpServletRequest mtf, Model model, HttpServletRequest request, RoomBean room,
							HttpSession session) throws Exception {

		List<MultipartFile> fileList = mtf.getFiles("roomPhotos");
		System.out.println("controller 진입");
		String path = request.getRealPath("upload");
		System.out.println("path=" + path);

		StringBuilder files = new StringBuilder();
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename();

			String file[] = new String[3];
			StringTokenizer st = new StringTokenizer(originFileName, ".");
			file[0] = st.nextToken(); // 파일명 Koala
			file[1] = st.nextToken(); // 확장자 jpg

			int result = 0;
			int size = (int) mf.getSize();
			if (size > 10000000) { // 100KB

				result = 1;
				model.addAttribute("result", result);

				return "room/room_upload_result";

			} else if (!file[1].equals("jpg") &&
					!file[1].equals("gif") &&
					!file[1].equals("jpeg")&&
					!file[1].equals("png")) {

				result = 2;
				model.addAttribute("result", result);

				return "room/room_upload_result";
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
		room.setRoom_photo(files.toString());

		System.out.println("insert전");
		service.insert(room);
		System.out.println("insert완료");

		return "redirect:/roomList";
	}
	
	/* 상세 페이지, 수정 페이지, 삭제 페이지 */
	@RequestMapping(value = "roomDetail")
	public String roomDetail(@RequestParam("room_id") int room_id,
							 @RequestParam("page") String page,
							 @RequestParam("state") String state,
							 Model model) throws Exception {
		
		List<PlaceBean> queryList = new ArrayList<PlaceBean>(); 
		
		RoomBean room = service.detail(room_id);
		
		
		double starAvg = 0;
		
		// 리뷰 리스트 객체 선언
				List<RoomReviewBean> reviewlist = new ArrayList<RoomReviewBean>();

				// 리뷰 개수 구해오기
				int listCount = reviewService.getListCount(room_id);
				
				if(listCount > 0) {
					
					// 별점 평균 구해오기와서 starAvg에 저장
					starAvg = reviewService.getRoomStar(room_id);
					
				}else {
					listCount = 0;
				}
				
				// 리뷰 별점 평균을 저장 및 업데이트
				room.setRoom_rate(starAvg);
				service.starUpdata(room_id);
		
		
		String[] addr = room.getRoom_addr().split(" ");
		String city = addr[1];
		
		queryList = service.getQueryList(city);
		
		model.addAttribute("room", room);
		model.addAttribute("page", page);
		
		if (state.equals("cont")) {// 내용보기일때
			
			String roomDetail = room.getRoom_content().replace("\n", "<br/>");
//			// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
			model.addAttribute("roomDetail", roomDetail);
			model.addAttribute("queryList", queryList);
			model.addAttribute("city", city);
			return "room/room_detail"; // 내용보기 페이지 설정

		} else if (state.equals("modify")) {// 수정폼
			return "room/room_modifyform";

		} else if (state.equals("delete")) {// 삭제폼
			return "room/room_deleteform";

		}
		return null;
	}

	/* 글 수정 */
	@RequestMapping(value = "roomModify", method = RequestMethod.POST)
	public String roomModify(MultipartHttpServletRequest mtf, HttpServletRequest request,
							 @ModelAttribute RoomBean roomBean, @RequestParam("page") String page, Model model, HttpSession session)
			throws Exception {

		List<MultipartFile> fileList = mtf.getFiles("room_photos");
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
				System.out.println("100K 넘음");
				return "room/room_upload_result";

			} else if (!file[1].equals("jpg") &&
					!file[1].equals("gif") &&
					!file[1].equals("jpeg")&&
					!file[1].equals("png")) {

				result = 2;
				model.addAttribute("result", result);

				return "room/room_upload_result";
			}

			System.out.println("originFileName=" + originFileName);

			String safeFile = System.currentTimeMillis() + originFileName;

			files.append(safeFile + ",");
			System.out.println("safeFile:" + safeFile);

			mf.transferTo(new File(path + "/" + safeFile));
		}
		System.out.println("첨부파일들:" + files.toString());

		String id = (String) session.getAttribute("id");
		roomBean.setRoom_photo(files.toString());

		service.modify(roomBean);

		return "redirect:/roomDetail?room_id=" + roomBean.getRoom_id() + "&page=" + page + "&state=cont";
	}

	/* 게시판 삭제 */
	@RequestMapping(value = "roomDelete", method = RequestMethod.POST)
	public String roomDelete(@RequestParam("room_id") int room_id,
							 @RequestParam("page") int page,
							 Model model) throws Exception {

		RoomBean room = service.detail(room_id);

		service.delete(room_id);

		return "redirect:/roomList?page=" + page;
	}

}
