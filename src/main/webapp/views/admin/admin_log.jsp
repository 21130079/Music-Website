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

<style>
* {
	color: white;
}

#data td {
	color: black;
	background-color: white;
}

/* .log_admin {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
	text-decoration: none;
}

.log_admin:hover {
	color: black;
}

.account_admin {
	color: white;
	margin-left: 100px;
} */
/* 
.account_admin:hover {
	color: black;
	border: 1px solid black;
	background-color: white;
	margin-left: 100px;
	padding: 3px 60px 3px 60px;
	border-radius: 20px 20px 20px 20px;
	text-decoration: none;
}

.song_admin:hover {
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

		<button style="color: black; float: right;" onclick="getSelectedIds()">Delete
			selected</button>


	
	<jsp:useBean id="daoLog" class="database.DAOLog"></jsp:useBean>
	<c:set var="listItems" value="${daoLog.selectAll()}"></c:set>

	<table id="data" class="table-bordered table-striped"
		style="width: 100%">
		<thead>
			<tr>
				<th></th>
				<th>ID</th>
				<th>National</th>
				<th>Level</th>
				<th>Address performing</th>
				<th>Previous value</th>
				<th>Current value</th>
				<th>Date</th>
				<th>Status</th>
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
				url : '/MusicWebsite/RemoveLogController',
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
									url : "/MusicWebsite/LogAPI",
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
																			var checkboxId = data.idLog; // Assuming id is a unique identifier in your data
																			var checkboxClass = "checkbox"; // Set your desired class here
																			return '<input type="checkbox" id="' + checkboxId + '" class="' + checkboxClass + '">';
																		}
																	},
																	{
																		data : 'idLog'
																	},
																	{
																		data : 'nationality'
																	},
																	{
																		data : 'levelLog'
																	},
																	{
																		data : 'addressPerforming'
																	},
																	{
																		data : 'preValue'
																	},
																	{
																		data : 'currentValue'
																	},
																	{
																		data : 'updatedDate'
																	},
																	{
																		data : 'status'
																	},
																	{
																		"data" : null,
																		"render" : function(
																				data,
																				type,
																				row) {
																			return '<a href="/MusicWebsite/RemoveLogController?idlog='
																					+ data.idLog
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