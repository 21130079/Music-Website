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
<<<<<<< HEAD
	
=======
	<header id="header">
		<div class="logo">
			<a href="/MusicWebsite/index.jsp" class="img-logo"> <img
				src="/MusicWebsite/assets/img/Other/logo.png" alt=""
				style="height: 171px;">
			</a>
		</div>
		<div class="col-6">
			<ul class="nav">
				<li class="nav-item">
					<div class="navbar">
						<table>
							<tr>

								<td><b><a class="nav-link "
										href="/MusicWebsite/index.jsp">Home</a></b></td>

								<c:choose>
									<c:when
										test="${fn:contains(sessionScope.account.roles, 'admin')}">
										<td style="padding-left: 10px"><b><a
												class="nav-link ${param.activeRanking}"
												href="/MusicWebsite/views/admin/admin.jsp">Management</a></b></td>
									</c:when>
									<c:otherwise>
										<td style="padding-left: 10px"><b><a
												class="nav-link ${param.activeRanking}"
												href="/MusicWebsite/views/pages/upgradePre.jsp">Premium</a></b></td>
									</c:otherwise>
								</c:choose>
								<td style="padding-left: 10px"><b><a class="nav-link"
										href="/MusicWebsite/views/pages/playlist.jsp?type=playlist">Playlist</a></b></td>
								<td style="padding-left: 10px"><b><a class="nav-link"
										href="/MusicWebsite/views/pages/favorite.jsp">Favorite</a></b></td>
								<td style="padding-left: 10px"><b><a class="nav-link"
										href="/MusicWebsite/views/pages/singer.jsp">Artist</a></b></td>
							
							</tr>
						</table>
					</div>
				</li>
			</ul>
		</div>

		<div>
		</div>

		<div class="sign-in">
			<c:choose>
				<c:when test="${sessionScope.account!=null}">
					<button style="background-color: transparent; border: none"
						type="button" class="login-btn"
						onclick="document.getElementById('change-password').style.display='flex'">
						<i class="bi bi-key-fill"></i>
					</button>
				<div class="person_circle">
						<i class="bi bi-person-circle">
						</i>
						<div class="nav_person">
								<div>My Information</div>
								<div>Premium</div>
								<div>Forgot Password</div>
								<div>Logout</div>
							</div>
					</div>
					<font color="White"> ${sessionScope.account.username} </font>
					<a href="/MusicWebsite/LogOutController">
						<button type="button" class="login-btn" onclick="reload()">Log
							Out</button>
					</a>

					<c:choose>
						<c:when test="${messageOldPass!=null || messageNewPass!=null}">
							<c:set var="displayPass" value="flex"></c:set>
							<c:set var="formatPass" value="-25px"></c:set>
						</c:when>
						<c:otherwise>
							<c:set var="displayPass" value="none"></c:set>
						</c:otherwise>
					</c:choose>

					<div id="change-password" class="body-log"
						style="display: ${displayPass};">
						<div class="wrapper">
							<span style="z-index: 3;"
								onclick="document.getElementById('change-password').style.display='none'"
								class="close" title="Close Modal">×</span>

							<div class="form-wrapper">
								<form action="/MusicWebsite/NewPasswordController" method="post">
									<h2 class="log">Change Password</h2>
									<div class="input-group">
										<input type="password" required name="oldPass"
											oninput="checkUsername(this)"> <label for="">Current
											password</label>
									</div>
									<div style="color: red; margin-top: ${formatPass};">${messageOldPass}</div>
									<div class="input-group">
										<input type="password" required name="newPass"> <label
											for="">New password</label>
									</div>
									<div style="color: red; margin-top: ${formatPass};">${messageNewPass}</div>
									<div id="captcha" style="color: red;"></div>
									<button type="submit" class="btn-log">Confirm</button>
								</form>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<i class="bi bi-person-circle"></i>
					<button type="button" class="login-btn"
						onclick="document.getElementById('login').style.display='flex'">
						Sign In</button>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${errorAccount!=null || message!=null}">
					<c:set var="display" value="flex"></c:set>
				</c:when>
				<c:otherwise>
					<c:set var="display" value="none"></c:set>
				</c:otherwise>
			</c:choose>

			<input type="hidden" name="${message }" id="hidden-input">

			<c:if test="${sessionScope.account==null}">
				<div id="login" class="body-log" style="display:${display};">

					<div class="wrapper">
						<span style="z-index: 3;"
							onclick="document.getElementById('login').style.display='none'"
							class="close" title="Close Modal">×</span>

						<div class="form-wrapper sign-up">
							<form action="/MusicWebsite/SignUpController" method="post">
								<h2 class="log">Sign Up</h2>
								<div class="input-group">
									<input type="text" required name="username"
										oninput="checkUsername(this)"> <label for="">Username</label>
								</div>
								<div class="input-group">
									<input type="email" required name="email"> <label
										for="">Email</label>
								</div>
								<div class="input-group">
									<input type="password" required name="password"> <label
										for="">Password</label>
								</div>
								<div style="color: red">${message}</div>

								<div style="color: red" class="signup-recaptcha-mess"></div>

								<button type="submit" class="btn-log" id="sign-up">Sign
									Up</button>
								<div class="sign-link">
									<p>
										Already have an account? <a href="#" class="signIn-link">Sign
											In</a>
									</p>
								</div>
								<div class="sign-link">
									<p>Log in via third-party apps:</p>
								</div>
								<div class="sign-link">
									<a
										href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/MusicWebsite/LoginGoogleController&response_type=code
    										&client_id=635263821596-utj1bf1e28i9jcc36vsampol1hbj4gmv.apps.googleusercontent.com&approval_prompt=force"
										class=gg-icon> <svg xmlns="http://www.w3.org/2000/svg"
											x="0px" y="0px" width="30" height="30" viewBox="0 0 48 48">
											<path fill="#FFC107"
												d="M43.611,20.083H42V20H24v8h11.303c-1.649,4.657-6.08,8-11.303,8c-6.627,0-12-5.373-12-12c0-6.627,5.373-12,12-12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C12.955,4,4,12.955,4,24c0,11.045,8.955,20,20,20c11.045,0,20-8.955,20-20C44,22.659,43.862,21.35,43.611,20.083z"></path>
											<path fill="#FF3D00"
												d="M6.306,14.691l6.571,4.819C14.655,15.108,18.961,12,24,12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C16.318,4,9.656,8.337,6.306,14.691z"></path>
											<path fill="#4CAF50"
												d="M24,44c5.166,0,9.86-1.977,13.409-5.192l-6.19-5.238C29.211,35.091,26.715,36,24,36c-5.202,0-9.619-3.317-11.283-7.946l-6.522,5.025C9.505,39.556,16.227,44,24,44z"></path>
											<path fill="#1976D2"
												d="M43.611,20.083H42V20H24v8h11.303c-0.792,2.237-2.231,4.166-4.087,5.571c0.001-0.001,0.002-0.001,0.003-0.002l6.19,5.238C36.971,39.205,44,34,44,24C44,22.659,43.862,21.35,43.611,20.083z"></path>
										</svg>
									</a>
								</div>
							</form>
						</div>

						<div class="form-wrapper sign-in">

							<form action=<c:url value="/LoginController"></c:url>
								method="post">
								<h2 class="log">Login</h2>
								<div class="input-group">
									<input type="text" name="username" value="${usernameC }" required> <label
										for="">Username</label>
								</div>
								<div class="input-group">
									<input type="password" name="password" value="${passwordC }" required> <label
										for="">Password</label>
								</div>
								
								<div class="remember">
									<input id="remember" type="checkbox" name="remember" value="true"> 
									<label for="remember">Remember me</label>
								</div>
								
								<div class="forgot-pass">
									<a href="/MusicWebsite/views/pages/changePassword.jsp">Forgot
										Password?</a>
								</div>
								<div style="color: red">${errorAccount}</div>

								<div class="g-recaptcha"
									data-sitekey="6LccxrYpAAAAAAPNc2PDdoWNK1r2SAWs8uwSNZgG"></div>
								<br>
							
								<div style="color: red" class="login-recaptcha-mess"></div>
								<button type="submit" class="btn-log" id="login">Login</button>

								<div class="sign-link">
									<p>
										Don't have an account? <a href="#" class="signUp-link">Sign
											Up</a>
									</p>
								</div>
								<div class="sign-link">
									<p>Log in via third-party apps:</p>
								</div>
								<div class="sign-link">
									<a
										href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/MusicWebsite/LoginGoogleController&response_type=code
    										&client_id=635263821596-utj1bf1e28i9jcc36vsampol1hbj4gmv.apps.googleusercontent.com&approval_prompt=force"
										class=gg-icon> <svg xmlns="http://www.w3.org/2000/svg"
											x="0px" y="0px" width="30" height="30" viewBox="0 0 48 48">
											<path fill="#FFC107"
												d="M43.611,20.083H42V20H24v8h11.303c-1.649,4.657-6.08,8-11.303,8c-6.627,0-12-5.373-12-12c0-6.627,5.373-12,12-12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C12.955,4,4,12.955,4,24c0,11.045,8.955,20,20,20c11.045,0,20-8.955,20-20C44,22.659,43.862,21.35,43.611,20.083z"></path>
											<path fill="#FF3D00"
												d="M6.306,14.691l6.571,4.819C14.655,15.108,18.961,12,24,12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C16.318,4,9.656,8.337,6.306,14.691z"></path>
											<path fill="#4CAF50"
												d="M24,44c5.166,0,9.86-1.977,13.409-5.192l-6.19-5.238C29.211,35.091,26.715,36,24,36c-5.202,0-9.619-3.317-11.283-7.946l-6.522,5.025C9.505,39.556,16.227,44,24,44z"></path>
											<path fill="#1976D2"
												d="M43.611,20.083H42V20H24v8h11.303c-0.792,2.237-2.231,4.166-4.087,5.571c0.001-0.001,0.002-0.001,0.003-0.002l6.19,5.238C36.971,39.205,44,34,44,24C44,22.659,43.862,21.35,43.611,20.083z"></path>
										</svg>
									</a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</header>
>>>>>>> 335797e9ec5b09eedcba9652e99fad19a9e2f7ed
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