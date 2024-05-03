<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

<link rel="stylesheet" type="text/css"
	href="/MusicWebsite/assets/css/style.css">
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

.justify-content-between {
	color: white;
}

#data td {
	color: black;
	background-color: white;
}

th {
	background-color: white;
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

/* .log_admin {
	color: white;
	margin-left: 100px;
}

.account_admin {
	color: white;
	margin-left: 100px;
}

.log_admin:hover {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
}

.account_admin {
	color: white;
	margin-left: 100px;
} */

/* .account_admin:hover {
	color: black;
	text-decoration: none;
}
 */
/* .account_admin {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
	text-decoration: none;
} */

/* .song_admin:hover {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
}

.song_admin {
	color: white;
	margin-left: 100px;
} */
</style>
</head>
<jsp:include page="../components/admin_header.jsp"/>
<body>

	<br>
	<div class="title"
		style="display: flex; justify-content: space-between; width: 100%; margin-top: 20px">
		<div style="display: flex;">
			<h1 class="topic-music topic-trending">
				<b>Admin</b>
			</h1>
			<h2>
				<a class="log_admin" style="text-decoration: none;"
					href="/MusicWebsite/views/admin/admin_log.jsp">Log</a>
			</h2>
			<h2>
				<a class="account_admin"
					href="/MusicWebsite/views/admin/admin_account.jsp">Account</a>

			</h2>
			<h2>
				<a class="song_admin" style="text-decoration: none;"
					href="/MusicWebsite/views/admin/admin.jsp">Song</a>
			</h2>
		</div>

>>>>>>> 335797e9ec5b09eedcba9652e99fad19a9e2f7ed
		<button style="color: black; float: right;" onclick="getSelectedIds()">Delete
			selected</button>


	</div>
	<jsp:useBean id="daoLog" class="database.DAOLog"></jsp:useBean>
	<c:set var="listItems" value="${daoLog.selectAll()}"></c:set>

	<table id="data" class="table-bordered table-striped"
		style="width: 100%">
		<thead>
			<tr>
				<th></th>
				<th>User name</th>
				<th>Password</th>
				<th>Email</th>
				<th>Role</th>
				<th></th>
			</tr>
		</thead>
	</table>
</body>

<script src="/MusicWebsite/assets/js/login.js"></script>
<script>
	function getSelectedIds() {
		var selectedIds = [];
		var checkboxes = document.querySelectorAll('.checkbox');
		checkboxes.forEach(function(checkbox) {
			if (checkbox.checked) {
				selectedIds.push(checkbox.id);
			}
		});

		if (selectedIds.length > 0) {
			$.ajax({
				url : '/MusicWebsite/RemoveAccountController',
				type : 'get',
				data : {
					selectedIds : selectedIds
				},
				success : function(response) {
					alert('Đã xóa các log đã chọn');
					window.location.reload();

				},
				error : function() {
					alert('Đã xảy ra lỗi.');
				}
			});
		} else {
			alert("Không có phần tử nào được chọn.");
		}
	}
	$(document)
			.ready(
					function() {
						$
								.ajax({
									url : "/MusicWebsite/AccountAPI",
									type : "get",
									dataType : "json",
									success : function(data) {

										$("#data")
												.dataTable(
														{
															data : data.data,


															columns : [
																	{
																		data : null,
																		render : function(
																				data,
																				type,
																				row) {
																			var checkboxId = data.username; // Assuming id is a unique identifier in your data
																			var checkboxClass = "checkbox"; // Set your desired class here
																			return '<input type="checkbox" id="' + checkboxId + '" class="' + checkboxClass + '">';
																		}
																	},
																	{
																		data : 'username'
																	},
																	{
																		data : 'password'
																	},
																	{
																		data : 'email'
																	},
																	{
																		data : 'roles'
																	},
																	{
																		"data" : null,
																		"render" : function(
																				data,
																				type,
																				row) {
																			return '<a href="/MusicWebsite/RemoveAccountController?username='
																					+ data.username
																					+ '"><button style="color: black;">Delete</button></a>';
																		}
																	} ]
														});

									},
									error : function(jqXHR, textStatus,
											errorThrown) {
										console.log("Error: " + errorThrown);
									}
								});

					})
</script>
<script src='https://www.google.com/recaptcha/api.js'></script>
</html>