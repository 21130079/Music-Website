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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css"
	rel="stylesheet">	
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"
	integrity="sha384-Atwg2Pkwv9vp0ygtn1JAojH0nYbwNJLPhwyoVbhoPwBhjQPR5VtM2+xf0Uwh9KtT"
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>

<jsp:include page="views/components/header.jsp" />
<body>

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
				<img src="/MusicWebsite/assets/img/Other/bg-landscape.png"
					class="d-block w-100" alt="...">
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
					<c:set var="listItems" value="${daoSong.selectNext12Products(0)}"></c:set>
					<c:set var="isShowMore" value="false"></c:set>

					<c:forEach begin="0" end="${fn:length(listItems) - 1}" var="i">
						<c:set var="idSong" value="${listItems[i].getId_Song() }"></c:set>
						<c:set var="idAuTag" value="au${listItems[i].getId_Song() }"></c:set>
						<c:set var="idITag" value="bi${listItems[i].getId_Song() }"></c:set>
						<c:set var="nameSong" value="${listItems[i].name_Song }"></c:set>
						<c:set var="viewSong" value="${listItems[i].getSongViewUpdate()}"></c:set>
						<c:set var="nameSinger"
							value="${listItems[i].singer.name_Singer }"></c:set>
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
									<b>${nameSong} </b> <br> <b class="singer">${nameSinger}
									</b> <br>
									<div id="V${idSong}">${viewSong}</div>


								</div>
								<div class="inner-td">
								
									<i class="bi bi-share" style="color: white; font-size: 13px"></i>
									<br> 
									<a href="${listItems[i].url_Audio}" download> 
										<i class="bi bi-download" style="color: white; font-size: 13px"></i>
									</a>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<br />
				<button class="show-more-btn" type="button" onclick="showMore()">
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
	<script type="text/javascript">
		// Lưu trạng thái của âm nhạc trước khi chuyển trang
		window.addEventListener('beforeunload', function() {
			sessionStorage.setItem('audioProgress', audio.currentTime);
		});

		// Khôi phục trạng thái của âm nhạc sau khi trang được tải
		window.addEventListener('load', function() {
			var audio = document.querySelector('.auSO01');
			if (sessionStorage.getItem('audioProgress')) {
				audio.currentTime = parseFloat(sessionStorage
						.getItem('audioProgress'));
			}
		});
	</script>

	<jsp:include page="/views/components/footer.jsp"></jsp:include>
	<script type="text/javascript" src="/MusicWebsite/assets/js/login.js"></script>
	<script type="text/javascript" src="/MusicWebsite/assets/js/main.js"></script>
	<script src='https://www.google.com/recaptcha/api.js'></script>
</body>


</html>