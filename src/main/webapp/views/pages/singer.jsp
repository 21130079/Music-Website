
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
<link rel="icon" type="image/x-icon"
	href="/MusicWebsite/assets/img/Other/logoPage.png">
<title>Singer</title>
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
body {
	background-color: #171717 !important;
	overflow-x: hidden;
}
.topic-music{
	width: 90%;

}
.singer_descriptiont{
background-color: black;padding: 1px;height: 78.4px;width: 222.4px
}
.trendingTable {
	border-collapse: collapse;
	
	display: grid;
	    width: 80% ;
	    margin-left:100px!important;
	grid-template-columns: 1fr 1fr 1fr 1fr !important;
	row-gap: 25px;
	column-gap: 12px;
}
.table-allMusic {
  
    margin-top: 15px;
}
</style>
</head>
<jsp:include page="../components/header.jsp"></jsp:include>
<body>
	<jsp:useBean id="daosinger" class="database.DAOSinger" scope="request"></jsp:useBean>

	<c:forEach var="singer" items="${daosinger.getSongsOfSinger(0)}">
		<div class="table-allMusic">
			<h1 class="topic-music">
				<b>${singer.key}</b>
			</h1>
			<div class="trendingTable">
				<c:forEach var="song" items="${singer.value}">
					<div class="item trending-box">
						<div class="card background-music">
							<div class="img-form">
								<img src="${song.url_Img}" class="card-img-top" alt="...">
								<div class="icon-in-img">

									<a class="inner-icon-in-img" href=""><i
										style="font-size: 50px" class="bi-play-circle"></i></a>


								</div>
							</div>
							<div class="singer_descriptiont">
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
</body>

<script src="/MusicWebsite/assets/js/login.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(window).scroll(function() {
			if ($(window).scrollTop() >= $(document).height() - $(window).height() * 1.1) {
				$.ajax({
					url : "/MusicWebsite/LazyLoadingController",
					type : "get",
					success : function(data) {
						$('body').append(data);
					}
				});
			}
		});
	});
</script>
</html>