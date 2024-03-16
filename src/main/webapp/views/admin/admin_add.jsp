
	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/x-icon" href="/MusicWebsite/assets/img/Other/logoPage.png">
<title>Admin</title>
</head>
<style>
h1 {
	display: flex;
	justify-content: center;
}

td[colspan="3"] input {
	width: 500px;
	height: 50px;
	font-size: 30px;
	border-radius: 8px;
}

td[colspan="2"] input {
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

table {
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
<body>

	<jsp:include page="/views/components/header.jsp"></jsp:include>

<br>
	
	<h1 style="color: white;">Add New Song</h1>
	  
	<form action="/MusicWebsite/AddSongController" method="post" enctype="multipart/form-data">
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
					 name="duration"/>
				</td>
				<td colspan="3">
					<h3 style="color: white;">Genre</h3> <input type="text" required
					name="genre" />
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<h3 style="color: white;">Image</h3>  <input type="file" id="image" name="image" accept="image/*">
				</td>
				<td colspan="3">
					<h3 style="color: white;">
						Audio</h3>
			<input type="file" id="audioInput" name="audio" accept="audio/*">
					</td>
			</tr>
			<tr>
				<td colspan="6" style="padding-left: 530px">
					<button class="confirm-button" value ="Upload File" type="submit">Submit</button>
				</td>
			</tr>
		</table>
	</form>
	<script
		src="https://cdn.jsdelivr.net/npm/html-duration-picker@latest/dist/html-duration-picker.min.js"
		type="text/javascript"></script>
</body>
</html>