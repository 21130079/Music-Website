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
<title>Search</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="./assets/css/style.css" />

<style type="text/css">
body {
	overflow-x: hidden;
}
</style>
</head>

<body>
	<jsp:include page="/views/components/header.jsp"></jsp:include>
	<!--Container-->
	<div class="container">
		<jsp:useBean id="DAOSong" class="database.DAOSong" scope="request"></jsp:useBean>
		<c:set var="listSearchItems"
			value="${DAOSong.selectAllBySearch(searchInput)}"></c:set>
		<c:set var="isShowMore" value="false"></c:set>
		<c:set var="formatHeight" value=""></c:set>

		<c:if test="${fn:length(listSearchItems) < 19}">
			<c:set var="formatHeight" value="height: 644px"></c:set>
		</c:if>

		<div class="background-music" id="trending" style="${formatHeight}">
			<br>
			<h1 class="topic-music topic-trending">
				<b>Search for: ${searchInput }</b>
			</h1>

			<c:choose>
				<c:when test="${fn:length(listSearchItems) <= 0}">
					<h1 style="color: white;">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						There is no song named: ${searchInput }
					</h1>
				</c:when>
				<c:otherwise>
					<div class="table-allMusic">
						<div class="table-divMusic">
							<c:forEach begin="0" end="${fn:length(listSearchItems) - 1}"
								var="i">
								<c:set var="idSong" value="${listSearchItems[i].id_Song}"></c:set>
								<c:set var="idAuTag" value="au${listSearchItems[i].id_Song}"></c:set>
								<c:set var="idITag" value="bi${listSearchItems[i].id_Song}"></c:set>
								<c:set var="nameSong" value="${listSearchItems[i].name_Song }"></c:set>
								<c:set var="nameSinger"
									value="${listSearchItems[i].singer.name_Singer}"></c:set>


								<div class="item" id="${idSong}">
									<div class="inner-table">
										<div class="inner-td">
											<img src="${listSearchItems[i].url_Img}" width=75px
												height=75px alt="...">
											<button type="button" class="btn btn-music" id="${idSong}"
												onclick="playMusic(this.id, '${nameSong}', '${nameSinger}', '${listSearchItems[i].url_Img}')">
												<audio src="${listSearchItems[i].url_Audio}"
													class="${idAuTag}"></audio>
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
							</c:forEach>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			<br />
		</div>
	</div>
	<!--Fix Footer-->
	<jsp:include page="/views/components/footer.jsp"></jsp:include>

	<script src="/MusicWebsite/assets/js/search.js"></script>
</body>

</html>