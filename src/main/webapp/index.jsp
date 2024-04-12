<%@page import="java.util.ArrayList"%>
<%@ page import="database.*"%>
<%@ page import="Model.*"%>
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
<link rel="icon" type="image/x-icon"
	href="/MusicWebsite/assets/img/Other/logoPage.png">
<title>KD Music</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="/MusicWebsite/assets/css/style.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

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

body {
	overflow-x: hidden;
}
</style>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".show-more-btn").click(function(e) {
			$(".item:hidden").slice(0, 12).fadeIn();
			if ($(".item:hidden").length < 1) {
				$(this).fadeOut();
			}
		});
	});
</script>


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
								<c:when test="${fn:contains(sessionScope.account.roles, 'admin')}">
									<td style="padding-left: 30px"><b><a
											class="nav-link ${param.activeRanking}"
											href="/MusicWebsite/views/admin/admin.jsp">Management</a></b></td>
								</c:when>
									<c:otherwise>
									<td style="padding-left: 30px"><b><a
										class="nav-link ${param.activeRanking}"
										href="/MusicWebsite/views/pages/upgradePre.jsp">Premium</a></b></td>
									</c:otherwise>
								</c:choose>
								<td style="padding-left: 30px"><b><a class="nav-link"
										href="/MusicWebsite/views/pages/playlist.jsp?type=playlist">Playlist</a></b></td>
								<td style="padding-left: 10px"><b><a class="nav-link"
										href="/MusicWebsite/views/pages/favorite.jsp">Favorite</a></b></td>
								<td style="padding-left: 10px"><b><a class="nav-link"
										href="/MusicWebsite/views/pages/singer.jsp">Artist</a></b></td>
								<td style="padding-left: 10px"><b><a class="nav-link"
										href="/MusicWebsite/views/pages/upgradePre.jsp">Premium</a></b></td>
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
					<i class="bi bi-person-circle"></i>
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
<<<<<<< HEAD
								
							<div style="color: red" class="login-recaptcha-mess"></div>
								
=======

								<div style="color: red" class="login-recaptcha-mess"></div>

