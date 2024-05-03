<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/x-icon"
	href="/MusicWebsite/assets/img/Other/logoPage.png">
<title>Admin</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="/MusicWebsite/assets/css/style.css">
</head>
<style>
h1 {
	display: flex;
	justify-content: center;
}

.confirm-table td[colspan="3"] input {
	width: 500px;
	height: 50px;
	font-size: 30px;
	border-radius: 8px;
}

.confirm-table td[colspan="2"] input {
	width: 305px;
	height: 50px;
	font-size: 30px;
	border-radius: 8px;
}

.confirm-table tr td {
	padding-top: 10px;
	padding-bottom: 20px;
	padding-left: 40px;
	padding-right: 40px;
}

.confirm-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 30px;
	display: flex;
	justify-content: center;
}

.confirm-button {
	background-color: rgb(104, 104, 104);
	font-size: 20px;
	border: none;
	width: 100px;
	height: 50px;
	color: white;
	border-radius: 50px;
}
</style>

<jsp:include page="../components/admin_header.jsp"/>

<body>
	<br>

	<h1 style="color: white;">Add New Song</h1>

	<form action="/MusicWebsite/AddSongController" method="post"
		enctype="multipart/form-data">
		<table class="confirm-table">
			<tr>
				<td colspan="3">
					<h3 style="color: white;">Name Song</h3> <input type="text"
					required name="name-song" />
				</td>
				<td colspan="3">
					<h3 style="color: white;">Name Singer</h3> <input type="text"
					required name="name-singer" />
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<h3 style="color: white;">Duration</h3> <input type="time"
					name="duration" />
				</td>
				<td colspan="3">
					<h3 style="color: white;">Genre</h3> <input type="text" required
					name="genre" />
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<h3 style="color: white;">Image</h3> <input type="file" id="image"
					name="image" accept="image/*">
				</td>
				<td colspan="3">
					<h3 style="color: white;">Audio</h3> <input type="file"
					id="audioInput" name="audio" accept="audio/*">
				</td>
			</tr>
			<tr>
				<td colspan="6" style="padding-left: 530px">
					<button class="confirm-button" value="Upload File" type="submit">Submit</button>
				</td>
			</tr>
		</table>
	</form>
	<script
		src="https://cdn.jsdelivr.net/npm/html-duration-picker@latest/dist/html-duration-picker.min.js"
		type="text/javascript"></script>

	<script src="/MusicWebsite/assets/js/login.js"></script>
	<script src='https://www.google.com/recaptcha/api.js'></script>
</body>
</html>