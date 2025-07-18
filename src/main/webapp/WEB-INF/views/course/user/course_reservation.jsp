<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/header.jsp"></jsp:include>
	</header>
	<main>
		<form action="/course/user/reservationSuccess" style="max-width: 800px; margin: 50px auto; padding: 40px;" method="get">
				<h1>클래스 예약 정보입력 페이지</h1>
				<h3 style="text-align: center; margin-bottom: 30px;">[ 예약 상세 정보 ]</h3>
				
				<table class="table-with-side-borders" style="width: 90%;">
					<tr>
						<th>강의명</th> <td>${classInfo.classTitle}</td>
					</tr>
					<tr>
						<th>카테고리 ID</th> <td>${classInfo.categoryIdx}</td>
					</tr>
					<tr>
						<th>수강료</th> <td>${classInfo.classPrice}</td>
					</tr>
					<tr>
						<th>정원</th> <td>${classInfo.classMember}</td>
					</tr>
					<tr>
						<th>강의 기간</th> <td>${classInfo.startDate} ~ ${classInfo.endDate}</td>
					</tr>
					<tr>
						<th>수업요일</th> <td>${classInfo.classDayNames}</td>
					</tr>
					<tr>
						<th>장소</th> <td>${classInfo.location}</td>
					</tr>
					<tr>
						<th><label for="reservationClassDate">예약 날짜 및 시간:</label></th> 
						<td><input type="datetime-local" name="reservationClassDate" id="reservationClassDate" required></td>
					</tr>
					<tr>
						<th>신청 인원</th> <td><input type="text" name="reservationMembers" id="reservationMembers" placeholder="인원을 입력해주세요."></td>
					</tr>
				</table>
				
				<input type="hidden" id="classIdx" name="classIdx" value="${classInfo.classIdx}"><br>
				<input type="hidden" id="userIdx" name="userIdx" value="${userInfo.userIdx}"><br>
					
	            <button class="orange-button" onclick="location.href='classList'">클래스 목록</button>
	            <button type="submit" class="orange-button">예약 확정</button>
		</form>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/admin/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>



