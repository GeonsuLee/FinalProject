package com.controller;

import java.io.File;
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

import com.model.MemberBean;
import com.service.MypageService;

@Controller 
public class MypageController {
	
	@Autowired
	private MypageService service;
	
	// 마이페이지 상세 뷰 
	@RequestMapping("myPage")
	public String myPage(HttpSession session, Model model) throws Exception {
		
		String id = (String) session.getAttribute("id");

		MemberBean editm = service.userDetail(id);
		
		model.addAttribute("editm", editm);
		model.addAttribute("id", id);

		return "mypage";
	}
	
//	// 회원정보 수정 양식
//	@RequestMapping("memberModifyForm")
//	public String memberModifyForm(HttpSession session, Model model) throws Exception {
//		
//		String id = (String)session.getAttribute("id");
//		
//		MemberBean modifym = service.userCheck(id);
//		
//		model.addAttribute("modifym", modifym);
//
//		return "mypage/mypage_modify";
//	}
	
	// 회원정보 수정(+프로필 사진 업로드)
	@RequestMapping(value = "/memberModify", method = RequestMethod.POST)
	public String memberModify(@RequestParam("profiles") MultipartFile mf, 
								 MemberBean mypage,
								 HttpServletRequest request, 
								 HttpSession session, 
								 Model model) throws Exception {
		System.out.println("memberModify로 넘어옴");
		String filename = mf.getOriginalFilename();	// 첨부파일의 이름 
		int size = (int) mf.getSize();				// 첨부파일의 크기(단위: Byte, 자료형: long형)	
		
		String path = request.getRealPath("upload");// 파일이 실제 저장되는 경로 
		System.out.println("path:"+path);
		
		int result=0;		
		String file[] = new String[2];
		
		String newfilename = "";
		
	if(filename != ""){	 // 첨부파일이 전송된 경우		
		
		// 파일 이름의 중복 문제를 해결
		String extension = filename.substring(filename.lastIndexOf("."), filename.length());
		System.out.println("extension:"+extension);
				
		UUID uuid = UUID.randomUUID();
				
		newfilename = uuid.toString() + extension;
		System.out.println("newfilename:"+newfilename);		
		
		// 파일명과 확장자를 분리하기 
		StringTokenizer st = new StringTokenizer(filename, ".");
		file[0] = st.nextToken();		// 파일명
		file[1] = st.nextToken();		// 확장자	
		
		if(size > 10000000){
			result=1;
			model.addAttribute("result", result);
			
			return "mypage/mypage_profile"; // 프로필사진 업로드 처리 확인 페이지 
			
		}else if(!file[1].equals("jpg") &&
				 !file[1].equals("gif") &&
				 !file[1].equals("png") ){
			
			result=2;
			model.addAttribute("result", result);
			
			return "mypage/mypage_profile";
		}	
		
	}
		
		if (size > 0) { // 첨부파일이 전송된 경우

			mf.transferTo(new File(path + "/" + newfilename));

		}		
		
		String id = (String) session.getAttribute("id");

		MemberBean modifym = service.userDetail(id);		
		
		if (size > 0 ) { 				// 첨부파일이 수정되면
			mypage.setProfile(newfilename);			
		} else { 						// 첨부파일이 수정되지 않으면
			mypage.setProfile(modifym.getProfile());
		}

		mypage.setId(id);
		//mypage.setQuit("n");
		service.updateMember(mypage);	// 수정 메소드 호출

		model.addAttribute("name", mypage.getName());
		model.addAttribute("profiles", mypage.getProfile());

		return "redirect:myPage";
	}
	
//	// 회원 탈퇴 양식 
//	@RequestMapping(value = "/memberDeleteForm")
//	public String memberDeleteForm(HttpSession session, Model model) throws Exception {
//
//		String id = (String) session.getAttribute("id");
//		MemberBean deleteM = service.userCheck(id);
//		model.addAttribute("d_id", id);
//		model.addAttribute("d_name", deleteM.getName());
//
//		return "mypage";
//	}
//	
//	// 회원 탈퇴 완료
//	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
//	public String memberDelete(@RequestParam("pw") String pw, 
//							    @RequestParam("quit") String quit,
//							    HttpSession session) throws Exception {
//
//		String id = (String) session.getAttribute("id");
//		MemberBean mypage = this.service.userCheck(id);
//
//		if (!mypage.getPw().equals(pw)) {	// 비밀번호가 틀리면
//
//			return "member_quit";		
//			
//		} else {							// 비밀번호가 일치하면
//			
//			String up = session.getServletContext().getRealPath("upload");
//			String fname = mypage.getProfile();
//			System.out.println("up:"+up);
//			
//			// DB에 저장된 기존 이진파일명을 가져옴
//			if (fname != null) {	// 기존 이진파일이 존재하면
//				File delFile = new File(up +"/"+fname);
//				delFile.delete();	// 기존 이진파일을 삭제
//			}
//			MemberBean delm = new MemberBean();
//			delm.setId(id);
//			delm.setQuit(quit);
//
//			service.deleteMember(delm);	// 삭제 메소드 호출
//
//			session.invalidate();		// 세션 만료
//
//			return "redirect:main";
//		}
//	}

