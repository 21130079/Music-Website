<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.datatables.net/2.0.3/js/dataTables.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.css"
	rel="stylesheet">
<link
	href="https://cdn.datatables.net/2.0.3/css/dataTables.bootstrap4.css"
	rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.js"></script>
<script src="https://cdn.datatables.net/2.0.3/js/dataTables.js"></script>
<script
	src="https://cdn.datatables.net/2.0.3/js/dataTables.bootstrap4.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css"
	href="/MusicWebsite/assets/css/style.css">
<style type="text/css">
.show-more-btn {
	position: absolute;
	right: 0px;
	margin-right: 108px;
	background-color: transparent;
	border: 2px solid crimson;
	border-radius: 15px;
	color: crimson;
	padding: 10px;
}

.justify-content-between {
	color: white;
}

#data td {
	color: black;
	background-color: white;
}

th {
	background-color: white;
}

body {
	overflow-x: hidden;
}

.content-bg {
	
}

.add-music {
	width: 240px;
	height: 240px;
	margin-top: 10px;
}

.edit-button {
	border: none;
	background-color: transparent;
	padding-right: 100px;
	font-size: 20px;
}

.log_admin {
	color: white;
	margin-left: 100px;
}

.account_admin {
	color: white;
	margin-left: 100px;
}

.log_admin:hover {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
}

.account_admin {
	color: white;
	margin-left: 100px;
}

.account_admin:hover {
	color: black;
	text-decoration: none;
}

.account_admin {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
	text-decoration: none;
}

.song_admin:hover {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
}

.song_admin {
	color: white;
	margin-left: 100px;
}
</style>
</head>
<body>
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
						<i class="bi bi-person-circle"> </i>
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
	<div class="title"
		style="display: flex; justify-content: space-between; width: 100%; margin-top: 20px">
		<div style="display: flex;">
			<h1 class="topic-music topic-trending">
				<b>Admin</b>
			</h1>
			<h2>
				<a class="log_admin" style="text-decoration: none;"
					href="/MusicWebsite/views/admin/admin_log.jsp">Log</a>
			</h2>
			<h2>
				<a class="account_admin"
					href="/MusicWebsite/views/admin/admin_account.jsp">Account</a>

			</h2>
			<h2>
				<a class="song_admin" style="text-decoration: none;"
					href="/MusicWebsite/views/admin/admin.jsp">Song</a>
			</h2>
		</div>

		<button style="color: black; float: right;" onclick="getSelectedIds()">Delete
			selected</button>


	</div>
	<jsp:useBean id="daoLog" class="database.DAOLog"></jsp:useBean>
	<c:set var="listItems" value="${daoLog.selectAll()}"></c:set>

	<table id="data" class="table-bordered table-striped"
		style="width: 100%">
		<thead>
			<tr>
				<th></th>
				<th>User name</th>
				<th>Password</th>
				<th>Email</th>
				<th>Role</th>
				<th></th>
			</tr>
		</thead>
	</table>
</body>

<script src="/MusicWebsite/assets/js/login.js"></script>
<script>
	function getSelectedIds() {
		var selectedIds = [];
		var checkboxes = document.querySelectorAll('.checkbox');
		checkboxes.forEach(function(checkbox) {
			if (checkbox.checked) {
				selectedIds.push(checkbox.id);
			}
		});

		if (selectedIds.length > 0) {
			$.ajax({
				url : '/MusicWebsite/RemoveAccountController',
				type : 'get',
				data : {
					selectedIds : selectedIds
				},
				success : function(response) {
					alert('Đã xóa các log đã chọn');
					window.location.reload();

				},
				error : function() {
					alert('Đã xảy ra lỗi.');
				}
			});
		} else {
			alert("Không có phần tử nào được chọn.");
		}
	}
	$(document).ready(function() {
		$.ajax({
			url : "/MusicWebsite/AccountAPI",
			type : "get",
			dataType : "json",
			success : function(data) {

				$("#data").dataTable({
					data : data.data,

					columns : [
						{
							data : null,
							render : function(
									data,
									type,
									row) {
								var checkboxId = data.username; // Assuming id is a unique identifier in your data
								var checkboxClass = "checkbox"; // Set your desired class here
								return '<input type="checkbox" id="' + checkboxId + '" class="' + checkboxClass + '">';
							}
						},
					{
						data : 'username'
					}, {
						data : 'password'
					}, {
						data : 'email'
					}, {
						data : 'roles'
					},
					{
						"data" : null,
						"render" : function(
								data,
								type,
								row) {
							return '<a href="/MusicWebsite/RemoveAccountController?username='
									+ data.username
									+ '"><button style="color: black;">Delete</button></a>';
						}
					} ]
				});

			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("Error: " + errorThrown);
			}
		});

	})
</script>
<script src='https://www.google.com/recaptcha/api.js'></script>
</html>