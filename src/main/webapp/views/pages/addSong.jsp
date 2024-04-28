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
<script src="https://cdn.datatables.net/2.0.3/js/dataTables.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.css"
	rel="stylesheet">
<link
	href="https://cdn.datatables.net/2.0.3/css/dataTables.bootstrap4.css"
	rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.js"></script>
<script src="https://cdn.datatables.net/2.0.3/js/dataTables.js"></script>
<script
	src="https://cdn.datatables.net/2.0.3/js/dataTables.bootstrap4.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css"
	href="/MusicWebsite/assets/css/style.css">

<title>Insert title here</title>

<style type="text/css">
#SongTable th, #SongTable td {
    border: 1px solid #ddd; /* Đặt border cho các ô */
    padding: 8px; /* Khoảng cách giữa nội dung và border */
    text-align: left; /* Căn lề nội dung */
}

#SongTable_wrapper{
	width: 90% !important;
	margin-left:5.5%;
	color:white;
	margin-top: 20px;
}
#SongTable th {
    background-color: grey; /* Màu nền cho tiêu đề */
    color: black; /* Màu chữ cho tiêu đề */
}

#SongTable tbody tr:nth-child(even) {
    background-color: #1a1a1a; /* Màu nền cho hàng chẵn trong chế độ tối */
    color: #fff; /* Màu chữ cho hàng chẵn trong chế độ tối */
}

/* Định nghĩa màu nền cho hàng lẻ */
#SongTable tbody tr:nth-child(odd) {
    background-color: #242424; /* Màu nền cho hàng lẻ trong chế độ tối */
    color: #fff; /* Màu chữ cho hàng lẻ trong chế độ tối */
}
div.dt-container div.row{
background-color: #171717;
}
.acceptBtn {
	background-color: transparent;
	width: 90%;
	margin-left: 5.5%;
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
#SongTable{
	background:black;
width: 100% !important;
	
	}
	
	.custom-select{
	padding: .25rem 1rem !important;
	}

.checkbox {
	width: 35px;
	height: 35px;
	margin: 30px;
}



</style>
</head>

<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".show-more-btn-add-song").click(function(e) {
			$(".listSong-item:hidden").slice(0, 4).fadeIn();
			if ($(".listSong-item:hidden").length < 1) {
				$(this).fadeOut();
			}
		});
	});
</script>
		<jsp:include page="../components/header.jsp"></jsp:include>
<body>

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
    <table id="SongTable" class="display stripe">
        <thead>
            <tr>
                <th><i style="font-size: 30px; padding-left: 40px;" class="bi bi-music-note-list"></i> <label for="">Song</label></th>
                <th>Genre</th>
                <th>Duration</th>
                <th>Option</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="song" items="${listNotInType}">
                <tr>
                    <td> 
                        <div style="display: grid; grid-template-columns: 40px 100px auto; column-gap: 10px">
                            <i style="font-size: 30px; display: flex; padding: 29px 0px; overflow: hidden;" class="bi bi-music-note-beamed"></i>
                            <div style="position: relative;">
                                <img src="${song.url_Img}" style="width: 66px; padding: 15px 0px;" alt="" /> <i class="bi bi-play-fill"></i>
                            </div>
                            <div style="margin: 22px 0px">
                                <p>${song.name_Song}</p>
                                <p style="opacity: 0.8; color: white;">${song.singer.name_Singer}</p>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div>
                            ${song.genre}
                        </div>
                    </td>
                    <td> 
                        <div class="duration">${song.duration}</div>
                    </td>
                    <td> 
                        <input type="checkbox" class="checkbox" name="idSong" value="${song.id_Song}">
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div>
      
        <button class="acceptBtn" type="submit">Confirm</button>
        <input type="hidden" name="type" value="${type}"> 
        <input type="hidden" name="idplaylist" value="${idplaylist}">
    </div>
</form>
<script type="text/javascript">
$(document).ready(function() {
    var table = $('#SongTable').DataTable({
        "paging": true, // Cho phép phân trang nếu cần
        "searching": true // Cho phép tìm kiếm	
    });
});
</script>

<script src='https://www.google.com/recaptcha/api.js'></script>
</html>