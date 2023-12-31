<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../_common/commonHeaderStart.jsp"%>
	
<link rel="stylesheet" href="_assets/css/signup4.css">
<script src="jQuery/jquery-3.6.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 주소 api  -->

<%@include file="../_common/commonHeaderEnd.jsp"%>

<main id="main">

	<section class="category-section">
		<div class="container col-5" data-aos="fade-up">
			<div class="section-header d-flex justify-content-between align-items-center mb-5">
				<h2>회원가입</h2>
			</div>
			<div class="container">
					<form  class=""  onsubmit="return checkSubmit()" action="joinPro.me" id="fr">
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="id" placeholder="5자 이상" minlength="5" required 
									onblur="checkId()" name="id"> 
							<label for="id">아이디<span id="CheckId" style="font-size: 15px;"></span></label>
	
						</div>
						<div class="form-floating mb-3">
							<input type="password" class="form-control" id="passwd" placeholder="비밀번호" required
									onblur="checkPass(); checkConfirmPasswd();" name="pass">
							<label  for="passwd">비밀번호<span id="CheckPassword1"></span></label> 
	
						</div>
						<div class="form-floating mb-3">
							<input type="password" class="form-control" id="passwd2" placeholder="비밀번호 확인" required
									onchange="checkConfirmPasswd()">
							<label for="passwd2">비밀번호 확인<span id="CheckPassword2"></span></label>
	
						</div>
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="name" placeholder="이름" required
									onblur="checkName()" name="name">
							<label for="name">이름<span id="CheckName"></span></label>
						</div>
						<div class="form-floating mb-3">
							<input type="tel" class="form-control" id="phone" placeholder="연락처" required
									onblur="checkPhone()" name="phone">
							<label for="phone">연락처<span id="CheckPhone"></span></label>
						</div>
						<div class="form-floating mb-3 row g-2">
							<div class="col-5">
								<div class="form-floating">
									<input type="text" class="form-control" id="postcode" placeholder="우편번호" readonly name="postcode" >
									<label for="address1">우편번호</label>
								</div>	
							</div>	
							<div class="col-3">	
								<input type="button" class="btn btn-danger btn-lg" type="button" style="height:58px;"
										id="find_button" value="우편번호 찾기">
							</div>
						</div>
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="address1" placeholder="주소" required readonly name="address1">
							<label for="address1">주소</label>
						</div>	
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="address2" placeholder="상세주소 입력" required name="address2">
							<label for="address2">상세주소 입력</label>
						</div>	
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="birth" placeholder="생년월일8자" maxlength="10" required
									onblur="checkBirth()" name="birth">
							<label for="birth">생년월일 8자리<span id="CheckBirth"></span></label>
						</div>
						
												
						<div class="row">
							<div class="col-9">
								<div class="form-floating mb-3">
									<input type="email" class="form-control" id="email" placeholder="name@example.com" required
											onblur="checkEmail()" name="email">
									<label for="email">이메일<span id="CheckEmail"></span></label>
								</div>	
							</div>	
							<div class="col-3">	
								<button onclick="emailAuthentication()" id="eamilAuthBtn" disabled="disabled" class="btn btn-danger btn-lg" type="button" style="height:58px;">인증번호 발송</button>
							</div>
						</div>
						
						
						<div class="row justify-content-md-center">
							<div class="col-4">
								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="emailCheck" placeholder="인증번호 입력" >
									<label for="emailCheck">인증번호 입력</label>
								</div>	
							</div>	
							<div class="col-3">	 
								<button onclick="authCodeCheck()" id="authCodeCheckBtn" class="btn btn-danger btn-lg" type="button" style="height:58px;">인증하기</button>
							</div>
						</div>
						<div class="d-grid gap-2" style="margin-top: 50px">
							<button class="btn btn-danger btn-lg" type="submit" id="joinbtn" disabled="disabled">가입</button>
						</div>
					</form>
			</div>
		</div>
	</section>

</main>

<%@include file="../_common/commonFooterStart.jsp"%>
<script>
	
	$(function(){
		
		
		$("#find_button").on('click', function() {
		    new daum.Postcode({
		        oncomplete: function(data) {
		        	console.log(data);
		            
		        	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
		            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
		            var fullAddr= '';
		            var extraAddr='';
		            
		            if(data.userSelectoredType === 'R'){
		            	fullAddr = data.roadAddress;
		            } else{
		            	fullAddr = data.jibunAddress;
		            }
		            
		            // extraAddr 
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }	                    
                    // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }		            
                    // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                    if(fullAddr !== ''){
                        fullAddr += extraAddr;
                    }                    
                    
		            $("#postcode").val(data.zonecode); 
		            $("#address1").val(fullAddr);
		            $("#address2").focus();
		            
		        }
		    }).open();
		});
		
		
	});

