<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <jsp:include page="../_common/meta.jsp"></jsp:include>
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath }/_assets/css/mypage.css">
  <link href="_assets/js/findIdPass.js">
    <script src="http://code.jquery.com/jquery-3.6.4.min.js"></script>
  <jsp:include page="../_common/header.jsp"></jsp:include>





</head>
<body>

	<main id="main">
		<section class="category-section">
			<div class="container w-50" data-aos="fade-up">
				<!-- 이곳에 코드작성 -->

				<!-- member-wrap -->
				<div class="member-wrap">
			
					<!-- col-wrap -->
					<div class="col-wrap">
						<!-- col -->
						<div class="col">
			
							<p class="tit-member">아이디/비밀번호 찾기<!--아이디/비밀번호 찾기--></p>
			
							<div class="tab-list">
								<ul>
									<li class="on"><a href="javaScript:void(0);" title="아이디찾기 선택">아이디 찾기<!--아이디찾기--></a></li>
									<li><a href="passfind.me" title="비밀번호 찾기 선택">비밀번호 찾기<!--비밀번호 찾기--></a></li>
								</ul>
							</div>
			
							<h2 class="tit mt40">간편찾기<!--간편찾기--></h2>
			
							<div class="table-wrap">
								<table class="board-form">
									<caption>이름, 생년월일, 휴대폰 번호 항목을 가진 아이디 찾기 입력 표<!--이름, 생년월일, 휴대폰 번호 항목을 가진 아이디 찾기 입력 표--></caption>
									<colgroup>
										<col style="width:130px;">
										<col>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><label for="name">이름<!--이름--></label></th>
											<td>
												<input id="name" maxlength="20" type="text" placeholder="이름" class="input-text w230px"><!--이름-->
											</td>
										</tr>
										<tr>
											<th scope="row"><label for="birth">생년월일<!--생년월일--></label></th>
											<td>
												<input id="birth" maxlength="8" type="text" placeholder="생년월일 8자리" class="input-text w230px"><!--생년월일 8자리-->
												<div id="schIdBirthDe-error-text" class="alert"></div>
											</td>
										</tr>
										<tr>
											<th scope="row"><label for="phone">휴대폰 번호<!--휴대폰 번호--></label></th>
											<td>
												<input id="phone"  maxlength="11" type="text" placeholder="'-' 없이 입력" class="input-text w230px"><!--'-' 없이 입력-->
												<div id="schIdMblpNo-error-text" class="alert"></div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
			
			
							<div class="btn-member-bottom v1">
								<button id="btnSchId" type="button" class="button purple large" disabled="disabled">아이디 찾기<!--아이디 찾기--></button>
			
							</div>
			
			
						</div>
						<!--// col -->
					</div>
					<!--// col-wrap -->
				</div>
				<!--// member-wrap -->
	


			</div>
		</section>
<!-- 		<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div> -->
<!-- 		<div class="alertStyle" style="position: fixed; top: 0px; left: 0px; background: rgb(0, 0, 0); opacity: 0.7; width: 100%; height: 100%; z-index: 5005; display: block;"></div> -->
<!-- 		<section class="alert-popup" style="position: fixed; padding-top: 45px; background: rgb(255, 255, 255); z-index: 5006; top: 434.5px; left: 866.5px; width: 400px; opacity: 1;"  -->
<!-- 					id="layerId_041614172385406745"> -->
<!-- 			<div class="wrap"> -->
<!-- 				<header class="layer-header"> -->
<!-- 					<h3 class="tit">알림</h3> -->
<!-- 				</header> -->
<!-- 				<div class="layer-con" style="height:250px"> -->
<!-- 					<p class="txt-common">회원님의 아이디는 [goodtime5**] 입니다.<br>가입일 : 2022-07-30</p> -->
<!-- 					<div class="btn-group"> -->
<!-- 						<button type="button" class="button lyclose" style="display: none;"></button> -->
<!-- 						<button type="button" class="button purple confirm">확인</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<button type="button" class="btn-layer-close">레이어 닫기</button> -->
<!-- 			</div> -->
<!-- 		</section> -->
	</main>
	
<%@include file ="../_common/commonFooterStart.jsp" %>
<script type="text/javascript">


</script>


<script type="text/javascript">
var sValidateSchIdMbNm       = "N";
var sValidateSchIdBirthDe    = "N";
var sValidateSchIdMblpTelno  = "N";
	
