<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
/* signin.css */

body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

.container {
    width: 30%;
    margin: 100px auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

h2 {
    color: #343a40;
    font-size: 2em;
    margin-bottom: 20px;
    text-align: center;
}

.form-group {
    display: flex;
    flex-direction: column;
    margin-bottom: 20px;
}

label {
    font-size: 1.2em;
    margin-bottom: 5px;
    color: #343a40;
}

input[type="text"],
input[type="password"] {
    padding: 10px;
    font-size: 1em;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 100%;
    box-sizing: border-box;
    margin-bottom: 10px;
}

.btn {
    display: inline-block;
    padding: 10px 20px;
    margin: 10px 5px;
    border-radius: 5px;
    color: #fff;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
    border: none;
    font-size: 1em;
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

.button-group {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.button-group .btn-primary, .button-group .btn-secondary {
    width: 48%;
    text-align: center;
    display: block;
}
</style>
</head>
<body>
    <div class="container">
        <h2>로그인</h2>
        <c:if test="${not empty errorMessage }">
            <p>${errorMessage}</p>
        </c:if>
        <form action="${pageContext.request.contextPath}/user/signin" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="고길동" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" value="asd123" required>
            </div>
            <div class="form-group button-group">
                <input class="btn btn-primary" type="submit" value="로그인">
                <a href="${pageContext.request.contextPath}/user/signup" class="btn btn-secondary">회원가입</a>
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary">홈으로</a>
            </div>
        </form>
    </div>
</body>
</html>
