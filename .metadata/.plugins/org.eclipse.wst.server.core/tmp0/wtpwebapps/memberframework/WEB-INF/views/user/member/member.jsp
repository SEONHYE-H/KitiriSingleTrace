<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/template/header.jsp"%>

<script type="text/javascript">
var cnt = 1;

$(document).ready(function() {
	$("#id").keyup(function() {
		var id = $("#id").val();
		if((id.length) < 5 || (id.length > 16)){
			cnt =1;
			$("#idresult").css("color", "gray");
			$("#idresult").text("아이디는 5자 이상 16자 이하입니다.");
		}else{
			$.ajax({
				type: "GET",
				url:"${root}/user/idcheck.kitri",
				dataType:"json",
				data:{"checkid" :id},
				success: function(data) {
					cnt = parseInt(data.idcount);
					if(cnt ==0){
						$("#idresult").css("color", "steelblue");
						$("#idresult").html("<strong>"+id +"</strong>는 사용 가능합니다.");
					}else{
						$("#idresult").css("color", "magenta");
						$("#idresult").html("<strong>"+id +"</strong>는 사용중입니다.");
					}
				}
			});
		}
	});
	
// 	클릭 말고도 TAB을 활용할 수 있도록
	$('#zipcode').focusin(function() {
		$('#zipModal').modal();
	});
	
	 $('#registerBtn').click(function () {
	 	if($('#id').val().trim().length ==0){
	 		alert("아이디입력 !!!!");
	 		return;
	 	}else if($('#name').val().trim().length ==0){
	 		alert("이름 입력!!!!");
	 		return;
	 	}else if($('#pass').val().trim().length ==0){
	 		alert("비밀번호 입력!!!!");
	 		return;
	 	}else if(cnt != 0){
	 		alert("아이디 중복 확인");
	 		return;
	 	}else{
	 		$("#memberform").attr("action", "${root}/user/register.kitri").submit();
	 	}
	 }); 
	 $('#modifyBtn').click(function() {
			if($('#id').val().trim().length ==0){
		 		alert("아이디입력 !!!!");
		 		return;
		 	}else if($('#name').val().trim().length ==0){
		 		alert("이름 입력!!!!");
		 		return;
		 	}else if($('#pass').val().trim().length ==0){
		 		alert("비밀번호 입력!!!!");
		 		return;
		 	}else{
		 		$("#memberform").attr("action", "${root}/user/modify.kitri").submit();
		 	}
	 });
});

</script>
</head>
<body>
	<div class="container" align="center">
		<div class="col-lg-6" align="center">
			<c:choose>
				<c:when test="${userInfo.id == null}">
					<h2>회원가입</h2>
				</c:when>
				<c:when test="${userInfo.id != null}">
					<h2>회원정보변경</h2>
				</c:when>
			</c:choose>

			<form id="memberform" method="post" action="">
				<input type="hidden" name="act" value="register">
				<div class="form-group" align="left">
				<label for="name">이름</label>
					<c:if test="${userInfo.id == null}">
					 <input type="text" class="form-control" id="name" name="name" placeholder="이름입력">
					</c:if>
					<c:if test="${userInfo.id != null}">
					 <input type="text" class="form-control" id="name" name="name" placeholder="이름입력" value= "${userInfo.name}">
					</c:if>	
				</div>
				<div class="form-group" align="left">
				<label for="">아이디</label>
					<c:if test="${userInfo.id == null}">
							<input type="text" class="form-control" id="id" name="id" placeholder="4자이상 16자 이하" >
							<div id="idresult"></div>
					</c:if>
					<c:if test="${userInfo.id != null}">
							<input type="text" class="form-control" id="id" name="id" placeholder="4자이상 16자 이하" readonly="readonly"
							value= "${userInfo.id}">
					</c:if>
				</div>
				
				<div class="form-group" align="left">
				<label for="">비밀번호</label>
					<c:if test="${userInfo.id == null}">
						<input type="password" class="form-control" id="pass" name="pass" placeholder="">
					</c:if>
					<c:if test="${userInfo.id != null}">
						<input type="password" class="form-control" id="pass" name="pass" placeholder="" value ="${userInfo.pass}">
					</c:if>
					 
				</div>
				<div class="form-group" align="left">
					<label for="">비밀번호재입력</label> 
					<c:if test="${userInfo.id == null}">
						<input type="password" class="form-control" id="passcheck" name="passcheck" placeholder="">
					</c:if>
					<c:if test="${userInfo.id != null}">
						<input type="password" class="form-control" id="passcheck" name="passcheck" placeholder="" value ="${userInfo.pass }">
					</c:if>
					
				</div>
				<div class="form-group" align="left">
					<label for="email">이메일</label><br>
					<div id="email" class="custom-control-inline">
						<input type="text" class="form-control" id="emailid"
							name="emailid" placeholder="" size="25"> @ <select
							class="form-control" id="emaildomain" name="emaildomain">
							<option value="naver.com">naver.com</option>
							<option value="google.com">google.com</option>
							<option value="daum.net">daum.net</option>
							<option value="nate.com">nate.com</option>
							<option value="hanmail.net">hanmail.net</option>
						</select>
					</div>
				</div>
				<div class="form-group" align="left">
					<label for="tel">전화번호</label>
					<div id="tel" class="custom-control-inline">
						<select class="form-control" id="tel1" name="tel1">
							<option value="010">010</option>
							<option value="02">02</option>
							<option value="031">031</option>
							<option value="032">032</option>
							<option value="041">041</option>
							<option value="051">051</option>
							<option value="061">061</option>
						</select> _ <input type="text" class="form-control" id="tel2" name="tel2"
							placeholder="1234"> _ <input type="text"
							class="form-control" id="tel3" name="tel3" placeholder="5678">
					</div>
				</div>
				<div class="form-group" align="left">
					<label for="">주소</label><br>
					<div id="addressdiv" class="custom-control-inline">
						<input type="text" class="form-control" id="zipcode"
							name="zipcode" placeholder="우편번호" size="7" maxlength="5"
							readonly="readonly">
					</div>
					<input type="text" class="form-control" id="address" name="address"
						placeholder="" readonly="readonly"> <input type="text"
						class="form-control" id="address_detail" name="addressDetail"
						placeholder="" readonly="readonly">
				</div>
				<div class="form-group" align="center">
					<c:choose>
						<c:when test="${userInfo.id != null}">
							<button type="button" class="btn btn-primary" id="modifyBtn">정보변경</button>
						</c:when>
						<c:when test="${userInfo.id == null}">
							<button type="button" class="btn btn-primary" id="registerBtn">회원가입</button>
							<button type="reset" class="btn btn-warning">초기화</button>
						</c:when>
					</c:choose>			
					
				</div>
			</form>
		</div>
	</div>

	<%@include file="/WEB-INF/views/user/member/zipsearch.jsp"%>
	<%@include file="/WEB-INF/views/template/footer.jsp"%>