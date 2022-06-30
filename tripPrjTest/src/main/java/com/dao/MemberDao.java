package com.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.model.MemberBean;

@Repository
public class MemberDao {

	@Autowired
	private SqlSession sqlSession;

	// 아이디 중복 체크
	public int checkMemberId(String id) throws Exception {
		int re = -1;
		MemberBean mb = sqlSession.selectOne("memberns.getMember", id);
		if (mb != null)
			re = 1;
		return re;
	}

	// 비밀번호 검색
	public MemberBean pwFind(MemberBean pm) throws Exception {
		return (MemberBean) sqlSession.selectOne("memberns.pwFind", pm);
	}

	// 회원가입
	public void joinMember(MemberBean m) throws Exception {
		sqlSession.insert("memberns.join", m);
	}

	// 로그인 인증 체크
	public MemberBean userCheck(String id) throws Exception {
		return (MemberBean) sqlSession.selectOne("memberns.getMember", id);
	}
	
	// 정보 저장
	public void kakaoinsert(HashMap<String, Object> userInfo) {
		sqlSession.insert("memberns.kakaoInsert", userInfo);
	}

	// 정보 확인
	public MemberBean findkakao(HashMap<String, Object> userInfo) {
		System.out.println("RI:" + userInfo.get("email"));
		System.out.println("RN:" + userInfo.get("nickname"));
		System.out.println("RE:" + userInfo.get("email"));
//			System.out.println("RE:" + userInfo.get("email"));
		return sqlSession.selectOne("memberns.findKakao", userInfo);
	}
}
