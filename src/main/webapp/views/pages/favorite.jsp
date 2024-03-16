<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="database.*"%>
<%@ page import="Model.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/x-icon" href="/MusicWebsite/assets/img/Other/logoPage.png">
<title>Favorite</title>

<jsp:include page="/views/components/header.jsp"></jsp:include>
</head>
<body>


	<div class="listSong">

		<div class="listSong-title teamplate-listsong">

			<div>
				<i style="font-size: 30px; padding-left: 40px;"
					class="bi bi-music-note-list"></i> <label for="">
					<h3>Song</h3>
				</label>
			</div>

			<div>
				<label for=""><h3>Genre</h3></label>
			</div>
			<div>
				<label><h3>Duration</h3></label>
			</div>
			<div>
				<label><h3>Feature</h3></label>
			</div>
		</div>
		<div class="addSongdiv">
			<form action="/MusicWebsite/SendToAddSongController" class="addSongCover">
				<button class="addSongbtn" onclick="reload()">
					<i style="font-size: 30px" class="bi bi-plus"></i> Add Song
				</button>
				<input type="hidden" name="type" value="favorite">
			</form>
		</div>


		<c:forEach var="song" items="${account.favoriteList}">
			<div class="listSong-item teamplate-listsong" id="${song.id_Song}">
				<div
					style="display: grid; grid-template-columns: 40px 100px auto; column-gap: 10px">
					<i
						style="font-size: 30px; display: flex; padding: 29px 0px; overflow: hidden;"
						class="bi bi-music-note-beamed"></i>
					<div style="position: relative;">
						<img class="img${song.id_Song} img-song" src="/MusicWebsite/${song.url_Img}"
							style="width: 66px; padding: 15px 0px;" alt="" />
						<button type="button" class="btn btn-music" id="${song.id_Song}"
							onclick="playMusic(this.id, '${song.name_Song}', '${song.singer.name_Singer}', '${song.url_Img}')">
							<audio src="/MusicWebsite/${song.url_Audio}" class="au${song.id_Song}"></audio>
							<i class="bi${song.id_Song} bi-play-circle"></i>
						</button>
					</div>


					<div style="margin: 22px 0px">
						<p class="nameSong${song.id_Song}">${song.name_Song}</p>
						<p class="nameSinger${song.id_Song}"
							style="opacity: 0.8; color: white;">${song.singer.name_Singer}</p>
					</div>
				</div>
				<div>
					<p>${song.genre}</p>
				</div>
				<div class="duration">${song.duration}</div>
				<div class="feature">
					<a
						href="/MusicWebsite/RemoveFavoriteController?idsong=${song.id_Song}">
						<button type="button" onclick="reload()">
							Delete <i class="bi bi-x-square-fill"></i>
						</button>
					</a> <a href="/MusicWebsite/${song.url_Audio}" download="${song.name_Song}.mp3">
						<button type="button">
							Download <i class="bi bi-box-arrow-down"></i>
						</button>
					</a>
				</div>
			</div>

		</c:forEach>
	</div>

	<jsp:include page="/views/components/footer.jsp"></jsp:include>
	<script type="text/javascript">
		function reload() {
			window.location.reload();
		}
	</script>
	<script src="/MusicWebsite/assets/js/navPlaylist.js" type="text/javascript"></script>
</body>
</html>