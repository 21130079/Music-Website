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
<link rel="icon" type="image/x-icon" href="/MusicWebsite/assets/img/Other/logoPage.png">
<title>Playlist</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="/MusicWebsite/assets/css/style.css" />

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

.add-music {
	width: 240px;
	height: 240px;
	margin-top: 10px;
}

.edit-button {
	border: none;
	background-color: transparent;
}

.bi-trash {
	color: white;
	font-size: 23px;
	padding: -18px;
	width: 20px;
	height: 20px;
	line-height: 20px;
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
		<div class="background-music" id="trending">
			<br>
			<h1 class="topic-music topic-trending">
				<b>Playlist</b>
			</h1>
			<div class="table-allMusic">
				<div class="trendingTable playlist-table">
					<div class="add-music">
						<a href="/MusicWebsite/AddPlaylistController" style="display: block">
							<button type="button"
								style="width: 100%; height: 100%; background-color: rgb(63, 63, 63);">
								<i class="bi bi-plus-circle"
									style="font-size: 55px; margin: 100px auto; display: flex; justify-content: center;"></i>
							</button>
						</a>
					</div>
					<c:forEach var="playlist" items="${account.playlists}">

						<div class="item trending-box">
							<div class="card background-music">
								<form action="navPlaylist.jsp" method="get"
									class="inner-icon-in-img">
									<input type="hidden" name="idplaylist"
										value="${playlist.id_Playlist}">
									<button class="img-form" type="submit"
										style="width: 260px; height: 260px; background-color: #171717; border: none;">
										<img src="/MusicWebsite/${playlist.url_Img}" class="card-img-top" alt="...">
										<c:if test="${fn:length(playlist.listSong)!=0}">
											<div class="icon-in-img">
												<i style="font-size: 50px" class="bi-play-circle"></i>

											</div>
										</c:if>
									</button>
								</form>

							</div>
							<div>
								<form action="/MusicWebsite/EditNamePlaylistController" method="get">
									<input type="hidden" name ="id_Playlist" value ="${playlist.id_Playlist}" />
									<h5 class="title-trending ${playlist.id_Playlist}">
										<b>${playlist.name}</b> <br>
										
										<button class="edit-button" type="button"
											onclick="editNamePlaylist('${playlist.id_Playlist}')">
											<i class="bi bi-pencil-square"></i>
										</button>
										
										<a class="edit-button" type="button"
											href="/MusicWebsite/RemovePlaylistController?idplaylist=${playlist.id_Playlist}">
											<i class="bi bi-trash"></i>
										</a>
									</h5>
								</form>
								<h6 class="title-trending">
									Tạo bởi: <b>${account.username}</b>
								</h6>
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
	<script src="/MusicWebsite/assets/js/playlist.js"></script>
</body>

</html>