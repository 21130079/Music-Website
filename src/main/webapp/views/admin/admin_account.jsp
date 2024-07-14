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
	position: relative;
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
#edit_account,#add_account,#confirm_pass{
	background-color: white;
 position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  display: grid;
  row-gap:10px;
  padding:10px 50px;
  height: 550px;
 
}
#confirm_pass{
height: auto;

box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); 
}
#roles{
	display: flex;
	justify-content: space-around;
	align-items: center;
}
.roles{
display: flex;
    align-items: center;

}
.roles input{
margin-left: 10px;
margin-right: 2px;
}
.bi-x{
	position: absolute;
	    font-size: 40px;
	    right:0px;
	    top:-10px;
	    color: red;
	   	font-weight: bold;
	   	cursor: pointer;
}
.wrapper_account{
	top:0px;
	left:0px;
	width: 100%;
	position:absolute;
	height: 100vh;
		 display: none;
}
.confirm_delete {
background-color: #f9f9f9;
    border: 1px solid #ccc;
    padding: 20px;
    width: 300px;
    color:black !important;
    text-align: center;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
   box-shadow: 0 0 20px rgba(0, 0, 0, 0.6); 
   display: none;
}

.confirm_delete p {
    margin-bottom: 10px;
}

.confirm_delete input[type="button"] {
    background-color: #4CAF50;
    padding: 5px 10px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.confirm_delete input[type="button"]:hover {
    background-color: #45a049;
}

</style>
<jsp:include page="../components/admin_header.jsp"/>
</head>

<body>
	<br>	
		<div class="feature">
		<a>
					<button id="add-account"> <i class="plus">+</i> Add Account</button>
					</a>
		<button onclick="showConfirmDeleteAll()"> Delete
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
	<div class="wrapper_account" id="wrapper_edit">
	<form id="edit_account" action="/MusicWebsite/UpdateAccountController" method="post">
	<div></div>
			<i class="bi bi-x" id="x_edit_acc"></i>
			<h2>Change Information Account</h2>
			<input type="text" id="edit_username"  readonly placeholder="username" name="username" required="required">
			<input type="email"  id="edit_email" placeholder="email" name="email" required="required">
			<input type="password" id="edit_password" placeholder="password" name="password" required="required">
			<div >
			
			<div>Role</div>
				<div id="roles">
					<div class="roles">User: <input type="checkbox" id="cb_edit_role_user" name="user" value="user"> user</div>
					<div class="roles">Admin: <input type="radio" id="ra_edit_role_admin" name="admin" value="admin"> admin  
								   <input type="radio" name="admin" id="ra_edit_role_spadmin" value="super admin"> super admin
							</div>
				</div>
			</div>
			
			<h4>Confirm Your Password</h4>
			<input type="password" placeholder="your password" name="spAdminPassword" required="required">
			<button type="submit">submit</button>
	</form>
	</div>
	
			<c:choose>
				<c:when test="${param.errorAccount==null}">
					<c:set var="display" value="none"></c:set>
				</c:when>
				<c:otherwise>
					<c:set var="display" value="grid"/>
				</c:otherwise>
			</c:choose>
			
	<div class="wrapper_account"  id="wrapper_add" style="display: ${display}">
	<form id="add_account" action="/MusicWebsite/AddAccountController" method="post">
	<div></div>
			<i class="bi bi-x" id="x_add_acc"></i>
			<h2>Create New Account</h2>
			<input type="text" placeholder="username" name="username" required="required">
			<input type="email" placeholder="email" name="email" required="required">
			<input type="password" placeholder="password" name="password" required="required">
			<div >
				<div>Role</div>
	
				<div id="roles">
					<div class="roles">User: <input type="checkbox" name="user" value="user"> user</div>
					<div class="roles">Admin: <input type="radio"  name="admin" value="admin"> admin  
								   <input type="radio" name="admin"  value="super admin"> super admin
							
							</div>
				</div>
			</div>
			<div style="color: red">${param.errorAccount}</div>
			<h4>Confirm Your Password</h4>
			<input type="password" placeholder="your password" name="spAdminPassword" required="required">
			<button type="submit" id="submit_to_add_acc">Submit</button>
	</form>
	</div>
	<div class="confirm_delete" id="confirmdelete">
	<i class="bi bi-x" onclick="hiddenDelete()" id="x_delete_acc"></i>
    <p id ="msg"style="color: black;">Are you sure you want to delete?</p>
        <input  class="delete-btn" type="button" onclick="hiddenDelete() " value="OK">
</div>
<div class="confirm_delete" id="confirm_delete_all">
	<i class="bi bi-x" id="x_delete_all" onclick="hiddenDeleteAll()"></i>
    <p id ="msg"style="color: black;">Are you sure you want to delete all selections?</p>
        <input  id="delecteAccounts_btn" type="button" onclick="hiddenDeleteAll()" value="OK">
</div>

</body>

<script src="/MusicWebsite/assets/js/login.js"></script>
<script>
	function showConfirmDelete(msg) {
		$("#msg").text("Are you sure you want to delete " + msg + "?");
		$("#confirmdelete").css("display","block");
		 $(".delete-btn").attr("id", msg);
	}
	function showConfirmDeleteAll() {
		$("#confirm_delete_all").css("display","block");
	}
	function hiddenDelete() {
		$('#confirmdelete').css('display','none');
}

function hiddenDeleteAll() {
		$('#confirm_delete_all').css('display','none');
}
    $(document).ready(function() {
    	$(".delete-btn").click(function() {
            let username = $(this).attr("id");
            let button = $("div #"+username);
			console.log(username);
            $.ajax({
                url: '/MusicWebsite/RemoveAccountController',
                type: 'get',
                data: { username:username},
                success: function(response) {
                	 $("#data").DataTable().row(button.closest("tr")).remove().draw(true);
                },
                error: function() {
                    // Handle error
                }
            });
        });

        $.ajax({
            url: "/MusicWebsite/AccountAPI",
            type: "get",
            dataType: "json",
            success: function(data) {
                $("#data").dataTable({
                    data: data.data,
                    columns: [
                        {
                            data: null,
                            render: function(data, type, row) {
                                var checkboxId = data.username;
                                var checkboxClass = "checkbox";
                                return '<input type="checkbox" id="' + checkboxId + '" class="' + checkboxClass + '">';
                            }
                        },
                        { data: 'username' },
                        { data: 'password' },
                        { data: 'email' },
                        { data: 'roles' },
                        {
                            data: null,
                            render: function(data, type, row) {
                                return '<div style="display: flex; align-items: center; justify-content: center;">' +
                                    '<a class="edit-button" id="' + data.username + '" type="button" style="padding-right: 10px" ' +
                                    '  >' +
                                    '<i class="bi bi-pencil-square "></i></a>' +
                                    '<div onclick="showConfirmDelete(this.id)" style="cursor: pointer;" id="' + data.username + '">' +
                                    '<i class="bi bi-trash"></i></div></div>';
                            }
                        }
                    ]
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("Error: " + errorThrown);
            }
        });

        $('#delecteAccounts_btn').click(function() {
		    $('.checkbox:checked').each(function() {
		        var checkbox = $(this);
		        $.ajax({
		            url: '/MusicWebsite/RemoveAccountController',
		            type: 'get',
		            data: {
		            	username: checkbox.attr('id')
		            },
		            success: function(response) {
		            	 $("#data").DataTable().row(checkbox.closest("tr")).remove().draw(true);
		            },
		            error: function() {
		                // Handle error
		               
		            }
		        });
		    });
		});

		
        $(document).on('click', '.edit-button', function() {
        	
                 let username = $(this).attr("id");
                 console.log(username);
                 let button = $(this);

                 $.ajax({
                     url: '/MusicWebsite/EditAccountController',
                     type: 'get',
                     data: { username:username},
                     success: function(response) {
                     	
                     	let rowIndex = $(this).closest('tr').index(); 
                     	var rowData = $('#data').DataTable().row(rowIndex).data();
                     	$('#edit_username').val(response.username);
                        $('#edit_email').val(response.email);
                        $('#edit_password').val(response.password);
                        console.log(response.roles);
                        if (response.roles.includes("user")) {
                            $('#cb_edit_role_user').prop('checked', true);
                        }else{
                        	  $('#cb_edit_role_user').prop('checked', false);
                        }
                        if (response.roles.includes("admin")) {
                        	$('#ra_edit_role_admin').prop('checked', true); 
                        } else if (response.roles.includes("super admin")) {
                            $('#ra_edit_role_spadmin').prop('checked', true); 
                        }else{
                        	$('#ra_edit_role_admin').prop('checked', false); 
                        	 $('#ra_edit_role_spadmin').prop('checked', false); 
                        }
                        
                     },
                     error: function() {
                         // Handle error
                     }
                 });
            
        });

        
        $('#add-account').click(function showUi() {
        	
			$('#wrapper_add').css('display','grid');
		});
        $(document).on('click', '.edit-button', function() {
            $('#wrapper_edit').css('display', 'grid');
        });
		$('#x_add_acc').click(function hidenUi() {
			$('#wrapper_add').css('display','none');
		});
		$('#x_edit_acc').click(function hidenUi() {
			$('#wrapper_edit').css('display','none');
		});
		
		
		
		
		
    });

</script>

<script src='https://www.google.com/recaptcha/api.js'></script>
</html>