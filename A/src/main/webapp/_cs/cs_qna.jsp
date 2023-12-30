<%@page import="com.itwillbs.domain.PageDTO"%>
<%@page import="com.itwillbs.domain.QnaBoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../_common/commonHeaderStart.jsp" %>
<%@include file ="../_common/commonHeaderEnd.jsp" %>

	<main id="main">
<%
	ArrayList<QnaBoardDTO> qnaBoardList = (ArrayList<QnaBoardDTO>)request.getAttribute("qnaBoardList");
	PageDTO pageDTO = (PageDTO)request.getAttribute("pageDTO");
%>	
			
		<section class="category-section" id="">
			<div class="container" data-aos="fade-up">
				<!-- 이곳에 코드작성 -->
				<div class="section-header d-flex justify-content-between align-items-center mb-5">
					<h2>1:1문의</h2>
					<div>
						<a href="cs_qna_write.cs" class="more " style="font-size: 18px;">
							1:1문의 글쓰기
						</a>
					</div>
				</div>
			</div>
		</section>
		  
		<section class="category-section" id="">
			<div class="container" data-aos="fade-up">
				<!-- 이곳에 코드작성 -->
				  <div class="row">
				    <div class="col-md-6 offset-md-3">
				      <div class="bg-light">
				        <ul class="d-flex flex-wrap justify-content-between list-unstyled">
				          <li><a href="cs_center.cs">공지사항</a></li>
				          <li><a href="cs_exque.cs">자주찾는질문</a></li>
				          <li><a href="cs_qna.cs">1:1문의</a></li>
				          <li><a href="cs_lost.cs">분실물</a></li>
				        </ul>
				      </div>
				    </div>
				  </div>
			</div>
		</section>
		
		<section class="category-section" id="" style="padding: 0px;">
			<div class="container" data-aos="fade-up">
				<div class="d-flex justify-content-between">
				  <div class="col-md-2">
					<div class="input-group mb-3">
					  <select class="form-select" id="qnaCategory" name="qnaCategory">
						<option selected class="text-muted">카테고리</option>
						<option value="상영작">상영작</option>
						<option value="예매">예매</option>
						<option value="기타">기타</option>
					  </select>
					</div>
				  </div>
				  <div class="col-md-3">
				    <div class="input-group mb-3">
<!-- 				      <input type="text" class="form-control" placeholder="검색어를 입력해주세요." aria-label="input-search" aria-describedby="button-addon2"> -->
<!-- 				      <button class="btn btn-secondary" type="button" id="button-addon2">검색</button> -->
				    </div>
				  </div>
				</div>
			</div>
		</section>
		
		<section class="category-section" id="">
			<div class="container" data-aos="fade-up">
				<table class="table">
				  <thead>
				    <tr class="table-secondary">
				      <th scope="col">#</th>
				      <th scope="col">카테고리</th>
				      <th scope="col">제목</th>
				      <th scope="col">글쓴이</th>
				    </tr>
				  </thead>
				  <tbody id="tbody">
				  	<c:forEach var="qnaBoardDTO" items="${qnaBoardList }">
				  	 <tr> 
				  		<th scope="row">${qnaBoardDTO.rn }</th>
				  		<td>${qnaBoardDTO.qnaCategory }</td><!-- 이 글을 클릭 가능하게 하는 것은 운영자와 당사자만 가능하게 하자.  -->
				        <td><a href="cs_qna_content.cs?createUser=${qnaBoardDTO.createUser }&createDate=${qnaBoardDTO.createDate}"> ${qnaBoardDTO.qnaSubject } </a></td>
				        <td>${qnaBoardDTO.createUser }</td>
				  	 </tr>
				  	</c:forEach>
				    
				  </tbody>
				</table>
			</div>
		</section>
		<section class="category-section" id="">
			<div class="container" data-aos="fade-up">
				<div class="pagination-container d-flex justify-content-center">
				  <ul class="pagination">
					<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
					    <li class="page-item disabled">
					      <a class="page-link text-secondary" href="cs_qna.cs?pageNum=${pageDTO.startPage - pageDTO.pageBlock }" tabindex="-1" aria-disabled="true">이전</a>
					    </li>
				    </c:if>	
				    <c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
					    <li class="page-item" aria-current="page">
					      <a class="page-link text-secondary" href="cs_qna.cs?pageNum=${i }">${i }</a>
					    </li>
				    </c:forEach>
		    		<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
					    <li class="page-item">
					      <a class="page-link text-secondary" href="cs_qna.cs?pageNum=${pageDTO.startPage + pageDTO.pageBlock}">다음</a>
					    </li>
				    </c:if>
				  </ul>
				</div>
			</div>
		</section>
	</main>
	
<%@include file="../_common/commonFooterStart.jsp"%>
<script src="./jQuery/jquery-3.6.0.js"></script>
<script type="text/javascript">
$('#qnaCategory').change(function() {
	 $.ajax({
 	    url: 'cs_qna.cs',  // 서버의 URL을 입력
 	    type: 'GET',  // 요청 유형을 'GET'으로 설정
 	    data: {'qnaCategory': $('#qnaCategory').val()},
 	    success: function(response) {
// 			alert("검색 성공");
			var searches = response;
			$('#tbody').empty();
  	       
			searches.forEach(function(search) {
                // 새로운 행(<tr>)을 생성하고 각 칼럼(<td>)에 데이터 추가
                var newRow = $('<tr></tr>');
                newRow.append($('<td></td>').text(search.rn));  
                newRow.append($('<td></td>').text(search.qnaCategory));  
                newRow.append($('<td></td>').html('<a href="cs_qna_content.cs?createUser=' + encodeURIComponent(search.createUser) + '&createDate=' + encodeURIComponent(search.createDate) + '">' + search.qnaSubject + '</a>'));
                newRow.append($('<td></td>').text(search.createUser));

                // 완성된 행을 tbody에 추가
                $('#tbody').append(newRow);
            });
  	    },
 	    error: function() {
 	        // 요청 처리 중 오류가 발생했을 때 실행될 코드
 	        alert("요청 중 오류가 발생했습니다.");
 	    }
 	});
});
</script>
<%@include file="../_common/commonFooterEnd.jsp"%>