	// 내 리뷰 목록보기 
//	@RequestMapping("myReviewList")
//	public String list(Model model, HttpServletRequest request) throws Exception {
//
//		List<ReviewBean> reviewlist = new ArrayList<ReviewBean>(); 
//
//		int page = 1;
//		int limit = 10; // 한 화면에 출력할 레코드수
//
//		if (request.getParameter("page") != null) {
//			page = Integer.parseInt(request.getParameter("page"));
//		}
//
//		// 총 리스트 수를 받아옴.
//		int listcount = service.getReviewCount();
//
//		// 페이지 번호(page)를 DAO클래스에게 전달한다.
//		reviewlist = service.getReviewList(page); // 리스트를 받아옴.
//
//		// 총 페이지 수.
//		int pagecount = (int) ((double) listcount / limit + 0.95); // 0.95를 더해서 올림
//																	// 처리.
//		// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
//		int startpage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
//		// 현재 페이지에 보여줄 마지막 페이지 수.(10, 20, 30 등...)
//		int endpage = pagecount;
//
//		if (endpage > startpage + 10 - 1)
//			endpage = startpage + 10 - 1;
//
//		model.addAttribute("page", page);
//		model.addAttribute("startpage", startpage);
//		model.addAttribute("endpage", endpage);
//		model.addAttribute("pagecount", pagecount);
//		model.addAttribute("listcount", listcount);
//		model.addAttribute("reviewlist", reviewlist);
//		
//		return "review_list";
//	}
//	
//	// 내 리뷰 수정하기 
//	@RequestMapping(value = "/reviewModify", method = RequestMethod.POST)
//	public String reviewModify(@ModelAttribute ReviewBean rev,
//								@RequestParam("page") String page,
//								@RequestParam("pw") String pw,
//								Model model) throws Exception {
//
//		// 수정 메소드 호출
//		ReviewBean review = service.rev_cont(rev.getRev_id());
//		int result = 0;
//		
//		if (!review.getReview_pw().equals(pw)) {	// 비밀번호가 틀리면
//			result = 1;
//			model.addAttribute("result", result);
//			
//			return "view/rev_modify_result";
//
//		} else {
//			// 수정 메소드 호출
//			service.updateReview(rev);			
//		}	
//		
//		return "redirect:/review_cont?rev_id=" + rev.getRev_id()
//					+ "&page=" + page + "&state=cont";
//	}
//	
//	// 내 리뷰 삭제하기 
//	@RequestMapping(value = "/reviewDelete", method = RequestMethod.POST)
//	public String reviewDelete(@RequestParam("rev_id") int rev_id,
//			@RequestParam("page") int page,
//			@RequestParam("pw") String pw,
//			Model model) throws Exception {
//
//		ReviewBean review = service.rev_cont(rev_id);
//		int result=0;
//		
//		if (!review.getReview_pw().equals(pw)) {
//			result = 1;
//			model.addAttribute("result", result);
//
//			return "view/rev_modify_delete";
//
//		} else {
//			service.deleteReview(rev_id);		
//		}
//		
//		return "redirect:/myReviewList?page=" + page;
//	}
//	
//	// 내 문의 목록보기 
//	@RequestMapping("myQnaList")
//	public String list(Model model, HttpServletRequest request) throws Exception {
//
//		List<QnaBean> qnalist = new ArrayList<QnaBean>(); 
//
//		int page = 1;
//		int limit = 10; // 한 화면에 출력할 레코드수
//
//		if (request.getParameter("page") != null) {
//			page = Integer.parseInt(request.getParameter("page"));
//		}
//
//		// 총 리스트 수를 받아옴.
//		int listcount = service.getQnaCount();
//
//		// 페이지 번호(page)를 DAO클래스에게 전달한다.
//		qnalist = service.getQnaList(page); // 리스트를 받아옴.
//
//		// 총 페이지 수.
//		int pagecount = (int) ((double) listcount / limit + 0.95); // 0.95를 더해서 올림
//																	// 처리.
//		// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
//		int startpage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
//		// 현재 페이지에 보여줄 마지막 페이지 수.(10, 20, 30 등...)
//		int endpage = pagecount;
//
//		if (endpage > startpage + 10 - 1)
//			endpage = startpage + 10 - 1;
//
//		model.addAttribute("page", page);
//		model.addAttribute("startpage", startpage);
//		model.addAttribute("endpage", endpage);
//		model.addAttribute("pagecount", pagecount);
//		model.addAttribute("listcount", listcount);
//		model.addAttribute("qnalist", qnalist);
//		
//		return "qna_list";
//	}
//	
//	// 내 문의 수정하기 
//	@RequestMapping(value = "/qnaModify", method = RequestMethod.POST)
//	public String reviewModify(@ModelAttribute QnaBean q,
//								@RequestParam("page") String page,
//								@RequestParam("pw") String pw,
//								Model model) throws Exception {
//
//		// 수정 메소드 호출
//		QnaBean qna = service.rev_cont(q.getQna_id());
//		int result = 0;
//		
//		if (!qna.getQna_pw().equals(pw)) {	// 비밀번호가 틀리면
//			result = 1;
//			model.addAttribute("result", result);
//			
//			return "view/qna_modify_result";
//
//		} else {
//			// 수정 메소드 호출
//			service.updateQna(q);			
//		}	
//		
//		return "redirect:/qna_cont?qna_id=" + q.getQna_id()
//					+ "&page=" + page + "&state=cont";
//	}
//	
//	// 내 문의 삭제하기 
//	@RequestMapping(value = "/qnaDelete", method = RequestMethod.POST)
//	public String qnaDelete(@RequestParam("qna_id") int qna_id,
//			@RequestParam("page") int page,
//			@RequestParam("pw") String pw,
//			Model model) throws Exception {
//
//		QnaBean qna = service.qna_cont(qna_id);
//		int result=0;
//		
//		if (!qna.getQna_pw().equals(pw)) {
//			result = 1;
//			model.addAttribute("result", result);
//
//			return "view/qna_modify_delete";
//
//		} else {
//			service.deleteQna(qna_id);		
//		}
//		
//		return "redirect:/myQnaList?page=" + page;
//	}
//	
//	// 내 북마크 목록보기
//	@RequestMapping("myBookmarkList")
//	public String list(Model model, HttpServletRequest request) throws Exception {
//
//		List<BookmarkBean> bookmarklist = new ArrayList<BookmarkBean>(); 
//
//		int page = 1;
//		int limit = 10; // 한 화면에 출력할 레코드수
//
//		if (request.getParameter("page") != null) {
//			page = Integer.parseInt(request.getParameter("page"));
//		}
//
//		// 총 리스트 수를 받아옴.
//		int listcount = service.getBookmarkCount();
//
//		// 페이지 번호(page)를 DAO클래스에게 전달한다.
//		bookmarklist = service.getBookmarkList(page); // 리스트를 받아옴.
//
//		// 총 페이지 수.
//		int pagecount = (int) ((double) listcount / limit + 0.95); // 0.95를 더해서 올림
//																	// 처리.
//		// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
//		int startpage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
//		// 현재 페이지에 보여줄 마지막 페이지 수.(10, 20, 30 등...)
//		int endpage = pagecount;
//
//		if (endpage > startpage + 10 - 1)
//			endpage = startpage + 10 - 1;
//
//		model.addAttribute("page", page);
//		model.addAttribute("startpage", startpage);
//		model.addAttribute("endpage", endpage);
//		model.addAttribute("pagecount", pagecount);
//		model.addAttribute("listcount", listcount);
//		model.addAttribute("bookmarklist", bookmarklist);
//		
//		return "bookmark_list";
//	}
//
//	// 내 북마크 삭제하기
//	
//	// 예약 내역 목록보기 
//	@RequestMapping("myAccomList")
//	public String list(Model model, HttpServletRequest request) throws Exception {
//
//		List<AccomBean> accomlist = new ArrayList<AccomBean>(); 
//
//		int page = 1;
//		int limit = 10; // 한 화면에 출력할 레코드수
//
//		if (request.getParameter("page") != null) {
//			page = Integer.parseInt(request.getParameter("page"));
//		}
//
//		// 총 리스트 수를 받아옴.
//		int listcount = service.getAccomCount();
//
//		// 페이지 번호(page)를 DAO클래스에게 전달한다.
//		accomlist = service.getAccomList(page); // 리스트를 받아옴.
//
//		// 총 페이지 수.
//		int pagecount = (int) ((double) listcount / limit + 0.95); // 0.95를 더해서 올림
//																	// 처리.
//		// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
//		int startpage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
//		// 현재 페이지에 보여줄 마지막 페이지 수.(10, 20, 30 등...)
//		int endpage = pagecount;
//
//		if (endpage > startpage + 10 - 1)
//			endpage = startpage + 10 - 1;
//
//		model.addAttribute("page", page);
//		model.addAttribute("startpage", startpage);
//		model.addAttribute("endpage", endpage);
//		model.addAttribute("pagecount", pagecount);
//		model.addAttribute("listcount", listcount);
//		model.addAttribute("accomlist", accomlist);
//		
//		return "accom_list";
//	}
//	
	// 예약 내역 취소하기(삭제) -> 조건에 따라 취소가 가능(또는 관리자의 승인이 필요함)

}