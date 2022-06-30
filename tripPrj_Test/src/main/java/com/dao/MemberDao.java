package com.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.model.MemberBean;


@Repository
public class MemberDao {
	
	@Autowired
	private SqlSession sqlSession;	


	/***** 아이디 중복 체크 *****/
//	@Transactional
	public int checkMemberId(String id) throws Exception {
//		getSession();
		int re = -1;	// 사용 가능한 ID
		MemberBean mb = sqlSession.selectOne("idCheck", id);
		if (mb != null)
			re = 1; 	// 중복id
		return re;
	}
	

	/* 비번 검색 */
//	@Transactional
	public MemberBean pwFind(MemberBean pm) throws Exception {
//		getSession();
		return (MemberBean) sqlSession.selectOne("memberns.pwFind", pm);
	}

	/* 회원저장 */
//	@Transactional
	public void joinMember(MemberBean m) throws Exception {
//		getSession();
		sqlSession.insert("memberns.join", m);
	}

	/* 로그인 인증 체크 */
//	@Transactional
	public MemberBean userCheck(String id) throws Exception {
//		getSession();
		return (MemberBean) sqlSession.selectOne("memberns.loginCheck", id);
	}


}

