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
<link rel="icon" type="image/x-icon" href="./assets/img/Other/logoPage.png">
<title>KD Music</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="./assets/css/style.css" />

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

.content-bg {
	
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
	<jsp:include page="/views/components/header.jsp"></jsp:include>
	<!--Container-->
	<div class="container">
		<!--SLIDER-->
		<div class="</div>">
			<div class="content-bg active">
				<h1 class="topic-top" style="overflow: hidden;">Music For Gen Z</h1>
				<c:if test="${sessionScope.account==null}">
				<button class="btn btn-start-free" type="button" onclick="document.getElementById('login').style.display='flex'">Start Free
					Now</button>
				</c:if>
				<img src="assets/img/Other/bg-landscape.png" class="d-block w-100"
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
											</a>
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
											<b>${nameSong}</b> <br> <a href="" class="singer">${nameSinger}
											</a>
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

												<!-- 		<button style="background-color: transparent; border: none;" >
											<i style="font-size: 25px; position: absolute; left: -55%;"
												class="bi bi-heart"></i>
										</button> -->
												<a class="inner-icon-in-img"
													href="ListSongController?typelist=Ranking&id=${trending.id_Song}"><i
													style="font-size: 50px" class="bi-play-circle"></i></a>

												<!-- <button style="background-color: transparent; border: none;">
											<i style="font-size: 27px; position: absolute; left: 87px;"
												class="bi bi-link-45deg"></i>
										</button> -->


											</div>
										</div>
										<div>
											<h5 class="title-trending">
												<b>${trending.name_Song}</b>
											</h5>
											<h6 class="title-trending">
												<b>${trending.singer.name_Singer}</b>
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
	<script src="/MusicWebsite/assets/js/main.js"></script>
</body>

</html>