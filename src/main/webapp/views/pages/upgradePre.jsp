<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Premium</title>
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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
</head>

<style>
#container {
	height: 100%;
	width: 100%;
	display: grid;
	justify-content: center;
	align-items: center;
	background-color: #171717;
}

.wrapper_button {
	justify-self: left;
	margin-left: -20%;
}

.wrapper_button button {
	margin: 20px 0px;
	width: 120px;
}

h2 {
	font-size: 40px;
	width: 90%
}

#main_content {
	display: grid;
	grid-template-columns: 330px 330px 330px;
	column-gap: 3%;
	width: 100%;
	height: 500px;
	justify-self: center;
	color: white;
}

.option {
	border-radius: 10px;
	display: grid;
	justify-content: center;
	background-color: #242424;
	max-width: 450px;
}

.option_wrapper {
	display: grid;
	justify-content: center;
	width: 100%;
	grid-template-rows: auto auto 18%;
}

.option_header {
	margin-top: 15px;
	height: 50%;
	display: grid;
	grid-template-rows: 30px 60px 80px auto;
}

.option_header hr {
	height: 1px;
}

#mini h2 {
	color: #CFF56A;
}

#mini button {
	background-color: #CFF56A;
}

#individual h2 {
	color: #FFD2D7;
}

#individual button {
	background-color: #FFD2D7;
}

#student h2 {
	color: #C4B1D4;
}

#student button {
	background-color: #C4B1D4;
}

.inner_button {
	width: 100%;
	height: 50px;
	color: black;
	border-radius: 20px !important;
	cursor: pointer !important;
}

ul {
	padding-left: 0px !important;
	margin-left: 15px;
}

.option_content li {
	justify-self: left;
	margin: 10px auto;
}

.option_header p a {
	color: #A7A7A7 !important;
}
</style>
<jsp:include page="../components/header.jsp"></jsp:include>
<body>
	
	<div id="container">
		<div class="wrapper_button">
			<c:url var="url" value="/index.jsp"></c:url>
			<a href="${url}">
				<button class="inner_button">
					<i class="fa-solid fa-arrow-left"></i> Back
				</button>
			</a>
		</div>
		<div id="main_content">
			<div id="mini" class="option">
				<div class="option_wrapper">
					<div class="option_header">
						<div>
							<i class="fa-solid fa-music"></i> Premium
						</div>
						<h2>Mini</h2>
						<p>20,000 VND for 1 week</p>
						<hr>
					</div>
					<ul class="option_content">
					<li>Unlimited number of Favorite songs</li>
						<li>Unlimited number of Playlists</li>
						<li>Full payment</li>
						<li>Download Music for free</li>
					</ul>
					<a href="/MusicWebsite/UpgradeSelectorController?type=mini"><button
							class="inner_button">Buy Premium Mini</button></a>
				</div>
			</div>

			<div id="individual" class="option">
				<div class="option_wrapper">
					<div class="option_header">
						<div>
							<i class="fa-solid fa-music"></i> Premium
						</div>
						<h2>Individual</h2>
						<p>55,000 VND for 1 month</p>
						<hr>
					</div>
					<ul class="option_content">
						<li>Unlimited number of Favorite songs</li>
						<li>Unlimited number of Playlists</li>
						<li>Full payment</li>
						<li>Download Music for free</li>
					</ul>
					<a href="/MusicWebsite/UpgradeSelectorController?type=individual">
						<button class="inner_button">Buy Premium Individual</button>
					</a>
				</div>
			</div>

			<div id="student" class="option">
				<div class="option_wrapper">
					<div class="option_header">
						<div>
							<i class="fa-solid fa-music"></i> Premium
						</div>
						<h2>Student</h2>
						<p>45,000 VND for 1 month</p>

						<hr>
					</div>
					<ul class="option_content">
						<li>Discount for qualifying students</li>
						<li>Unlimited number of Favorite songs</li>
						<li>Unlimited number of Playlists</li>
						<li>Full payment</li>
						<li>Download Music for free</li>
					</ul>
					<a href="/MusicWebsite/UpgradeSelectorController?type=student">
						<button class="inner_button">Buy Premium Student</button>
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="/MusicWebsite/assets/js/login.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>
</html>