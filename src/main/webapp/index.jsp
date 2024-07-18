<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP MVC 게시판</title>
<style type="text/css">
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    color: #333;
    margin: 0;
    padding: 0;
}

.container {
    width: 60%;
    margin: 50px auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    text-align: center;
}

h2 {
    margin-bottom: 30px;
    color: #007bff;
}

.nav-list {
    list-style: none;
    padding: 0;
    display: flex;
    justify-content: center;
    gap: 15px;
}

.nav-list li {
    display: inline-block;
}

.nav-list li a {
    text-decoration: none;
    color: #fff;
    padding: 10px 20px;
    border-radius: 5px;
    display: inline-block;
}

.btn-primary {
    background-color: #007bff;
}

.btn-primary:hover {
    background-color: #0056b3;
}

.btn-secondary {
    background-color: #6c757d;
}

.btn-secondary:hover {
    background-color: #5a6268;
}
</style>
</head>
<body>
    <div class="container">
        <h2>JSP MVC 게시판 테스트 페이지</h2>
        <ul class="nav-list">
            <li><a class="btn btn-primary" href="/t-board/user/signup">회원가입</a></li>
            <li><a class="btn btn-primary" href="/t-board/user/signin">로그인</a></li>
            <li><a class="btn btn-secondary" href="/t-board/user/logout">로그아웃</a></li>
            <li><a class="btn btn-primary" href="/t-board/board/list">게시판 목록</a></li>
        </ul>
    </div>
</body>
</html>
