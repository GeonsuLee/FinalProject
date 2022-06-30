package com.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model.MemberBean;
import com.service.MemberService ;



@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	@RequestMapping("member")
	public String member() {
		return "member";
	}
	
	// ID중복검사 ajax함수로 처리부분
	@RequestMapping(value = "/idcheck", method = RequestMethod.POST)
	public String idcheck(@RequestParam("memid") String id, Model model) throws Exception {

		int result = service.checkMemberId(id);
		model.addAttribute("result", result);

		return "member/member_idcheckresult";
	}

	/* 로그인 폼 뷰 */
	@RequestMapping(value = "/loginForm")
	public String loginForm() {
		return "member/member_loginform";
	}

	/* 비번찾기 폼 */
	@RequestMapping(value = "/pwFind")
	public String pwFind() {
		
		System.out.println("pw");
		
		return "member/member_pwfind";
	}

	/* 회원가입 폼 */
	@RequestMapping(value = "/joinForm")
	public String joinForm() {
		return "member/member_joinform";
	}

	
	/* 비번찾기 완료 */
	@RequestMapping(value = "/pwFindOk", method = RequestMethod.POST)
	public String pwFindOk(@ModelAttribute MemberBean mem, HttpServletResponse response, Model model)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		MemberBean member = service .pwFind(mem);

		if (member == null) {// 값이 없는 경우

			return "member/member_pwresult";

		} else {

			// Mail Server 설정
			String charSet = "utf-8";
			String hostSMTP = "smtp.naver.com";
			String hostSMTPid = "dpsk159@naver.com";
			String hostSMTPpwd = "**rlarlqja13"; // 비밀번호 입력해야함

			// 보내는 사람 EMail, 제목, 내용
			String fromEmail = "dpsk159@naver.com";
			String fromName = "관리자";
			String subject = "비밀번호 찾기";

			// 받는 사람 E-Mail 주소
			String mail = member.getMail();

			try {
				HtmlEmail email = new HtmlEmail();
				email.setDebug(true);
				email.setCharset(charSet);
				email.setSSL(true);
				email.setHostName(hostSMTP);
				email.setSmtpPort(587);

				email.setAuthentication(hostSMTPid, hostSMTPpwd);
				email.setTLS(true);
				email.addTo(mail, charSet);
				email.setFrom(fromEmail, fromName, charSet);
				email.setSubject(subject);
				email.setHtmlMsg("<p align = 'center'>비밀번호 찾기</p><br>" + "<div align='center'> 비밀번호 : "
						+ member.getPw() + "</div>");
				email.send();
			} catch (Exception e) {
				System.out.println(e);
			}

			model.addAttribute("pwdok", "등록된 email을 확인 하세요~!!");
			return "member/member_pwfind";

		}

	}

		/* 회원 가입 저장(fileupload) */
		@RequestMapping(value = "/joinOk", method = RequestMethod.POST)
		public String joinOk(@RequestParam("profiles") MultipartFile mf,
								 MemberBean member,
								 HttpServletRequest request,
								 Model model) throws Exception {
		
		String filename = mf.getOriginalFilename();
		int size = (int) mf.getSize(); 	// 첨부파일의 크기 (단위:Byte) 

		String path = request.getRealPath("upload");
		System.out.println("mf=" + mf);
		System.out.println("filename=" + filename); // filename="Koala.jpg"
		System.out.println("size=" + size);
		System.out.println("Path=" + path);
		int result=0;
		
		String file[] = new String[2];
		
		String newfilename = "";
	
	if(filename != ""){	 // 첨부파일이 전송된 경우	
		
		// 파일 중복문제 해결
		String extension = filename.substring(filename.lastIndexOf("."), filename.length());
		System.out.println("extension:"+extension);
		
		UUID uuid = UUID.randomUUID();
		
		newfilename = uuid.toString() + extension;
		System.out.println("newfilename:"+newfilename);		
		
		StringTokenizer st = new StringTokenizer(filename, ".");
		file[0] = st.nextToken();		// 파일명		Koala
		file[1] = st.nextToken();		// 확장자	    jpg
		
		if(size > 10000000){				// 10000KB
			result=1;
			model.addAttribute("result", result);
			
			return "member/member_uploadresult";
			
		}else if(!file[1].equals("jpg") &&
				 !file[1].equals("gif") &&
				 !file[1].equals("png") ){
			
			result=2;
			model.addAttribute("result", result);
			
			return "member/member_uploadresult";
		}
	}	

		if (size > 0) { // 첨부파일이 전송된 경우

			mf.transferTo(new File(path + "/" + newfilename));

		}
		member.setProfile(newfilename);

		service.joinMember(member);

		return "redirect:main";
	}

	/* 로그인 인증 */
	@RequestMapping(value = "/loginOk", method = RequestMethod.POST)
	public String loginOk(@RequestParam("id") String id, 
			              @RequestParam("pw") String pw,
			              HttpSession session, 
			              Model model) throws Exception {
		
		System.out.println(id);
		System.out.println(pw);
		
		int result=0;		
		MemberBean m = service.userCheck(id);

		System.out.println("userCheck까지 완료");
		if (m == null) {	// 등록되지 않은 회원일때
			
			result = 1;
			model.addAttribute("result", result);
			
			return "member/member_loginresult";
			
		} else {			// 등록된 회원일때
			if (m.getPw().equals(pw) && m.getQuit().equals("n")) {// 비번이 같을때
				session.setAttribute("id", id);
				
	
				String profile = m.getProfile();

				
				model.addAttribute("profile", profile);

				System.out.println("로그인 성공");
				return "main";
				
			} else {// 비번이 다를때
				result = 2;
				model.addAttribute("result", result);
				
				return "member/member_loginresult";				
			}
		}

	}

	// 로그아웃
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();

		return "member/member_logout";
	}
}
	




