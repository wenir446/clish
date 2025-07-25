<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>나의 문의</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/top.css">
  <style>
    .container {
      display: flex;
      min-height: 80vh;
    }

    .sidebar {
      width: 220px;
    }

    .main-content {
      flex: 1;
      padding: 30px;
    }

    .main-content h1,
    .main-content h3 {
      text-align: center;
    }

    .main-content h1 {
      font-size: 24px;
      margin-bottom: 10px;
    }

    .main-content h3 {
      font-size: 18px;
      margin-top: 30px;
      margin-bottom: 10px;
    }

    .top-section {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .btn-write {
      width: 100px;
      background-color: #ff6f0f;
      color: white;
      border: none;
      padding: 7px 16px;
      border-radius: 6px;
      font-weight: bold;
      cursor: pointer;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: center;
    }

    th {
      background-color: #f5f5f5;
    }

    .inquery-detail {
      display: none;
      background: #fff4d9;
    }

    .btn-wrap {
      display: flex;
      gap: 10px;
      margin-top: 10px;
      justify-content: center;
    }

    .btn-wrap button {
      padding: 5px 12px;
      background: #ff6f0f;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .btn-wrap button:hover {
      background: #ff9c34;
    }
  </style>
</head>
<body>
  <header>
    <jsp:include page="/WEB-INF/views/inc/top.jsp" />
  </header>

  <div class="container">
    <div class="sidebar">
      <jsp:include page="/WEB-INF/views/company/comSidebar.jsp" />
    </div>

    <div class="main-content">
      <h1>${sessionScope.sId}님의 페이지</h1>
      <h3>나의 문의 목록</h3>

      <div class="top-section">
        <button class="btn-write" onclick="location.href='${pageContext.request.contextPath}/company/myPage/writeInquery'">문의 등록</button>
      </div>
      <table>
        <thead>
          <tr>
            <th>문의 번호</th>
            <th>제목</th>
            <th>이름</th>
            <th>상태</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty test}"> <!-- 컨트롤러가 문제인건지 반복문쪽이 문제인건지 문의 내역 한개만 나오고 문의번호 이름 등 위치도 수정 필요 -->
              <tr><td colspan="4">아직 등록한 문의가 없습니다.</td></tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="inq" items="${test}">
                <tr class="inquery-toggle">
                  <td>${inq.inquiry.inqueryIdx}</td>
                  <td>${inq.inquiry.inqueryTitle}</td>
                  <td>${inq.userName}</td>
                  <td>
                    <c:choose>
                      <c:when test="${inq.inquiry.inqueryStatus == 1}">답변대기</c:when>
                      <c:when test="${inq.inquiry.inqueryStatus == 2}">답변완료</c:when>
                      <c:when test="${inq.inquiry.inqueryStatus == 3}">검토중</c:when>
                    </c:choose>
                  </td>
                </tr>
                <tr class="inquery-detail">
                  <td colspan="4">
                    <strong>문의 내용:</strong><br>${inq.inquiry.inqueryDetail}<br><br>
                    <strong>답변 내용:</strong><br>
                    <c:choose>
                      <c:when test="${not empty inq.inquiry.inqueryAnswer}">
                        ${inq.inquiry.inqueryAnswer}
                      </c:when>
                      <c:otherwise>
                        아직 답변이 등록되지 않았습니다.
                      </c:otherwise>
                    </c:choose>

                    <c:if test="${inq.inquiry.inqueryStatus == 1}">
                      <div class="btn-wrap">
                        <form action="companyMyQuestionForm.jsp" method="get">
                          <input type="hidden" name="inqueryIdx" value="${inq.inquiry.inqueryIdx}">
                          <button type="submit">수정</button>
                        </form>
                        <form action="companyMyQuestionInqueryDelete" method="post">
                          <input type="hidden" name="inqueryIdx" value="${inq.inquiry.inqueryIdx}">
                          <button type="submit" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
                        </form>
                      </div>
                    </c:if>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

  <footer>
    <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
  </footer>

  <script>
    $(document).ready(function () {
      $(".inquery-toggle").click(function () {
        const detailRow = $(this).next(".inquery-detail");
        $(".inquery-detail").not(detailRow).slideUp(200);
        detailRow.slideToggle();
      });
    });
  </script>
</body>
</html>