</script>

<script>


// 회원가입 정규식
var empJ = /\s/g; // 공백 정규식
var RegexID = /^[a-zA-Z0-9]{5,16}$/; // 영문 대소문자 숫자 특수문자 5~16자 규칙(아이디)
//var RegexID = /^(?=.*[a-z0-9])[a-z0-9]{3,16}$/; // 영문 대소문자 숫자 특수문자 5~16자 규칙(아이디)
var lengthRegexPass = /^[A-Za-z0-9!@#$%]{8,16}$/; // 영문 대소문자 숫자 특수문자 8~16자 규칙(패스워드)
var engUpperRegex = /[A-Z]/; //대문자 규칙 (비밀번호)
var engLowerRegex = /[a-z]/;  //소문자 규칙 (비밀번호)
var numRegex = /[0-9]/;	// 숫자 0~9 규칙 (비밀번호)
var numRegex1 = /^[0-9]+$/;	// 숫자만 입력
var specRegex = /[!@#$%]/;	// 특수문자 규칙 (비밀번호)
var nameRegex = /^[가-힣]{2,5}$/; // 한글 2~5자 규칙 (이름)
var phoneRegex =/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/; // 모든 전화번호 규칙 (연락처)
var birthRegex1 = /^\d{4}\d{2}\d{2}$/; //? YYYYMMDD 형식의 정규식 (생년월일)
var birthRegex2 = /^(19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])$/; //YYYYMMDD 각 자리에 유효한 생년월일인지 확인 (생년월일)
var emailRegex =  /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; // 이메일형식 규칙(이메일)

var checkCodee;

// 변수저장
// var id = $("#id").val();
// var passwd = $("#passwd").val();
// var passwd2 = $("#passwd2").val();


// 아이디 유효성 및 중복체크
function checkId() {
	var id = $("#id").val();
// 	debugger;
	if(id==""){
		$("#CheckId").text("아이디를 입력하세요").css("color", "red");
		return false;			
	}else if(!RegexID.test(id)){
		$("#CheckId").text("영문 대소문자,숫자 5~16자리 아이디 입력 ").css("color", "red");
		return false;
	}else if(numRegex1.test(id)){
		$("#CheckId").text("영문 대소문자,숫자 5~16자리 아이디 입력1 ").css("color", "red");
		return false;
	}
		
		$.ajax({
			type : "post",
			
			data : {memId : id}, //입력한 값 변수에 담기
			url : "checkjoin.me", 
			dataType: "text",
			success:function(data){
// 				debugger;
				if(data == '1'){
					$("#CheckId").text("사용중인 아이디입니다.").css("color", "red");
					return false;
				}else if(data == '0'){
					$("#CheckId").text("사용가능한 아이디입니다.").css("color", "green");
					return true;
				 }		
			},
			error: function(){
			}
		});
	}
// }

// 이메일 유효성 체크 및 인증번호체크
function checkEmail() {
	var email = $("#email").val();
	if(email == ""){
		$("#CheckEmail").text("** 본인인증 이메일 입력 필수 **").css("color", "red");
		return false;
	}else if(!emailRegex.test(email)){
		$("#CheckEmail").text("** name@example.com 형식에 맞게 입력! **").css("color", "red");
		return false;
	}else{
		$.ajax({
			type : "post",
			data : {memEmail : email},
			url	 : "checkemail.me",
			dataType : "text",
			success:function(data){
// 				debugger;
				if(data == '1'){
					$("#CheckEmail").text("사용중인 이메일입니다").css("color", "red");
					return false;
				}else if(data == '0'){
					$("#CheckEmail").text("사용가능한 이메일입니다").css("color", "green");
// 					debugger;
					$("#eamilAuthBtn").attr("disabled" , false);
					
					return true;
				}
			},
			error: function(){
				
			}
			
		});
	}
		
}


// 이메일 인증번호 발송 및 인증
function emailAuthentication() {
	var email = $("#email").val()
	$.ajax({
		type : "post",
		url : "emailCode.me",
		dataType : "text",
		data : {email : email},
		success:function(data){
// 			debugger;
			alert("인증번호 보내기 성공");
			checkCodee = data;
			
		},
		error: function () {
			
		}
	});
}



// 이메일 인증 번호 확인하기 버튼
function authCodeCheck() {
	debugger;
	if($("#emailCheck").val() == checkCodee){
		alert('인증 성공');
		$("#joinbtn").attr("disabled" , false);
	} else{
		alert('인증 실패');
	}
	
}


// 비밀번호 유효성
function checkPass(){
	var passwd = $("#passwd").val();
	var text =' ** 비밀번호 입력 필수 **';
	var color='red';
	var count = 0;
	
	if(passwd != ""){
		
		if(lengthRegexPass.test(passwd)){
			
			
			if(engUpperRegex.test(passwd))	count ++;
			if(engLowerRegex.test(passwd))	count ++;
			if(numRegex.test(passwd)) 		count ++;
			if(specRegex.test(passwd))		count ++;
			
			switch(count){
				case 4: text = ' **사용 가능 : 안전**';
						color = 'green'; break;
				case 3: text = ' **사용 가능 : 보통**';
						color = 'blue'; break;
				case 2: text = ' **사용 가능 : 위험**';
						color = 'orange'; break;
				default: text = ' **영문자, 숫자, 특수문자 중 2가지 이상 조합 필수!**';
						color = 'red'; break;
			}

		} else{
			text ='영문 대소문자 숫자 특수문자 8~16자 입력'
		}
		
		
	}
	$("#CheckPassword1").text(text).css("color", color);
};

// 비밀번호 확인 유효성		
function checkConfirmPasswd() {
	var passwd = $("#passwd").val();
	var passwd2 = $("#passwd2").val();
	var text = '**비밀번호 불일치**';
	var color = 'red';
	if( passwd == passwd2 && passwd != ""){
		text='**비밀번호 일치**';
		color='green';
		
	}
	$("#CheckPassword2").text(text).css("color", color);
}		

// 이름 정규식 유효성
function checkName() {
	var name = $("#name").val();
	var text = "** 이름 입력 필수! **";
	var color = "red";
	
	if(name != ""){
		text = "** 2~5자 이상 한글이름 입력!**";
		if(nameRegex.test(name)){
			text = "** 사용가능 **";
			color = "green";
		}
	}
	$("#CheckName").text(text).css("color",color);
}

// 연락처 정규식 유효성
function checkPhone() {
	var phone = $("#phone").val();
	var text = "** 연락처 입력 필수! **"
	var color = "red";
	
	if(phone != ""){
		text = "** 알맞은 연락처 형식으로 입력! '-' 생략가능!! **";
		
		if(phoneRegex.test(phone)){
			text = "** 알맞은 연락처 형식! ** ";
			color = "green";
		}
	}
	$("#CheckPhone").text(text).css("color",color);
}

// 생년월일 8자 정규식 유효성
function checkBirth() {
	var birth = $("#birth").val();
	var text = "** 생년월일 필수 입력! **";
	var color = "red";
	
	if(birth != "" || !birthRegex1.test(birth)){
		text = "** YYYYMMDD 형식의 유효한 생년월일 입력!";
		
		if(birthRegex2.test(birth)){
			text = "** 유효한 생년월일 **";
			color = "green";
		}
	}
	$("#CheckBirth").text(text).css("color", color);
}

// 이메일 정규식 유효성
// function checkEmail() {
// 	var email = $("#email").val();
// 	var text = "** 본인인증 이메일 필수 입력! **";
// 	var color= "red";
	
// 	if(email != ""){
// 		text = "** name@example.com 형식에 맞게 입력! **";
		
// 		if(emailRegex.test(email)){
// 			text = "** 유효한 이메일 ** ";
// 			color = "green";
// 		}
// 	}
	
// 	$("#CheckEmail").text(text).css("color" , color);
// }


// 유효성 체크 후 submit
function checkSubmit() {
	
	var color = $('#fr span');
	
	var flag = 1;
	
	$.each(color, function(i, v){
		if(this.style.color == "red") {
			flag = 0;
			alert("회원가입 양식을 확인해 주세요.")
			return false;
		}
	});
	
	return ((flag == 0) ? false : true);
}	





</script>
<%@include file="../_common/commonFooterEnd.jsp"%>