//이벤트
$(function(){
	fn_validateSchIdInputVal();
//////////////////////////////////////////////////////////////////////////////////////////////////////	
	/* /[^ㄱ-힣a-zA-Z\s]/g */
	/* 이름 숫자,영어를 제외한 입력 여부판단 */
	$("#name").on("keyup", function(e){
		var partton = /[^가-힣\s]{2,5}$/g;
		if(partton.test($(this).val())) {
			var value = $(this).val().replace(/[^가-힣\s]{2,5}$/g,"");
			$("#name").val(value);
		}
		if(fn_validateSchIdInputVal()) {
			if(e.keyCode == 13){$("#btnSchId").click();}
		} else {
			if(e.keyCode == 13){$("#birth").focus();}
		}
	});
	$("#name").focusout(function(){
		var partton = /[^가-힣\s]{2,5}$/g;
		if(partton.test($(this).val())) {
			var value = $(this).val().replace(/[^가-힣\s]{2,5}$/g,"");
			$("#name").val(value);
        }
		fn_validateSchIdInputVal();
	});
/////////////////////////////////////////////////////////////////////////////////////////////////////
	/* 생년월일 숫자만 입력 여부판단 */
	$("#birth").on("keyup", function(e){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		if(fn_validateSchIdInputVal()) {
			if(e.keyCode == 13){$("#btnSchId").click();}
		} else {
			if(e.keyCode == 13){$("#phone").focus();}
		}
	});
	$("#birth").focusout(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		fn_validateSchIdInputVal();
	});

	/* 휴대폰번호 숫자만 입력 여부판단 */
	$("#phone").on("keyup", function(e){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		if(fn_validateSchIdInputVal()){
			if(e.keyCode == 13){$("#btnSchId").click();}
		}
	});
	$("#phone").focusout(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		fn_validateSchIdInputVal();
	});

	/* 확인 */
// 	$("#btnSchId").click(function(){
// 		/* 폼데이터 초기화 */
// 		$('#searchIdForm input[name=loginId]').attr('value','');
// 		$('#searchIdForm input[name=mblpTelno]').attr('value','');
// 		$('#searchIdForm input[name=mbNo]').attr('value','');
// 		$('#searchIdForm input[name=certType]').attr('value','');

// 		var sSchIdMbNm      = $("#name").val();			//이름
// 		var sSchIdBirthDe   = $("#birth").val();		//생년월일
// 		var sSchIdMblpTelno = $("#phone").val();	//휴대폰번호
// 		var paramData = { mbNm:sSchIdMbNm
// 						, birthDe:sSchIdBirthDe
// 						, mblpTelno:sSchIdMblpTelno
// 						};

// 		fn_selectMbSchId(paramData);
// 	});

});




//입력 문자 체크
function fn_validateSchIdInputVal(){

	//이름
	if($("#name").val() != "") {
		sValidateSchIdMbNm = 'Y';
	}
	else {
		sValidateSchIdMbNm = 'N';
	}

	//생년월일
	if($("#birth").val() != "") {
		if(fn_validateDateYn($("#birth").val(),8)){
			sValidateSchIdBirthDe = 'Y';
			$('#schIdBirthDe-error-text').text('');
		}
		else {
			sValidateSchIdBirthDe = 'N';
			$('#schIdBirthDe-error-text').text('생년월일을 정확히 입력해주세요.');
		}
	}
	else {
		sValidateSchIdBirthDe = 'N';
	}

	//휴대폰번호
	if($("#phone").val() != "") {
		var frontNm = $("#phone").val().substr(0,2);
		if(frontNm != '01'){
			$('#schIdMblpNo-error-text').text('휴대폰번호를 정확히 입력해주세요.');
			sValidateSchPwdCertNo = 'N';
		}
		else {
			$('#schIdMblpNo-error-text').text('');
			sValidateSchIdMblpTelno = 'Y';
		}
	}
	else {
		sValidateSchIdMblpTelno = 'N';
	}

	if(    sValidateSchIdMbNm == 'Y'
		&& sValidateSchIdBirthDe == 'Y'
		&& sValidateSchIdMblpTelno == 'Y'
		){
		$("#btnSchId").attr("disabled", false);
		return true;
	}
	else{
		$("#btnSchId").attr("disabled", true);
		return false;
	}
}
// function fn_submit(page){

// 	$("#searchIdForm").attr("method","post");
// 	$("#searchIdForm").attr("action",page);
// 	$("#searchIdForm").submit();
// }
</script>
<%@include file ="../_common/commonFooterEnd.jsp" %>