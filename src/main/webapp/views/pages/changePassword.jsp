<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/x-icon" href="/MusicWebsite/assets/img/Other/logoPage.png">
<title>Confirm Email</title>
<style type="text/css">
* {
	font-family: 'Poppins', sans-serif;
}

body {
	display: flex;
	flex-direction: column;
	align-content: center;
	flex-wrap: wrap;
	align-items: center;
}

input[type="email"] {
	height: 30px;
	width: 500px;
	font-size: 20px;
}

input[type="submit"] {
	height: 40px;
	width: 100px;
	font-size: 20px;
}

form {
	display: flex;
	flex-direction: column;
	align-content: center;
	flex-wrap: wrap;
	align-items: center;
}

span {
	color: red;
	font-size: 20px;
}
</style>
<link rel="icon" type="image/x-icon" href="./assets/img/Other/logoPage.png">
</head>
<body>
	<c:choose>
		<c:when test="${isSent}">
			<h1>Please Verify Your Email !</h1>
		</c:when>
		<c:when test="${isVerify}">
			<h1>Here Is Your New Password: ${newPass}</h1>
		</c:when>
		<c:otherwise>
			<h1>Enter your email:</h1>
			<c:url var="url" value="/ConfirmEmailController"></c:url>
			<form action="${url }" method="post">
				<input type="email" name="email" required> <span>${errorEmail}</span>
				<br> 
				<input type="submit" value="Submit"></input>
			</form>
		</c:otherwise>
	</c:choose>
</body>
</html>