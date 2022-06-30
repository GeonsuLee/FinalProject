package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Service;

import com.dao.MemberDao;
import com.model.MemberBean;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	public int checkMemberId(String id) throws Exception{
		return memberDao.checkMemberId(id);
	}
	
	public MemberBean pwFind(MemberBean m)throws Exception {
		return memberDao.pwFind(m);
	}
	
	public void joinMember(MemberBean member) throws Exception{
		memberDao.joinMember(member);
	}
	
	public MemberBean userCheck(String id) throws Exception{
		return memberDao.userCheck(id);		
	}
}

