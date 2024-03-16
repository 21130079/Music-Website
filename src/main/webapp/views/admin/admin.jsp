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
<title>Admin</title>

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
	padding-right: 100px;
	font-size: 20px;
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
				<b>Admin</b>
			</h1>
			<div class="table-allMusic">
				<div class="trendingTable">
					<div class="add-music">
						<a href="admin_add.jsp" style="display: block">
							<button type="button"
								style="width: 100%; height: 100%; background-color: rgb(63, 63, 63);">
								<i class="bi bi-plus-circle"
									style="font-size: 55px; margin: 100px auto; display: flex; justify-content: center;"></i>
							</button>
						</a>
					</div>

					<jsp:useBean id="DAOSong" class="database.DAOSong"></jsp:useBean>
					<c:forEach var="song" items="${DAOSong.selectAll()}">
						<div class="item trending-box">
							<div class="card background-music">
								<div class="img-form">
									<img src="/MusicWebsite/${song.url_Img}" class="card-img-top" alt="...">
									
								</div>
								<div>
									<form action="">
										<h5 class="title-trending ${song.id_Song }">
											<b>${song.name_Song}</b>
										</h5>
										<a class="edit-button" type="button" style="padding-right: 10px;margin-left: 12px;"
											href="/MusicWebsite/EditSongController?idSong=${song.id_Song}"> <i
											class="bi bi-pencil-square"></i></a> <a class="edit-button"
											type="button"
											href="/MusicWebsite/DeleteSongController?idSong=${song.id_Song }"> <i
											class="bi bi-trash"></i>
										</a>
									</form>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</body>

</html>