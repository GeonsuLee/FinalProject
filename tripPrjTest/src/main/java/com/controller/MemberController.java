package com.controller;

import java.io.File;
import java.util.Random;
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
import com.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;

	// 로그인 폼
	@RequestMapping(value = "loginForm")
	public String loginForm() {
		return "member/member_loginform";
	}

	// 로그인 인증
	@RequestMapping(value = "loginOk", method = RequestMethod.POST)
	public String loginOk(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpSession session,
			Model model) throws Exception {

		int result = 0;
		MemberBean member = service.userCheck(id);

		if (member == null) {
			result = 1;
			model.addAttribute("result", result);

			return "member/member_loginresult";
		} else {
			if (member.getPw().equals(pw) && member.getQuit().equals("n")) {
				session.setAttribute("id", id);

				String profile = member.getProfile();
				model.addAttribute("profile", profile);

				return "redirect:main";
			} else {
				result = 2;
				model.addAttribute("result", result);

				return "member/member_loginresult";
			}
		}

	}

	// 비밀번호 찾기 폼
	@RequestMapping(value = "pwFind")
	public String pwFind() {
		return "member/member_pwfind";
	}

	// 비밀번호 찾기
	@RequestMapping(value = "pwFindOk", method = RequestMethod.POST)
	public String pwFindOk(@ModelAttribute MemberBean mem, HttpServletResponse response, Model model) throws Exception {
		response.setContentType("text/html;charset=UTF-8");

		MemberBean member = service.pwFind(mem);

		int result = 0;
		if (member == null || member.getQuit().equals("y")) {
			return "member/member_pwresult";
		} else {
			String charSet = "utf-8";
			String hostSMTP = "smtp.naver.com";
			String hostSMTPid = "dpsk158@naver.com";
			String hostSMTPpwd = "a1s2d3f4";

			String fromEmail = "dpsk158@naver.com";
			String fromName = "관리자";
			String subject = "비밀번호 찾기 안내 이메일입니다.";
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
				email.setHtmlMsg("<p align = 'center'><b>" + member.getName() + "</b>님의 비밀번호는</p><br>" + "<div align='center'>" + member.getPw() + "입니다.</div>");
				email.send();
				result = 1;
			} catch (Exception e) {
				System.out.println(e);
			}

			model.addAttribute("result", result);

			return "member/member_pwfind";
		}

	}

	// 회원가입 폼
	@RequestMapping(value = "joinForm")
	public String joinForm() {
		return "member/member_joinform";
	}

	// 회원 가입
	@RequestMapping(value = "joinOk", method = RequestMethod.POST)
	public String joinOk(@RequestParam("profiles") MultipartFile mf, MemberBean member, HttpServletRequest request,
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
			System.out.println("newfilename:" + newfilename);
			if (size > 10000000) {
				result = 1;
				model.addAttribute("result", result);

				return "member/member_uploadresult";
			} else if (!file[1].equals("jpg") && !file[1].equals("gif") && !file[1].equals("jpeg")
					&& !file[1].equals("png")) {
				result = 2;
				model.addAttribute("result", result);

				return "member/member_uploadresult";
			}
		}

		if (size > 0) {
			mf.transferTo(new File(path + "/" + newfilename));
		}

		member.setProfile(newfilename);
		service.joinMember(member);

		return "redirect:main";
	}

	// ID 중복검사
	@RequestMapping(value = "idcheck", method = RequestMethod.POST)
	public String idcheck(@RequestParam("memid") String id, Model model) throws Exception {
		int result = service.checkMemberId(id);
		model.addAttribute("result", result);

		return "member/member_idcheckresult";
	}

	// 이메일 인증
	@RequestMapping("sendmail")
	public String send(String mail, Model model) {

		Random random = new Random();
		int auth = random.nextInt(888888) + 111111;

		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "dpsk158";
		String hostSMTPpwd = "a1s2d3f4";

		String fromEmail = "dpsk158@naver.com";
		String fromName = "관리자";
		String subject = "이메일 인증번호 입니다.";

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
			email.setHtmlMsg("<p align = 'center'><b>회원가입을 환영합니다.</b></p><br>" + "<div align='center'> 인증번호 : " + auth + "</div>");
			email.send();
		} catch (Exception e) {
			System.out.println(e);
		}

		model.addAttribute("auth", auth);

		return "member/member_mailresult";
	}

	// 로그아웃
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();

		return "member/member_logout";
	}
	
	// 카카오 회원가입 및 로그인값 가져오기
	@RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, Model model,
			HttpSession session) throws Exception {
		System.out.println("#########" + code);
		String access_Token = service.getAccessToken(code);
		MemberBean userInfo = service.getUserInfo(access_Token);
		// HashMap<String, Object> userInfo = service.getUserInfo(access_Token);
		System.out.println("###access_Token#### : " + access_Token);
		System.out.println("###id#### : " + userInfo.getId());
		System.out.println("###nickname#### : " + userInfo.getName());
		System.out.println("###email#### : " + userInfo.getMail());

		// 아래 코드가 추가되는 내용(값 무효화)
		// session.invalidate();
		// 위 코드는 session객체에 담긴 정보를 초기화 하는 코드.
		if (userInfo.getId() != null) {
			session.setAttribute("id", userInfo.getId());
			session.setAttribute("access_Token", access_Token);
		}
		// 위 2개의 코드는 닉네임과 이메일을 session객체에 담는 코드
		// jsp에서 ${sessionScope.kakaoN} 이런 형식으로 사용할 수 있다.

		model.addAttribute("idok", "1234"); // 팝업창을 위해 인증값 받아오기

		return "modal";
	}

}
