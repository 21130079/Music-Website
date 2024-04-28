<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

<link rel="stylesheet" href="/MusicWebsite/assets/css/style.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<style>
.nav-link{
margin: 5px 5px;
    font-size: 18px;
    color: rgb(180, 180, 180);
}
</style>

<header id="header">
		<div class="logo">
			<a href="/MusicWebsite/index.jsp" class="img-logo"> <img
				src="/MusicWebsite/assets/img/Other/logo.png" alt=""
				style="height: 171px;">
			</a>
		</div>
		<div class="col-9">
			<ul class="nav">
				<li class="nav-item">
					<div class="navbar">
						<table>
							<tr>

								<td><b><a class="nav-link "
										href="/MusicWebsite/views/admin/admin-pane.jsp">Home</a></b></td>
										<td style="padding-left: 10px"><b><a  class="nav-link "
												href="/MusicWebsite/index.jsp">User View</a></b></td>
								<td style="padding-left: 10px"><b><a class="song_admin nav-link" href="/MusicWebsite/views/admin/admin.jsp">Song</a></b></td>
								<td style="padding-left: 10px"><b>		<a class="log_admin nav-link" href="/MusicWebsite/views/admin/admin_account.jsp">Accoint</a></b></td>
								<td style="padding-left: 10px"><b>		<a class="log_admin nav-link" href="/MusicWebsite/views/admin/admin_log.jsp">Log</a></b></td>
								
							</tr>
						</table>
					</div>
				</li>
			</ul>
		</div>

<div class="search-box">
			<form action="/MusicWebsite/SearchController" method="get"
				style="margin-left: -169px;">
				<button type="submit" class="btn-search" disabled="disabled">
					<i class="bi bi-search" style="font-size: 22px"></i>
				</button>
				<input type="text" class="input-search" oninput="searchByName(this)"
					onblur="appearImg(this)" placeholder="Search by name..."
					name="searchInput">
			</form>
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
									<input type="text" name="username" required> <label
										for="">Username</label>
								</div>
								<div class="input-group">
									<input type="password" name="password" required> <label
										for="">Password</label>
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
<body>		
	   
</body>
</html>