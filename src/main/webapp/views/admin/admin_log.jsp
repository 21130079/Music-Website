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
.justify-content-md-center thead tr td {
	color:black !important;
} 
</style>
</head>
<jsp:include page="../components/admin_header.jsp"/>
<body>

	<br>
	<div class="feature">
		
		<button id="deleteLogs_btn">Delete
			selected</button>
		</div>

	 <br>


	<table id="data" class="table-bordered table-striped"
		style="width: 90%;margin-left: 5.5%">
		<thead>
			<tr style="color: black;background-color:lightgray;">
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

	$(document)
			.ready(function() {
					
						
						$.ajax({
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
																			return '<button style="color: black;" class="delete_btn" id="'+data.idLog+'">Delete</button></a>';
																		}
																	} ]
														});

									},
									error : function(jqXHR, textStatus,
											errorThrown) {
										console.log("Error: " + errorThrown);
									}
								});
						
						
							$('#deleteLogs_btn').click(function() {
							    $('.checkbox:checked').each(function() {
							        var checkbox = $(this);
							        $.ajax({
							            url: '/MusicWebsite/RemoveLogController',
							            type: 'get',
							            data: {
							            	idLog: checkbox.attr('id')
							            },
							            success: function(response) {
							            	 $("#data").DataTable().row(checkbox.closest("tr")).remove().draw(false);
							            },
							            error: function() {
							                // Handle error
							               
							            }
							        });
							    });
							});

							$(document).on('click', '.delete_btn', function() {
						            let idLog = $(this).attr("id");
						            let button = $(this);
									console.log(idLog);
						            $.ajax({
						                url: '/MusicWebsite/RemoveLogController',
						                type: 'get',
						                data: { idLog:idLog},
						                success: function(response) {
						                	 $("#data").DataTable().row(button.closest("tr")).remove().draw(false);
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