<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<link
	href="${pageContext.request.contextPath}/resources/css/admin/admin.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<div class="sidebar">
			<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"></jsp:include>
		</div>
		<div class="main">
			<jsp:include page="/WEB-INF/views/admin/header.jsp"></jsp:include>
			<div class="main_container">
				<div class="bg-light">
					<div>
						<h5 class="section-title">강좌 목록</h5>
					</div>
					<c:set var="hasRequestedClass" value="false" />
					<c:forEach var="classItem" items="${classList}">
						<c:if test="${classItem.class_status == 1}">
							<c:set var="hasRequestedClass" value="true" />
						</c:if>
					</c:forEach>
					<c:choose>
						<c:when test="${not hasRequestedClass}">
							<div class="list-empty">등록 요청된 강의가 없습니다.</div>
						</c:when>
						<c:otherwise>
							<div>
								<div>
									<h3 class="sub-title">등록 대기</h3>
								</div>
								<table id="table">
									<thead>
										<tr class="test">
											<th>제목</th>
											<th>대분류</th>
											<th>소분류</th>
											<th>신청일</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="classItem" items="${classList}">
											<c:if test="${classItem.class_status == 1}">
												<tr
													onclick="location.href='/admin/class/${classItem.class_idx}'">
													<td>${classItem.class_title}</td>
													<td>${classItem.parent_category_name}</td>
													<td>${classItem.child_category_name}</td>
													<fmt:parseDate value="${classItem.created_at}" pattern="yyyy-MM-dd" var="createdDate"/>
													<td><fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/></td>
													<td><button>상세보기</button></td>
												</tr>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:otherwise>
					</c:choose>

					<form class="filter-form">
						<select class="filter-select">
							<option>전체</option>
							<option>최신등록순</option>
						</select>
						<div class="search-box">
							<input type="text" class="search-input"/>
							<button class="search-button">검색</button>
						</div>
					</form>
					<div>
						<c:choose>
							<c:when test="${hasRegisteredClass}">
								<div class="list-empty">등록된 강의가 없습니다.</div>
							</c:when>
							<c:otherwise>
								<table class="table">
									<thead>
										<tr>
											<th>제목</th>
											<th>대분류</th>
											<th>소분류</th>
											<th>상태</th>
											<th colspan="2"></th>
										</tr>
									</thead>
									<tbody>
										<c:set var="hasRegisteredClass" value="false" />
										<c:forEach var="classItem" items="${classList}">
											<c:if test="${classItem.class_status != 1}">
												<c:set var="hasRegisteredClass" value="true" />
												<tr
													onclick="location.href='/admin/class/${classItem.class_idx}'">
													<td>${classItem.class_title}</td>
													<td>${classItem.parent_category_name}</td>
													<td>${classItem.child_category_name}</td>
													<td><c:choose>
															<c:when test="${classItem.class_status == 2}">오픈</c:when>
															<c:otherwise>마감</c:otherwise>
														</c:choose></td>
													<td><button>수정</button></td>
												</tr>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>