<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="ko">
 	 <head>
 	 	<meta charset="UTF-8" />
    	<link rel="icon" type="image/png" href="/favicon.png" />
    	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    	<title>리뷰 쓰기페이지</title>
    	<link rel="preconnect" href="https://fonts.googleapis.com" >
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Nanum+Myeongjo&family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Orelega+One&display=swap" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css" >
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
    	<style>
			.star {
			  font-size: 30px;
			  color: #ccc; /* 비활성 별 색 */
			  cursor: pointer;
			}
			.star.active {
			  color: gold; /* 활성 별 색 */
			}
		</style>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    	<script src="https://cdn.portone.io/v2/browser-sdk.js" async defer></script>
    	<link href="${pageContext.request.contextPath}/resources/css/the_best_styles.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<header>
			<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
		</header>
		
		<main id="container">
	
			<jsp:include page="/WEB-INF/views/clish/myPage/side.jsp"></jsp:include>
		
			<div id="main">
				<form action="/myPage/myReview/writeReview" method="post" enctype="multipart/form-data">
					<input type="text" value="${reservationClassInfo.class_idx }" name="classIdx" hidden>
					<input type="text" value="${reservationClassInfo.user_idx }" name="userIdx" hidden>
					<table>
						<tr>
							<th>강의 명</th>
							<td><input type="text" value="${reservationClassInfo.class_title }" name="classTitle" readonly></td>
						</tr><tr>
							<th>수업 일</th>
							<td><input type="text" value="${reservationClassInfo.reservation_class_date}" readonly></td>
						</tr><tr>
							<th>주문 번호</th>
							<td><input type="text" value="${reservationClassInfo.reservation_idx}"name="reservationIdx" readonly></td>
						</tr><tr>
							<th>평가 점수</th>
							<td>
			<!-- 					<input type="text" placeholder="0점 ~ 5점" name="reviewScore" > -->
									<div class="star-rating">
										<span class="star">&#9733;</span>
										<span class="star">&#9733;</span>
										<span class="star">&#9733;</span>
										<span class="star">&#9733;</span>
										<span class="star">&#9733;</span>
										<input type="hidden" id="score" name="reviewScore" value="0" />
									</div>
							</td>
						</tr><tr>
						</tr><tr>
							<th>리뷰 제목</th>
							<td><input type="text" placeholder="제목을 작성해 주세요" name="reviewTitle" ></td>
						</tr><tr>
							<th>리뷰 내용</th>
							<td><textarea rows="15" cols="50" placeholder="리뷰 입력" name="reviewDetail"></textarea></td> 
						</tr>
					</table>
					<label for="file">첨부파일</label>
						
					<input type="file" class="custom-file-input" name="files" multiple>
			
					<input type="submit" value="리뷰등록" >
					<input type="reset" value="초기화">
					<input type="button" value="취소" onclick="history.back()">
		 		</form>
	 		</div>
	
		</main>
	 		
		<footer>
			<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
		</footer>
		<script>
			$(function(){
			    let lastScore = 0;
			  $(".star-rating .star").click(function(){
			    const index = $(this).index();
			    let score = index + 1;
			    
			    console.log(lastScore);
			    if(score === 1 && lastScore === 1) {
			    	score = 0;
		    	}
			    lastScore = score;
			    $("#score").val(score);
			    $(this).parent().children(".star").each(function(i){
			      if(i < score){
			        $(this).addClass("active");
			      } else {
			        $(this).removeClass("active");
			      }
			    });
			  });
			});
		</script>
	</body>
</html>