<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 문의 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<style>
  .classManage-container { display: flex; width: 100%; min-height: 100vh; }
  .content-area { flex: 1; padding: 30px; }
  .class-header { margin-bottom: 30px; text-align: center; }
  .class-table { width: 100%; border-collapse: collapse; }
  .class-table th, .class-table td {
    border: 1px solid #ccc; padding: 10px; text-align: center;
  }
  .class-table tr:hover { background-color: #f5f5f5; cursor: pointer; }

  .modal {
    display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(0,0,0,0.5); justify-content: center; align-items: center; z-index: 999;
  }

  .modal_body {
    background: white; padding: 35px; border-radius: 12px; width: 650px;
    box-shadow: 0 5px 25px rgba(0,0,0,0.25); display: flex; flex-direction: column; align-items: center;
  }

  .modal_body table { width: 100%; border-collapse: collapse; }
  .modal_body th {
    width: 120px; text-align: center; vertical-align: middle; padding: 12px 10px;
    white-space: nowrap; background-color: #e0e0e0; font-weight: bold;
  }
  .modal_body td { padding: 12px 10px; vertical-align: top; }

  .modal_body textarea {
    width: 100%; height: 150px; font-size: 14px; padding: 12px;
    resize: vertical; border: 1px solid #ccc; border-radius: 6px;
  }

  .modal-buttons { text-align: center; margin-top: 30px; }
  .modal-buttons button {
    background-color: orange; color: white; padding: 10px 25px;
    border: none; border-radius: 6px; margin: 0 10px; cursor: pointer; font-size: 15px;
  }
  .modal-buttons button:hover { background-color: #ff7f00; }
</style>
</head>
<body>
  <header>
    <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
  </header>

  <div class="classManage-container">
    <jsp:include page="/WEB-INF/views/company/comSidebar.jsp" />
    <div class="content-area">
      <div class="class-header">
        <h1>클래스 문의 페이지</h1>
      </div>

      <c:choose>
        <c:when test="${empty classInquiryList}">
          <div class="no-data">등록된 문의가 없습니다.</div>
        </c:when>
        <c:otherwise>
          <table class="class-table">
            <thead>
              <tr>
                <th>문의 번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>문의일자</th>
                <th>답변 상태</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="inq" items="${classInquiryList}">
                <tr onclick="onModal('${inq.inquiry.inqueryIdx}')">
                  <td>${inq.inquiry.inqueryIdx}</td>
                  <td>${inq.inquiry.inqueryTitle}</td>
                  <td>${inq.userName}</td>
                  <td><fmt:formatDate value="${inq.inquiry.inqueryDatetime}" pattern="yyyy-MM-dd" /></td>
                  <td>
                    <c:choose>
                      <c:when test="${empty inq.inquiry.inqueryAnswer}">미답변</c:when>
                      <c:otherwise>답변완료</c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- ✅ 모달 폼 구조 변경 -->
  <div class="modal" id="inquiry-modal">
    <div class="modal_body">
      <h3>문의 상세 보기</h3>
      <form id="modal-form" action="/company/inquiry/answer" method="post">
        <input type="hidden" name="inqueryIdx" id="inquiry-idx">
        <input type="hidden" name="userIdx" id="user-idx">
        <table>
          <tr><th>작성자</th><td id="modal-writer"></td></tr>
          <tr><th>작성일</th><td id="modal-date"></td></tr>
          <tr><th>문의유형</th><td id="modal-type"></td></tr>
          <tr><th>문의내용</th><td id="modal-detail"></td></tr>
          <tr>
            <th>답변</th>
            <td><textarea id="inquiry-answer" name="inqueryAnswer"></textarea></td>
          </tr>
        </table>
        <div class="modal-buttons">
          <button type="submit" id="btn">등록</button>
          <button type="button" onclick="closeModal()">취소</button>
        </div>
      </form>
    </div>
  </div>

  <footer>
    <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
  </footer>

  <script>
    function closeModal() {
      document.getElementById('inquiry-modal').style.display = 'none';
    }

    function formatFullDate(datetimeStr) {
      const date = new Date(datetimeStr);
      const options = {
        year: 'numeric', month: '2-digit', day: '2-digit',
        hour: '2-digit', minute: '2-digit', hour12: true
      };
      return date.toLocaleString("ko-KR", options);
    }

    function onModal(inqueryIdx) {
      const modal = document.getElementById('inquiry-modal');
      modal.style.display = "flex";

      fetch("/company/inquiry/detail/" + inqueryIdx)
        .then(res => res.json())
        .then(data => {
          document.getElementById("inquiry-idx").value = data.inquiry.inqueryIdx;
          document.getElementById("user-idx").value = data.inquiry.userIdx;
          document.getElementById("modal-writer").innerText = data.userName;
          document.getElementById("modal-date").innerText = formatFullDate(data.inquiry.inqueryDatetime);
          document.getElementById("modal-type").innerText = data.inquiry.inqueryType == 2 ? "강의 문의" : "1:1 문의";
          document.getElementById("modal-detail").innerText = data.inquiry.inqueryDetail;
          document.getElementById("inquiry-answer").value = data.inquiry.inqueryAnswer || "";
          document.getElementById("btn").innerText = data.inquiry.inqueryAnswer ? "수정" : "등록";
        })
        .catch(err => console.error("상세 조회 실패", err));
    }
  </script>
</body>
</html>
