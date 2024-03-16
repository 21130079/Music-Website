
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="database.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/x-icon" href="/MusicWebsite/assets/img/Other/logoPage.png">
<title>Singer</title>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="/MusicWebsite/assets/css/style.css">
<style type="text/css">
body{
	background-color: #171717 !important;
	overflow-x: hidden;
}

.trendingTable {
	border-collapse: collapse;
	display: grid;
	grid-template-columns: 25% 25% 25% 25%;
	row-gap: 25px;
	column-gap: 12px;
}



</style>
</head>
<body>
	<jsp:include page="/views/components/header.jsp"></jsp:include>
	<div>
		<jsp:useBean id="daosinger" class="database.DAOSinger" scope="request"></jsp:useBean>
			
			<c:forEach var ="singer" items="${daosinger.songsOfSinger}">
			
			<div class="table-allMusic">
				<h1 class="topic-music">
				<b>${singer.key}</b>
				</h1>
				<div class="trendingTable">
					<c:forEach var="song" items="${singer.value}">
						<div class="item trending-box">
							<div class="card background-music">
								<div class="img-form">
									<img src="/MusicWebsite/${song.url_Img}" class="card-img-top"
										alt="...">
									<div class="icon-in-img">

										<a class="inner-icon-in-img" href="navListSong.jsp"><i
											style="font-size: 50px" class="bi-play-circle"></i></a>

										
									</div>
								</div>
								<div>
									<h5 class="title-trending">
										<b>${song.getName_Song()}</b>
									</h5>
									<h6 class="title-trending">
										<b>${song.getSinger().getName_Singer()}</b>
									</h6>
								</div>
							</div>

						</div>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>

</body>
</html>