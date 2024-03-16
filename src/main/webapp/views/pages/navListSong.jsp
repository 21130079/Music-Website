<%@page import="java.util.ArrayList"%>
<%@ page import="database.*"%>
<%@ page import="Model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="#" />
<style type="text/css">
.container {
	height: 500px;
}

.inner-container {
	display: grid;
	grid-template-columns: 50% 50%;
	background-color: #171717;
	padding: 20px 0px;
}

body {
	background-color: #171717;
}

.Music-play {
	align-items: center;
	display: inline-flex;
	justify-content: center;
	height: 580px;
}

.nav-Music-play {
	width: 25rem;
}

.listSong {
	display: grid;
}

.listSong-item-nav {
	display: grid;
	grid-template-columns: 88% 12%;
	border-bottom: 0.1px solid gray;
	align-items: center;
	width: 90%;
}

.decrip-Music-play {
	display: flex;
	justify-content: center;
	margin: auto;
	color: white;
}

.img-play {
	width: 25rem;
	object-fit: contain;
	border-radius: 25px;
}

.duration {
	color: white;
}

p {
	margin-top: 0px;
	margin-bottom: 0rem !important;
}

.listSong-title-nav {
	display: inline-flex;
	right: 90px;
	position: absolute;
	color: blue;
}

.bi-play-circle:not(.footer-play), .bi-pause-circle:not(.footer-play) {
	position: absolute;
	display: flex;
	top: 30%;
	font-size: 43px;
	left: 6%;
}

#volume {
	position: absolute;
	width: 20px; height : 200px;
	appearance: slider-vertical;
	margin-left: -520px;
	margin-top: -150px;
	height: 200px
}

.bi-volume-up, .bi-volume-mute {
	position: absolute;
	margin-left: -510px;
	margin-top: 100px;
}
</style>
<link rel="icon" type="image/x-icon" href="/MusicWebsite/assets/img/Other/logoPage.png">
<title>List Song</title>
</head>
<body>
	<jsp:include page="/views/components/header.jsp"></jsp:include>
	<!--audio playing -->
	<div id="auPlaying"></div>

	<!-- container -->
	<div class="container">
		<div class="inner-container">
			<div class="Music-play">

				<input id="volume" type="range" value=50
					onchange="volumeHandler()" /> <i style="font-size: 50px"
					class="bi volume bi-volume-up" onclick="muteVolume()"></i>

				<div class="nav-Music-play">
					<img src="/MusicWebsite/${song.url_Img}" class="img-play" alt="..."> <br>
					<br>
					<h3 class="decrip-Music-play ">${song.name_Song}</h3>
					<h5 class="decrip-Music-play">${song.singer.name_Singer}</h5>
					<table class="decrip-Music-play">
						<tr>
							<td style="padding: 0px 10px">
								<button class="btn-footer shuffle" onclick="shuffleMode()">
									<i style="font-size: 30px" class="bi bi-shuffle"></i>
								</button>
							</td>
							<td style="padding: 0px 10px">
								<button class="btn-footer skip-before" onclick="skipBefore()">
									<i style="font-size: 30px" class="bi bi-skip-start-fill"></i>
								</button>
							</td>
							<td style="padding: 0px 10px">
								<button class="btn-footer pause-footer"
									onclick="playMainMusic(this.id)" id="${id}">
									<i style="font-size: 50px"
										class="footer-play bi bi-play-circle"></i>
								</button>
							</td>
							<td style="padding: 0px 10px">
								<button class="btn-footer skip-after" onclick="skipAfter()">
									<i style="font-size: 30px" class="bi bi-skip-end-fill"></i>
								</button>
							</td>
							<td style="padding: 0px 10px">
								<button class="btn-footer repeat" onclick="repeatMode()">
									<i style="font-size: 30px" class="bi bi-arrow-repeat"></i>
								</button>
							</td>
						</tr>
					</table>
					<input id="progress" style="width: 400px; height: 2px;"
						type="range" value="0" step="1" min="0" max="100" />
				</div>
			</div>

			<div class="listSong">
				<i style="font-size: 32px;
 						 padding-left: 59px; "
					class="bi bi-music-note-list"></i>
				<div class="listSong-title-nav">
						
					<label style="padding: 0px 300px; font-size: 20px" for="">Song</label> 
						<label
						style="font-size: 20px" for="">Duration</label>
				</div>
				<div style="height: 20px"></div>


				<c:forEach begin="0" end="${fn:length(listSong) - 1 }" var="i">
					<c:set var="idSong" value="${listSong[i].id_Song }"></c:set>
					<c:set var="idAuTag" value="au${listSong[i].id_Song }"></c:set>
					<c:set var="idITag" value="bi${listSong[i].id_Song }"></c:set>
					<c:set var="nameSong" value="${listSong[i].name_Song}"></c:set>
					<c:set var="nameSinger" value="${listSong[i].singer.name_Singer}"></c:set>
					
					<div class="listSong-item-nav" id="${listSong[i].id_Song}">
						<div
							style="display: grid; grid-template-columns: 35px 200px auto; column-gap: 10px">
							<i
								style="font-size: 30px; display: flex; padding: 29px 0px; overflow: hidden;"
								class="bi bi-music-note-beamed"></i>
							<div style="position: relative;">
								<img src="${listSong[i].url_Img}"
									style="width: 66px; padding: 15px 0px;" alt="" />
								<button
									style="margin-left: -50px; background-color: transparent; border: none"
									onclick="playMusic('${idSong}')">
									<audio src="/MusicWebsite/${listSong[i].url_Audio}" class="${idAuTag}"></audio>
									<i class="${idITag} bi bi-play-circle"></i>
								</button>
							</div>

							<div style="margin: 22px 0px">
								<p class="name-song" style="color: white;">${listSong[i].name_Song}</p>
								<p class="name-singer" style="opacity: 0.8; color: white;">${listSong[i].singer.name_Singer}</p>
							</div>
						</div>
						<div class="duration">${listSong[i].duration}</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/MusicWebsite/assets/js/listSong.js"></script>
</body>
</html>