>>>>>>> main
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
	<!--Container-->
	<div class="container">
		<!--SLIDER-->
		<div>
			<div class="content-bg active">
				<h1 class="topic-top" style="overflow: hidden;">Music For Gen Z</h1>
				<c:if test="${sessionScope.account==null}">
					<button class="btn btn-start-free" type="button"
						onclick="document.getElementById('login').style.display='flex'">Start
						Free Now</button>
				</c:if>
				<img src="/MusicWebsite/assets/img/Other/bg-landscape.png" class="d-block w-100"
					alt="...">
			</div>
		</div>
		<!--CardMusic-->

		<!-- All Music -->
		<div class="background-music" id="AllMusic">
			<br>
			<h1 class="topic-music topic-trending">
				<b>All Music</b>
			</h1>
			<div class="table-allMusic">
				<div class="table-divMusic">
					<jsp:useBean id="daoSong" class="database.DAOSong"
						scope="application"></jsp:useBean>
					<c:set var="listItems" value="${daoSong.selectAll()}"></c:set>
					<c:set var="isShowMore" value="false"></c:set>

					<c:forEach begin="0" end="${fn:length(listItems) - 1}" var="i">
						<c:set var="idSong" value="${listItems[i].getId_Song() }"></c:set>
						<c:set var="idAuTag" value="au${listItems[i].getId_Song() }"></c:set>
						<c:set var="idITag" value="bi${listItems[i].getId_Song() }"></c:set>
						<c:set var="nameSong" value="${listItems[i].name_Song }"></c:set>
						<c:set var="viewSong" value="${listItems[i].getSongViewUpdate()}"></c:set>
						<c:set var="nameSinger"
							value="${listItems[i].singer.name_Singer }"></c:set>
						<c:choose>
							<c:when test="${i >= 12 }">
								<div class="item all-music-item" style="display: none;">
									<div class="inner-table" id="${idSong}">
										<div class="inner-td">
											<img src="${listItems[i].url_Img}" width=75px height=75px
												alt="...">
											<button type="button" class="btn btn-music" id="${idSong}"
												onclick="playMusic(this.id, '${nameSong}', '${nameSinger}', '${listItems[i].url_Img}')">
												<audio src="${listItems[i].url_Audio}" class="${idAuTag}"></audio>
												<i class="${idITag} bi-play-circle"></i>
											</button>
										</div>
										<div class="song-singer inner-td">
											<b>${nameSong}</b> <br> <a href="" class="singer">${nameSinger}
											</a> <br>
											<div id="V${idSong}">${viewSong}</div>

										</div>

										<div class="inner-td">
											<button class="btn btn-inner-td">
												<i class="bi bi-share" style="color: white; font-size: 13px"></i>
											</button>
											<br>
											<button class="btn btn-inner-td">
												<i class="bi bi-download"
													style="color: white; font-size: 13px"></i>
											</button>
										</div>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="item all-music-item">
									<div class="inner-table" id="${idSong}">
										<div class="inner-td">
											<img src="${listItems[i].url_Img}" width=75px height=75px
												alt="...">
											<button type="button" class="btn btn-music" id="${idSong}"
												onclick="playMusic(this.id, '${nameSong}', '${nameSinger}', '${listItems[i].url_Img}')">
												<audio src="${listItems[i].url_Audio}" class="${idAuTag}"></audio>
												<i class="${idITag} bi-play-circle"></i>
											</button>
										</div>
										<div class="song-singer inner-td">
											<b>${nameSong} </b> <br> <a href="" class="singer">${nameSinger}
											</a> <br>
											<div id="V${idSong}">${viewSong}</div>


										</div>
										<div class="inner-td">
											<button class="btn btn-inner-td">
												<i class="bi bi-share" style="color: white; font-size: 13px"></i>
											</button>
											<br>
											<button class="btn btn-inner-td">
												<i class="bi bi-download"
													style="color: white; font-size: 13px"></i>
											</button>
										</div>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<br />
				<button class="show-more-btn" type="button">
					<b>Show More</b>
				</button>
			</div>
			<br />
		</div>
		<c:choose>
			<c:when
				test="${sessionScope.account != null && fn:length(daoSong.selectRecommendedSongs(sessionScope.account))>0}">
				<!-- Recommend Music -->
				<div class="background-music" id="Trending">
					<br>
					<h1 class="topic-music topic-trending">
						<b>Recommend Music</b>
					</h1>
					<div class="table-allMusic">
						<div class="trendingTable">

							<c:forEach
								items="${daoSong.selectRecommendedSongs(sessionScope.account)}"
								var="trending">
								<div class="item trending-box">
									<div class="card background-music">
										<div class="img-form">
											<img src="${trending.url_Img}" class="card-img-top"
												alt="${trending.name_Song}">
											<div class="icon-in-img">
												<a class="inner-icon-in-img"
													href="ListSongController?typelist=Ranking&id=${trending.id_Song}"><i
													style="font-size: 50px" class="bi-play-circle"></i></a>
											</div>
										</div>
										<div>
											<h5 class="title-trending">
												<b>${trending.name_Song}</b>
											</h5>
											<h6 class="title-trending">
												<b>${trending.singer.name_Singer}</b>
											</h6>
											<h6 class="title-trending">
												<div id="V${idSong}">${trending.getSongViewUpdate()}</div>
											</h6>
										</div>
									</div>

								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</c:when>
		</c:choose>

		<!-- Ranking -->

		<div class="background-music" id="Ranking">
			<br>
			<h1 class="topic-music topic-trending">
				<b>Ranking</b>
			</h1>
			<div class="table-allMusic">
				<div class="trendingTable">
					<c:set var="listRank" value="${daoSong.ranking}"></c:set>
					<c:forEach begin="0" end="${fn:length(listRank) - 1}" var="i">
						<div class="item trending-box">
							<div class="card background-music">
								<div class="img-form">
									<img src="${listRank[i].url_Img}" class="card-img-top"
										alt="...">
									<div class="icon-in-img">
										<a class="inner-icon-in-img"
											href="ListSongController?typelist=Ranking&id=${listRank[i].id_Song}"><i
											style="font-size: 50px" class="bi-play-circle"></i></a>
									</div>
								</div>
								<div>
									<h5 class="title-trending">
										<b>${listRank[i].name_Song}</b>
									</h5>
									<h6 class="title-trending">
										<b>${listRank[i].singer.name_Singer}</b>


									</h6>
									<h6 class="title-trending">
										<div id="V${idSong}">${listRank[i].getSongViewUpdate()}</div>
									</h6>
								</div>
							</div>

						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<!--Fix Footer-->
	<jsp:include page="/views/components/footer.jsp"></jsp:include>
	<script src="/MusicWebsite/assets/js/login.js"></script>
	<script src="/MusicWebsite/assets/js/main.js"></script>
	<script src='https://www.google.com/recaptcha/api.js'></script>
<!-- 	<script type="text/javascript"> -->
// 		formLogin.addEventListener('submit', (e) => {
// 			captchaResponse = grecaptcha.getResponse();
// 			console.log(captchaResponse)
			
// 			if (!captchaResponse.length > 0) {
// 				document.querySelector('.login-recaptcha-mess').innerHTML = "Please verify that you are not a robot.";
// 				e.preventDefault();
// 			}
// 		});
<!-- 	</script> -->
</body>


</html>