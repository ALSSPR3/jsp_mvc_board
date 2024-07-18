<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기</title>
<style>
/* common styles */
body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

.container {
    width: 50%;
    margin: 0 auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-top: 50px;
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
}

label {
    font-size: 1.2em;
    margin-bottom: 10px;
    color: #343a40;
}

input[type="text"],
textarea {
    padding: 10px;
    font-size: 1em;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 100%;
    box-sizing: border-box;
}

textarea {
    resize: vertical;
}

.btn {
    display: inline-block;
    padding: 10px 20px;
    margin: 10px 5px;
    border-radius: 5px;
    color: #fff;
    text-align: center;
    text-decoration: none;
}

.btn-submit {
    background-color: #28a745;
    border: none;
    cursor: pointer;
}

.btn-submit:hover {
    background-color: #218838;
}

.btn-list {
    background-color: #17a2b8;
    border: none;
    cursor: pointer;
}

.btn-list:hover {
    background-color: #138496;
}

.button-group {
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>
<script>
    function goBack() {
        window.history.back();
    }
</script>
</head>
<body>
    <div class="container">
        <h2>수정하기</h2>
        <form action="${pageContext.request.contextPath}/board/edit" method="post">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" name="title" id="title" value="${board.title}">
                <label for="content">내용</label>
                <textarea rows="10" id="content" name="content">${board.content}</textarea>
                <input type="hidden" name="boardid" value="${board.id}">
            </div>
            <div class="button-group">
                <input type="submit" value="수정하기" class="btn btn-submit">
                <button type="button" class="btn btn-list" onclick="goBack()">취소하기</button>
            </div>
        </form>
    </div>
</body>
</html>
