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
<link rel="icon" type="image/x-icon"
	href="MusicWebsite/assets/img/Other/logoPage.png">
<title>Admin</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.css"
	rel="stylesheet">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.6/css/jquery.dataTables.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.js"></script>
<script src="https://cdn.datatables.net/2.0.3/js/dataTables.js"></script>
<script
	src="https://cdn.datatables.net/2.0.3/js/dataTables.bootstrap4.js"></script>

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
.card{
background-color: transparent !important;
}

.content-bg {
	
}
#data_wrapper{
background-color: transparent;
display: grid;
	row-gap: 10px;
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
.row {
background-color: transparent !important;
}
.justify-content-between{
margin-left: 4.8% !important;
width: 90% !important;
color: white;

}
.dt-search label{
margin-bottom: 0px !important;
word-spacing: 10px;
}
.dt-search{
display: flex;
align-items: center;
justify-content: center;

}
.dt-length{
	justify-self: end;
}
table{
color: white;
text-align:  center;
align-items: center;
}

.song_img{
	width: 100px;
	height: 100px;
}
.bi-trash{
 	font-size: 20px;
 	margin-top: 5px;
}
/* .log_admin {
	color: white;
	margin-left: 100px;
}
.account_admin {
	color: white;
	margin-left: 100px;
} */
a {
text-decoration: none;
}
/* .log_admin:hover {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
}
.account_admin:hover {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
			text-decoration: none;
	
}

.song_admin {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
} */

.addsong{
	display: flex;
	justify-content: right;
	
}
.addsong a {
	
background-color: transparent;
	border: 1px solid #007BFF;
	border-radius: 5px;
	color: #007BFF;
	padding: 1px;
	margin-right: 6%;
	text-align: center;
}
.addsong button{
background-color: transparent;
color: #007BFF;
	padding: 3px 8px;
	
	text-align: center;
}
.plus{
color: white;
font-size: 20px;
font-weight: bold;
}
</style>



</head>
<jsp:include page="../components/admin_header.jsp"/>
<body>


	<!--Container-->
		
			<br>
				<div class="addsong">
					<a href="admin_add.jsp">
					<button> <i class="plus">+</i> Add Song</button>
					</a>
				</div>
			
				   <table id="data" class="table-bordered table-striped" style="width: 90%;margin-left: 5.5%">
						<thead>
							<tr>
							    <th>Song name</th>
							     <th>Image</th>
							    <th>Duration</th>
							    <th>Genre</th>
							    <th>Singer</th>
							    <th>View</th>
								<th></th>
							</tr>
					</thead>
				
					<jsp:useBean id="DAOSong" class="database.DAOSong"></jsp:useBean>
					<tbody>
					<c:forEach var="song" items="${DAOSong.selectAll()}">
								
								<tr>
									<td>${song.name_Song}</td>
									<td><img class="song_img" src="${song.url_Img}"></td>
									<td>${song.duration}</td>
									<td>${song.genre}</td>
									<td>${song.singer.name_Singer}</td>
									<td>${song.songView}</td>
									<td>
										<div style="display: flex; align-items: center; justify-content: center;"> <a class="edit-button" type="button"
											style="padding-right: 10px"
											href="/MusicWebsite/EditSongController?idSong=${song.id_Song}">
											<i class="bi bi-pencil-square"></i>
										</a> 
										<div class="delete-btn" id="${song.id_Song}" ><i class="bi bi-trash"></i></div>
										</div>
									 </td>
								 </tr>
								
						
					</c:forEach>
					</tbody>
					</table>

</body>
		<script type="text/javascript">
	
    $(document).ready(function () {
        let table = $('#data').DataTable({
            "paging":true,
            "seaching":true
        });
        
        $('.delete-btn').click(function() {
            let idSong = $(this).attr("id");
            let button = $(this);

            $.ajax({
                url: '/MusicWebsite/DeleteSongController',
                type: 'get',
                data: { idSong:idSong},
                success: function(response) {
                    table.row(button.closest("tr")).remove().draw(true);
                },
                error: function() {
                    // Handle error
                }
            });
        });
        
    });
	</script>

<script src='https://www.google.com/recaptcha/api.js'></script>
</html>