<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${board.title }</title>
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
}

h2, h3 {
	color: #343a40;
}

p {
	color: #6c757d;
}

a {
	text-decoration: none;
}

.btn {
	display: inline-block;
	padding: 10px 20px;
	margin: 10px 5px;
	border-radius: 5px;
	color: #fff;
	background-color: #007bff;
	text-align: center;
}

.btn:hover {
	background-color: #0056b3;
}

.btn-edit {
	background-color: #28a745;
}

.btn-edit:hover {
	background-color: #218838;
}

.btn-delete {
	background-color: #dc3545;
}

.btn-delete:hover {
	background-color: #c82333;
}

.btn-list {
	background-color: #17a2b8;
}

.btn-list:hover {
	background-color: #138496;
}

/* view specific styles */
h2 {
	font-size: 2em;
	margin-bottom: 20px;
}

p {
	font-size: 1.2em;
	line-height: 1.6;
}

p small {
	display: block;
	margin-top: 10px;
	color: #6c757d;
}

.btn {
	font-size: 1em;
}

h3 {
	margin-top: 40px;
	margin-bottom: 20px;
	font-size: 1.5em;
}

/* comment form styles */
.comment-section {
	margin-top: 30px;
}

.comment-list {
	margin-bottom: 20px;
}

.comment {
	padding: 10px;
	border-bottom: 1px solid #ddd;
}

.comment .comment-author {
	font-weight: bold;
	color: #343a40;
}

.comment .comment-date {
	font-size: 0.9em;
	color: #6c757d;
}

.comment .comment-content {
	margin-top: 10px;
	font-size: 1.1em;
}

.comment .btn-edit {
	display: inline;
	font-size: 0.9em;
	padding: 5px 10px;
	margin-top: 10px;
	background-color: #28a745;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 0.9em;
}

.comment .btn-edit:hover {
	background-color: #218838;
}

.comment .btn-delete {
	display: inline;
	font-size: 0.9em;
	padding: 5px 10px;
	margin-top: 10px;
	background-color: #dc3545;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.comment .btn-delete:hover {
	background-color: #c82333;
}

.comment-form {
	margin-top: 20px;
	display: flex;
	flex-direction: column;
}

.comment-form textarea {
	padding: 10px;
	font-size: 1em;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	resize: vertical;
}

.comment-form button {
	align-self: flex-start;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	background-color: #28a745;
	color: #fff;
	font-size: 1em;
	cursor: pointer;
}

.comment-form button:hover {
	background-color: #218838;
}
</style>
</head>
<body>
	<div class="container">
		<h2>${board.title}</h2>
		<p>${board.content}</p>
		<p>
			<fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm" />
		</p>
		<c:if test="${board.userId == userID}">
			<a class="btn btn-edit" href="${pageContext.request.contextPath}/board/edit?id=${board.id}">수정</a>
			<a class="btn btn-delete" href="${pageContext.request.contextPath}/board/delete?id=${board.id}">삭제</a>
		</c:if>
		<a class="btn btn-list" href="${pageContext.request.contextPath}/board/list?page=1">목록으로 돌아가기</a>
	</div>

	<div class="container comment-section">
		<h3>댓글</h3>
		<!-- 댓글 리스트 -->
		<div class="comment-list">
			<c:forEach var="comment" items="${commentList}">
				<div class="comment">
					<div class="comment-author">${comment.username}</div>
					<div class="comment-date">${comment.createAt}</div>
					<div class="comment-content">${comment.content}</div>
					<input type="hidden" value="${userID}"> <input type="hidden" value="${comment.userId}">
					<c:if test="${comment.userId == userID}">
						<form action="${pageContext.request.contextPath}/board/commentEdit?commentId=${comment.id}">
							<input type="hidden" name="boardId" value="${board.id}">
							<input type="hidden" name="commentId" value="${comment.id}">
							<input type="hidden" value="${comment.userId}">
							<textarea name="content" rows="4" placeholder="수정할 댓글을 작성하세요..." required></textarea>
							<button type="submit" class="btn-edit">수정</button>
							<form action="${pageContext.request.contextPath}/board/commentDelete?commentId=${comment.id}">
								<input type="hidden" name="boardId" value="${board.id}"> <input type="hidden" name="commentId" value="${comment.id}">
								<button type="submit" class="btn-delete">삭제</button>
							</form>
						</form>
					</c:if>
					<c:if test="${board.userId == userID && comment.userId != userID}">
						<form action="${pageContext.request.contextPath}/board/commentDelete?commentId=${comment.id}">
							<input type="hidden" name="boardId" value="${board.id}"> <input type="hidden" name="commentId" value="${comment.id}">
							<button type="submit" class="btn-delete">삭제</button>
						</form>
					</c:if>
				</div>
			</c:forEach>
		</div>

		<!-- 댓글 작성 폼 -->
		<form class="comment-form" action="${pageContext.request.contextPath}/board/addComment" method="post">
			<input type="hidden" name="boardId" value="${board.id}">
			<textarea name="content" rows="4" placeholder="댓글을 작성하세요..." required></textarea>
			<button type="submit">댓글 작성</button>
		</form>
	</div>
</body>
</html>
