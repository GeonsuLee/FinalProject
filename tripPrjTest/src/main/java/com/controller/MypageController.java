package com.controller;

import java.io.File;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.model.FoodBookmarkBean;
import com.model.FoodQnaBean;
import com.model.FoodReviewBean;
import com.model.MemberBean;
import com.model.PlaceBookmarkBean;
import com.model.PlaceQnaBean;
import com.model.PlaceReviewBean;
import com.model.RoomBookmarkBean;
import com.model.RoomQnaBean;
import com.model.RoomReviewBean;
import com.service.MypageService;

@Controller
public class MypageController {

	@Autowired
	private MypageService service;

	// 마이페이지
	@RequestMapping("myPage")
	public String myPage(HttpSession session, Model model) throws Exception {

		String id = (String) session.getAttribute("id");
		MemberBean detailM = service.userDetail(id);

		int len = detailM.getPw().length();
		String encrypt = "";
		for (int i = 0; i < len; i++) {
			encrypt += "*";
		}

		model.addAttribute("detailM", detailM);
		model.addAttribute("id", id);
		model.addAttribute("encrypt", encrypt);

		return "mypage/mypage";
	}

	// 회원정보 수정
	@RequestMapping(value = "memberModify", method = RequestMethod.POST)
	public String memberModify(@RequestParam("profiles") MultipartFile mf,
							   MemberBean member,
							   HttpServletRequest request, 
							   HttpSession session,
							   Model model) throws Exception {

		String filename = mf.getOriginalFilename();
		int size = (int) mf.getSize();

		String path = request.getRealPath("upload");
		System.out.println("path:" + path);

		int result = 0;
		String file[] = new String[2];
		String newfilename = "";

		if (size > 0) {
			StringTokenizer st = new StringTokenizer(filename, ".");
			file[0] = st.nextToken();
			file[1] = st.nextToken();
			UUID uuid = UUID.randomUUID();

			newfilename = uuid.toString() + "." + file[1];
			System.out.println("newfilename: " + newfilename);
			if (size > 10000000) {
				result = 1;
				model.addAttribute("result", result);

				return "mypage/mypage_profile";
			} else if (!file[1].equals("jpg") && !file[1].equals("jpeg") && !file[1].equals("gif")
					&& !file[1].equals("png")) {
				result = 2;
				model.addAttribute("result", result);

				return "mypage/mypage_profile";
			}
		}

		if (size > 0) {
			mf.transferTo(new File(path + "/" + newfilename));
		}

		String id = (String) session.getAttribute("id");
		MemberBean modifyM = service.userDetail(id);

		if (size > 0) {
			member.setProfile(newfilename);
		} else {
			member.setProfile(modifyM.getProfile());
		}

		member.setId(id);
		service.updateMember(member);

		model.addAttribute("name", member.getName());
		model.addAttribute("profiles", member.getProfile());

		return "redirect:myPage";
	}

	// 회원 탈퇴 폼
	@RequestMapping(value = "/memberDeleteForm")
	public String member_del(HttpSession session, Model model) throws Exception {
		
		String id = (String) session.getAttribute("id");
		MemberBean deleteM = service.userDetail(id);

		model.addAttribute("d_id", id);
		model.addAttribute("d_name", deleteM.getName());

		return "mypage/mypage_quit";
	}

	// 회원 탈퇴
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDelete(@RequestParam("pw") String pw,
							   MemberBean member, 
							   HttpServletRequest request,
							   HttpSession session) throws Exception {
		
		String id = (String) session.getAttribute("id");
		MemberBean mypage = this.service.userDetail(id);

		if (!mypage.getPw().equals(pw)) {
			return "mypage/mypage_pwresult";
		} else {
			String up = session.getServletContext().getRealPath("upload");
			String fname = mypage.getProfile();
			System.out.println("up:" + up);

			if (fname != null) {
				File delFile = new File(up + "/" + fname);
				delFile.delete();
			}
			
			MemberBean delm = new MemberBean();
			delm.setId(id);
			service.deleteMember(delm);

			session.invalidate();

			return "redirect:main";
		}
	}

	// 로그아웃
	@RequestMapping("mypageLogout")
	public String logout(HttpSession session) {
		session.invalidate();

		return "mypage/mypage_logout";
	}
	
