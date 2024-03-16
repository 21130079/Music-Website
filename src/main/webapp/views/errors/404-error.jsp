<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<img alt="404" src="/MusicWebsite/assets/img/Other/404-error.gif">
	</div>
	<div>
		<p>The page you want to visit cannot be found</p>
	</div>
	<div>
		<c:url var ="url" value="/index.jsp"></c:url>

		<a href="${url}"><button>Back To Home</button></a>


	</div>
</body>

</html>