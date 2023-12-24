package com.itwillbs.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberController extends HttpServlet {
	RequestDispatcher dispatcher = null;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sPath = request.getServletPath();
		
		// 메인 페이지 이동
		if(sPath.equals("/main.me")) {
			dispatcher = request.getRequestDispatcher("_a/main.jsp");
			dispatcher.forward(request, response);
		}
		
		
		// 로그인 페이지 이동
		if(sPath.equals("/login.me")) {
			dispatcher = request.getRequestDispatcher("_member/login.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 회원가입 페이지 이동
		if(sPath.equals("/signup3.me")) {
			dispatcher = request.getRequestDispatcher("_member/signup3.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 아이디/비밀번호 찾기 페이지 이동
		if(sPath.equals("/findmember.me")) {
			dispatcher = request.getRequestDispatcher("_member/findmember.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 아이디 찾기 페이지 이동
		if(sPath.equals("/userfind.me")) {
			dispatcher = request.getRequestDispatcher("_member/userfind.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 비밀번호 찾기 페이지 이동
		if(sPath.equals("/passfind.me")) {
			dispatcher = request.getRequestDispatcher("_member/passfind.jsp");
			dispatcher.forward(request, response);
		}//
		
		////////////////////////////////////////////////////////////////////////////////////
		
		// 마이페이지 (마이페이지 기본메인화면) 이동
		if(sPath.equals("/myPage.me")) {
			dispatcher = request.getRequestDispatcher("_mypage/myPage.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 마이페이지  myInfo(정보수정 전 비밀번호 인증페이지) 이동
		if(sPath.equals("/myInfo.me")) {
			dispatcher = request.getRequestDispatcher("_mypage/myInfo.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 마이페이지 userInfo(정보수정 페이지) 이동
		if(sPath.equals("/userInfo.me")) {
			dispatcher = request.getRequestDispatcher("_mypage/userInfo.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 마이페이지 myMovie(무비스토리) 이동
		if(sPath.equals("/myMovie.me")) {
			dispatcher = request.getRequestDispatcher("_mypage/myMovie.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 마이페이지 delete(회원탈퇴) 이동 (userInfo > delete.jsp)
		if(sPath.equals("/delete.me")) {
			dispatcher = request.getRequestDispatcher("_mypage/delete.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 마이페이지 비밀번호 변경(비밀번호변경) 이동 (userInfo > changepw.jsp)
		if(sPath.equals("/changepw.me")) {
			dispatcher = request.getRequestDispatcher("_mypage/changepw.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 마이페이지 myinquiry(문의내역) 이동
		if(sPath.equals("/myinquiry.me")) {
			dispatcher = request.getRequestDispatcher("_mypage/myinquiry.jsp");
			dispatcher.forward(request, response);
		}//
		
		// 마이페이지 bookinglist(예매내역) 이동
		if(sPath.equals("/bookinglist.me")) {
			dispatcher = request.getRequestDispatcher("_mypage/bookinglist.jsp");
			dispatcher.forward(request, response);
		}//
		
	}
	
}
