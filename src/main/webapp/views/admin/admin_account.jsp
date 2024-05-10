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


.justify-content-between {
	color: white;
}
#data_wrapper{
background-color: transparent;
display: grid;
	row-gap: 10px;
	width: 100%;
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
.feature{
	display: flex;
	justify-content: right;
	margin-right:6%; 
	column-gap: 10px;
	
}
.feature button{
	padding: 5px 10px !important;
	font-size: 16px !important;
	border-radius: 5px !important;
	}

.checkbox{
width: 18px;
height: 18px;
}
.plus{
color: white;
font-size: 18px;
font-weight: bold;
}
</style>
<jsp:include page="../components/admin_header.jsp"/>
</head>

<body>
	<br>	
		<div class="feature">
		<a href="admin_add.jsp">
					<button> <i class="plus">+</i> Add Account</button>
					</a>
		<button  id="delecteAccounts_btn">Delete
			selected</button>
		</div>


	<jsp:useBean id="daoLog" class="database.DAOLog"></jsp:useBean>
	<c:set var="listItems" value="${daoLog.selectAll()}"></c:set>

	<table id="data" class="table-bordered table-striped"
		style="width: 90%;margin-left: 5.5%">
		<thead>
			<tr style="color: black;background-color:lightgray;">
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
						$(delecteAccounts_btn).click(function getSelectedIds() {
						    var selectedIds = [];
						    $('.checkbox:checked').each(function() {
						        selectedIds.push($(this).attr('id'));
						    });

						    if (selectedIds.length > 0) {
						        $.ajax({
						            url: '/MusicWebsite/RemoveAccountController',
						            type: 'get',
						            data: {
						                selectedIds: selectedIds
						            },
						            success: function(response) {
						                $.each(selectedIds, function(index, id) {
						                	$("#data").DataTable().row($('#' + id).closest("tr")).remove().draw(true);

						                });
						            },
						            error: function() {
						                
						            }
						        });
						    } 
						});
						

					})
</script>
<script src='https://www.google.com/recaptcha/api.js'></script>
</html>