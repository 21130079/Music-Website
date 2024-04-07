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
<jsp:include page="/views/components/header.jsp"></jsp:include>
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


<style>
* {
	color: white;
}

#data td {
	color: black;
	background-color: white;
}
</style>
</head>
<body>
	<div class="title"
		style="display: flex; justify-content: space-between; width: 100%; margin-top: 20px">
		<div style="display: flex;">
			<h1 class="topic-music topic-trending">
				<b>Admin</b>
			</h1>
			<h2>
				<a
					style="text-decoration:none; color: black; border: 1px solid black; background-color: white; margin-left: 40px; padding: 3px 60px 3px 60px; border-radius: 20px 20px 20px 20px;"
					href="/MusicWebsite/views/admin/admin_log.jsp">Log</a>
			</h2>
		</div>

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
	$(document).ready(function() {
		$.ajax({
			url : "/MusicWebsite/LogAPI",
			type : "get",
			dataType : "json",
			success : function(data) {
				var students = data.data;
				for (var i = 0; i < students.length; i++) {
					var student = students[i];
					console.log("ID: " + data.id_log);
				}
				$("#data").dataTable({
					data : data.data,

					columns : [ {
						data : null,
						render : function(data, type, row) {
							 var checkboxId =  data.idLog; // Assuming id is a unique identifier in your data
	                            var checkboxClass = "checkbox"; // Set your desired class here
	                            return '<input type="checkbox" id="' + checkboxId + '" class="' + checkboxClass + '">';
						}
					}, {
						data : 'idLog'
					}, {
						data : 'nationality'
					}, {
						data : 'levelLog'
					}, {
						data : 'addressPerforming'
					}, {
						data : 'preValue'
					}, {
						data : 'currentValue'
					}, {
						data : 'updatedDate'
					}, {
						data : 'status'
					}, { 
                        "data": null, 
                        "render": function (data, type, row) {
                            return '<a href="/MusicWebsite/RemoveLogController?idlog=' + data.idLog + '"><button style="color: black;">Delete</button></a>';
                        }
                    } ]
				});

			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("Error: " + errorThrown);
			}
		});

	})
</script>
</html>