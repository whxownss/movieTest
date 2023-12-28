package com.itwillbs.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.itwillbs.dao.CSBoardDAO;
import com.itwillbs.domain.CenterBoardDTO;
import com.itwillbs.domain.ExqBoardDTO;
import com.itwillbs.domain.PageDTO;

public class CSBoardService {
	CSBoardDAO csBoardDAO = null;

	public ArrayList<ExqBoardDTO> getExqBoardList(PageDTO pageDTO) {
		System.out.println("CSBoardService getExqBoardList()");
		ArrayList<ExqBoardDTO> exqBoardList = null;
		
		try {
			// 시작하는 행번호 구하는 식
			int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
			// 끝나는 행번호 구하는 식
			int endRow = startRow + pageDTO.getPageSize() -1;			
			csBoardDAO = new CSBoardDAO();
			pageDTO.setStartRow(startRow-1);
			pageDTO.setPageSize(pageDTO.getPageSize());
			
			exqBoardList = csBoardDAO.getExqBoardList(pageDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return exqBoardList;
	}//getExqBoardList()	
	
	public int getExqBoardCount() {
		System.out.println("CSBoardService getExqBoardCount()");
		int count = 0;
		try {
			csBoardDAO = new CSBoardDAO();
			count = csBoardDAO.getExqBoardCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}//getExqBoardCount()	
	
	public ArrayList<CenterBoardDTO> getCenterBoardList(PageDTO pageDTO) {
		System.out.println("CSBoardService getCenterBoardList()");
		ArrayList<CenterBoardDTO> centerBoardList = null;
		try {
			// 시작하는 행번호 구하는 식
			int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
			// 끝나는 행번호 구하는 식
			int endRow = startRow + pageDTO.getPageSize() -1;	
			pageDTO.setStartRow(startRow-1);
			pageDTO.setPageSize(pageDTO.getPageSize());
			csBoardDAO = new CSBoardDAO();
			centerBoardList = csBoardDAO.getCenterBoardList(pageDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return centerBoardList;
	}//getCenterBoardList()

	public int getCenterBoardCount() {
		System.out.println("CSBoardService getCenterBoardCount()");
		int count = 0;
		try {
			csBoardDAO = new CSBoardDAO();
			count = csBoardDAO.getCenterBoardCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}//getCenterBoardCount()

	public CenterBoardDTO getCenterBoard(String createUser, String createDate) {
		System.out.println("CSBoardService getCenterBoard()");
		CenterBoardDTO centerBoardDTO = null;
		try {
			csBoardDAO = new CSBoardDAO();
			centerBoardDTO = csBoardDAO.getCenterBoard(createUser,createDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return centerBoardDTO;
	}//getCenterBoard()

	public boolean updateCenterContent(HttpServletRequest request) {
	    System.out.println("CSBoardService updateCenterContent()");
	    int updateSuccess = 0;
	    try {
	        CenterBoardDTO centerBoardDTO = new CenterBoardDTO();
	        String centerSubject = request.getParameter("centerSubject");
	        String centerContent = request.getParameter("centerContent");
	        String createUser = request.getParameter("createUser");
	        String createDate = preprocessDate(request.getParameter("createDate"));
	        
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
	        LocalDateTime dateTime = LocalDateTime.parse(createDate, formatter);
	        Timestamp createTime = Timestamp.valueOf(dateTime);
	        
	        centerBoardDTO.setCenterSubject(centerSubject);
	        centerBoardDTO.setCenterContent(centerContent);
	        centerBoardDTO.setCreateUser(createUser);
	        centerBoardDTO.setCreateDate(createTime);
	        
	        csBoardDAO = new CSBoardDAO();
	        updateSuccess = csBoardDAO.updateCenterContent(centerBoardDTO);
	    } catch (DateTimeParseException dtpe) {
	        System.err.println("Date parsing failed: " + dtpe.getMessage());
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return updateSuccess > 0;
	}

	private String preprocessDate(String createDate) {
	    // 밀리초가 한 자리만 있는 경우 세 자리로 만들어줍니다.
	    if (createDate.matches(".+\\.\\d$")) {
	        return createDate + "00";
	    } else if (createDate.matches(".+\\.\\d\\d$")) {
	        return createDate + "0";
	    }
	    return createDate;
	}//updateCenterContent()

	
}//클래스
