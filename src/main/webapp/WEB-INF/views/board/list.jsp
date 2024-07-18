<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<style>
/* common styles */
body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

.container {
    width: 80%;
    margin: 0 auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
    border-radius: 8px;
}

h2 {
    color: #343a40;
    font-size: 2em;
    margin-bottom: 20px;
    text-align: center;
}

.action {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.btn {
    display: inline-block;
    padding: 10px 20px;
    margin: 5px;
    border-radius: 5px;
    color: #fff;
    text-align: center;
    text-decoration: none;
}

.btn-create {
    background-color: #28a745;
}

.btn-create:hover {
    background-color: #218838;
}

.btn-home {
    background-color: #17a2b8;
}

.btn-home:hover {
    background-color: #138496;
}

.board-item {
    padding: 20px;
    margin-bottom: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #fff;
}

.board-item h3 {
    margin: 0 0 10px 0;
    font-size: 1.5em;
    color: #007bff;
}

.board-item h3 a {
    text-decoration: none;
    color: inherit;
}

.board-item h3 a:hover {
    text-decoration: underline;
}

.board-item p {
    margin: 0 0 10px 0;
    color: #6c757d;
}

.btn-edit {
    background-color: #ffc107;
    margin-right: 10px;
}

.btn-edit:hover {
    background-color: #e0a800;
}

.btn-delete {
    background-color: #dc3545;
}

.btn-delete:hover {
    background-color: #c82333;
}

.pagination {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.pagination span {
    margin: 0 5px;
}

.current-page {
    font-weight: bold;
    color: #343a40;
}
</style>
</head>
<body>
    <div class="container">
        <h2>게시글 목록</h2>
        <div class="action">
            <a class="btn btn-create" href="${pageContext.request.contextPath}/board/create">새 글 작성하기</a>
            <a class="btn btn-home" href="${pageContext.request.contextPath}/index.jsp">홈 화면</a>
        </div>
        <c:forEach var="board" items="${boardList}">
            <div class="board-item">
                <h3>
                    <a href="${pageContext.request.contextPath}/board/view?id=${board.id}">${board.title}</a>
                </h3>
                <p>${board.content}</p>
                <p><fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm"/></p>
                <!-- 게시글의 작성자가 세션 유저와 동일하다면 수정, 삭제 버튼을 보여주자. -->
                <c:if test="${board.userId == userId }">
                    <a class="btn btn-edit" href="${pageContext.request.contextPath}/board/edit?id=${board.id}">수정</a>
                    <a class="btn btn-delete" href="${pageContext.request.contextPath}/board/delete?id=${board.id}">삭제</a>
                </c:if>
            </div>
        </c:forEach>
        <div class="pagination">
            <c:forEach begin="1" end="${totalPages }" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span class="current-page">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <span><a href="${pageContext.request.contextPath}/board/list?page=${i}">${i}</a></span>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>
</body>
</html>