	// 북마크 목록보기
	@RequestMapping("myBookmarkList")
	public String myBookmarklist(Model model, 
								 HttpServletRequest request, 
								 HttpSession session) throws Exception {

		System.out.print("myBookmarkList로 넘어옴");
			
		String id = (String) session.getAttribute("id");
		MemberBean bookmarkM = service.userDetail(id);
			
		List<FoodBookmarkBean> foodBookmarkList = service.getFoodId(id);
		List<PlaceBookmarkBean> placeBookmarkList = service.getPlaceId(id);
		List<RoomBookmarkBean> roomBookmarkList = service.getRoomId(id);
		
		System.out.println("foodBookmarkList :" + foodBookmarkList);
		System.out.println("placeBookmarkList :" + placeBookmarkList);
		System.out.println("roomBookmarkList :" + roomBookmarkList);

		model.addAttribute("foodBookmarkList", foodBookmarkList);
		model.addAttribute("placeBookmarkList", placeBookmarkList);
		model.addAttribute("roomBookmarkList", roomBookmarkList);
		model.addAttribute("bookmarkM", bookmarkM);
		model.addAttribute("id", id);
			
		return "mypage/mypage_bookmark";
	}
	
	// 북마크 지우기
	@RequestMapping("myBookmarkDelete")
	public String myBookmarkDelete(HttpServletRequest request,
								   HttpSession session,
								   FoodBookmarkBean foodbookmark,
								   PlaceBookmarkBean placebookmark,
								   RoomBookmarkBean roombookmark) throws Exception {
		
		System.out.println("myBookmarkDelete로 넘어옴");
		
		String id = (String) session.getAttribute("id");
	 
		// 식당 북마크 지우기 	
		int delFoodMark= service.delFoodMark(foodbookmark);
		System.out.println("delFoodMark : " + delFoodMark);
		
		// 명소 북마크 지우기 
		int delPlaceMark = service.delPlaceMark(placebookmark);
		System.out.println("delPlaceMark : " + delPlaceMark);
		
		// 숙소 북마크 지우기
		int delRoomMark = service.delRoomMark(roombookmark);
		System.out.println("delRoomMark : " + delRoomMark);

		return "redirect:myBookmarkList";
	}
								   
	// 리뷰 목록보기 
	@RequestMapping("myReviewList")
	public String myReviewList(Model model,
							   HttpServletRequest request, 
							   HttpSession session) throws Exception {
			
		System.out.print("myReviewList로 넘어옴");
			
		String id = (String) session.getAttribute("id");
		MemberBean reviewM = service.userDetail(id);
		
		List<FoodReviewBean> foodReviewList = service.getFoodReview(id);
		List<PlaceReviewBean> placeReviewList = service.getPlaceReview(id);
		List<RoomReviewBean> roomReviewList = service.getRoomReview(id);
		
		System.out.println("foodReviewList :" + foodReviewList);
		System.out.println("placeReviewList :" + placeReviewList);
		System.out.println("roomReviewList :" + roomReviewList);
		
		model.addAttribute("reviewM", reviewM);
		model.addAttribute("id", id);
		model.addAttribute("foodReviewList", foodReviewList);
		model.addAttribute("placeReviewList", placeReviewList);
		model.addAttribute("roomReviewList", roomReviewList);
		
			
		return "mypage/mypage_reviewlist";
	}
	
	// Q&A 목록보기 
	@RequestMapping("myQnaList")
	public String myQnaList(Model model,
						    HttpServletRequest request, 
						    HttpSession session) throws Exception {
			
		System.out.print("myQnaList로 넘어옴");

		String id = (String) session.getAttribute("id");
		MemberBean qnaM = service.userDetail(id);
		
		List<FoodQnaBean> foodQnaList = service.getFoodQna(id);
		List<PlaceQnaBean> placeQnaList = service.getPlaceQna(id);
		List<RoomQnaBean> roomQnaList = service.getRoomQna(id);
		
		System.out.println("foodQnaList :" + foodQnaList);
		System.out.println("placeQnaList :" + placeQnaList);
		System.out.println("roomQnaList :" + roomQnaList);
		
		model.addAttribute("qnaM", qnaM);
		model.addAttribute("id", id);
		model.addAttribute("foodQnaList", foodQnaList);
		model.addAttribute("placeQnaList", placeQnaList);
		model.addAttribute("roomQnaList", roomQnaList);
			
		return "mypage/mypage_qnalist";
	}

}