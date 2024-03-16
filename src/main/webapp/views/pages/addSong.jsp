
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/x-icon"
	href="/MusicWebsite/assets/img/Other/logoPage.png">
<title>Insert title here</title>

<style type="text/css">
.acceptBtn {
	background-color: transparent;
	width: 90%;
	margin-left: 5%;
	margin-top: 15px;
	margin-bottom: 20px;
	color: crimson;
	border: 2px solid crimson;
	border-radius: 30px;
	padding: 10px 0px;
	color: crimson;
	font-size: 24px;
}

.show-more-btn-add-song {
	display: flex;
	background-color: #171717;
	border: 2px solid crimson;
	border-radius: 20px;
	color: crimson;
	padding: 10px 17px;
	font-size: 18px;
	margin: 10px;
	margin-right: 10px;
	float: right;
	margin-right: 7%;
}

.checkbox {
	width: 35px;
	height: 35px;
	margin: 30px;
}
</style>
<%@include file="/views/components/header.jsp"%>
</head>

<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".show-more-btn-add-song").click(function(e) {
			$(".listSong-item:hidden").slice(0, 4).fadeIn();
			if ($(".listSong-item:hidden").length < 5) {
				$(this).fadeOut();
			}
		});
	});
</script>
<body>


	<div class="listSong">

		<div class="listSong-title">

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
				<label><h3>Option</h3></label>
			</div>
		</div>


		<c:choose>
			<c:when test="${fn:contains(type,'favorite')}">
				<c:url var="url" value="/AddFavoriteController">
				</c:url>
			</c:when>
			<c:otherwise>
				<c:url var="url" value="/AddNavPlaylist">
					<c:param name="idPlaylist" value="${idplaylist}"></c:param>
				</c:url>
			</c:otherwise>
		</c:choose>
		<form action="${url}" method="get">
			<c:set var="i" value="${0}" />
			<c:forEach var="song" items="${listNotInType}">
				<c:set var="i" value="${i + 1}" />
				<c:choose>
					<c:when test="${i>4}">
						<div class="listSong-item" style="display: none;">
							<div
								style="display: grid; grid-template-columns: 40px 100px auto; column-gap: 10px">
								<i
									style="font-size: 30px; display: flex; padding: 29px 0px; overflow: hidden;"
									class="bi bi-music-note-beamed"></i>
								<div style="position: relative;">
									<img src="${song.url_Img}"
										style="width: 66px; padding: 15px 0px;" alt="" /> <i
										class="bi bi-play-fill"></i>
								</div>


								<div style="margin: 22px 0px">
									<p>${song.name_Song}</p>
									<p style="opacity: 0.8; color: white;">${song.singer.name_Singer}</p>
								</div>
							</div>
							<div>
								<p>${song.genre}</p>
							</div>
							<div class="duration">${song.duration}</div>
							<input type="checkbox" class="checkbox" name="idSong"
								value="${song.id_Song}">

						</div>
					</c:when>
					<c:otherwise>
						<div class="listSong-item">
							<div
								style="display: grid; grid-template-columns: 40px 100px auto; column-gap: 10px">
								<i
									style="font-size: 30px; display: flex; padding: 29px 0px; overflow: hidden;"
									class="bi bi-music-note-beamed"></i>
								<div style="position: relative;">
									<img src="${song.url_Img}"
										style="width: 66px; padding: 15px 0px;" alt="" /> <i
										class="bi bi-play-fill"></i>
								</div>


								<div style="margin: 22px 0px">
									<p>${song.name_Song}</p>
									<p style="opacity: 0.8; color: white;">${song.singer.name_Singer}</p>
								</div>
							</div>
							<div>
								<p>${song.genre}</p>
							</div>
							<div class="duration">${song.duration}</div>
							<input type="checkbox" class="checkbox" name="idSong"
								value="${song.id_Song}">

						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<div>
				<button type="button" class="show-more-btn-add-song">Show
					More</button>
			</div>
			<button class="acceptBtn" type="submit">Confirm</button>
			<input type="hidden" name="type" value="${type}"> <input
				type="hidden" name="idplaylist" value="${idplaylist}">
		</form>
	</div>
</body>
</html>