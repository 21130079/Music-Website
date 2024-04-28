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
<title>Playlist</title>
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

<style type="text/css">
</style>
</head>
<jsp:include page="../components/header.jsp"></jsp:include>
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
				<input type="hidden" name="type" value="playlist"> <input
					type="hidden" name="idplaylist" value="${param.idplaylist}">
			</form>
		</div>
		<c:choose>
			<c:when test="${param.idplaylist!=null}">
				<c:set var="idPlaylist" value="${param.idplaylist}"></c:set>
			</c:when>
			<c:otherwise>
				<c:set var="idPlaylist" value="${idplaylist}"></c:set>
			</c:otherwise>

		</c:choose>
		 
		<c:forEach var="song"
			items="${account.getPlaylist(idPlaylist).listSong}">
			<div class="listSong-item teamplate-listsong" id="${song.id_Song}">
				<div
					style="display: grid; grid-template-columns: 40px 100px auto; column-gap: 10px">
					<i
						style="font-size: 30px; display: flex; padding: 29px 0px; overflow: hidden;"
						class="bi bi-music-note-beamed"></i>
					<div style="position: relative;">
						<img class="img${song.id_Song }" src="${song.url_Img}"
							style="width: 66px; padding: 15px 0px;" alt="" />
						<button type="button" class="btn btn-music" id="${song.id_Song}"
							onclick="playMusic(this.id, '${song.name_Song}', '${song.singer.name_Singer}', '${song.url_Img}')">
							<audio src="${song.url_Audio}" class="au${song.id_Song}"></audio>
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
						href="/MusicWebsite/RemoveNavPlaylist?idsong=${song.id_Song}&idplaylist=${param.idplaylist}">
						<button type="button" onclick="reload()">
							Delete <i class="bi bi-x-square-fill"></i>
						</button>
					</a> <a href="${song.url_Audio}" download="${song.name_Song}.mp3">
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
	<script src="/MusicWebsite/assets/js/login.js"></script>
	<script src='https://www.google.com/recaptcha/api.js'></script>
</body>
</html>