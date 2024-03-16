<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>404 Error</title>
</head>
<style>
div {
	display: grid;
	justify-content: center;
	align-items: center;
}

img {
	height: auto;
	width: 700px; 
}

p {
	font-size: 20px;
}

button {
	font-size: 24px;
	padding: 5px 20px;
}
</style>

<body>
	<div>
		<img alt="500" src="/MusicWebsite/assets/img/Other/500-error.gif">
	</div>
	<div>
		<p>Internal Server Error</p>
	</div>
	<div>
		<c:url var ="url" value="/index.jsp"></c:url>

		<a href="${url}"><button>Back To Home</button></a>
	</div>
</body>

</html>