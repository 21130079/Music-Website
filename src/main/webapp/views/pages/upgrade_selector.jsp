<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script src="/MusicWebsite/assets/js/jquery-1.11.3.min.js"></script>
<title>Document</title>
</head>
<style>
body {
	width: 100%;
	height:100%;
	display: grid;	
	justify-content: center;
	margin: 0px;

}

#container {
	
	margin-top: 30px;
	width: 700px;
	height: 100%;
	display:grid;
	border-radius: 10px;
	padding: 10px 20px;
	box-shadow: 0 4px 8px rgba(33, 38, 44, .16);
}

#selector_header {
	display: flex;
	justify-content: space-between;
	align-items: baseline;
}

#selector_body {
	
	width: 100%;
	display: grid;
	grid-template-rows: auto auto;
	row-gap: 30px;
}

#selector_body .payment_option:first-child {
	border-radius: 10px 10px 0px 0px;
    border: 1px solid black;
	box-shadow: 10px;
}

#selector_body .payment_option {
	
	border-radius:  0px 0px 10px 10px;
    border: 1px solid black;
}

.script_payment {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 20px;
	margin-bottom: 0px;
	;
}

p {
	font-size: 16px;
}

i {
	font-size: 40px;
	cursor: pointer;
}

.payment_box {
	width: 90%;
	margin-left: 3.5%;
	border: 1px solid black;
	margin-bottom: 10px;
	padding: 10px;
	border-radius: 10px;
	
}
.payment_box:hover{
 background-color: rgba(0, 0, 0, 0.1);
 box-shadow: 0 4px 8px rgba(33, 38, 44, .16);
}

button {
	cursor: pointer;
}

input {
	border: none;
	display: inline;
	font-family: inherit;
	font-size: 20px;
	color: black;
	padding: none;
	width: auto;
	background-color: transparent;
	outline: none;
	width: 100px
}
</style>
<body>
	<div id="container">

		<div id="selector_header">
			<div>
				<h2>You have chosen</h2>
				<h2>
					<font color="${color}">Premium ${title}</font>
				</h2>

			</div>
			<div class=description_box>
				<a href="/MusicWebsite/views/pages/upgradePre.jsp">Change to premium package</a>

			</div>
		</div>
		<div id="selector_body">
			<h2>Pay once in advance, not automatically renewed.</h2>
			<div id="paymment_options">
			
				<form class="payment_option" action="/MusicWebsite/ajaxServlet"
					id="frmCreateOrder1" method="post">
					<input type="hidden" name = "amount" value="${optionPrice1}">
					<div class="script_payment">
						<div>
							<h2>${optionPrice1}₫ for ${optionText1}</h2>
							
						</div>
						
					</div>
					<button type="submit" class="payment_box" id="pay_1">
						<p>Pay with VNPay</p>
						<i></i>
					</button>
				</form>


				<form class="payment_option" action="/MusicWebsite/ajaxServlet"
					id="frmCreateOrder2" method="post">
					<div class="script_payment">
					<input type="hidden" name = "amount" value="${optionPrice2}">
						<div>
							<h2>${optionPrice2}₫ for ${optionText2}</h2>
						</div>
						
					</div>
					<button type="submit" class="payment_box" id="pay_2">
						<p>Pay with VNPay</p>
						<i></i>
					</button>
				</form>

			</div>
		</div>
	</div>

	<link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
	<script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
	<script type="text/javascript">
		$("#frmCreateOrder1").submit(function() {
			var postData = $("#frmCreateOrder1").serialize();
			var submitUrl = $("#frmCreateOrder1").attr("action");
			$.ajax({
				type : "POST",
				url : submitUrl,
				data : postData,
				dataType : 'JSON',
				success : function(x) {
					if (x.code === '00') {
						if (window.vnpay) {
							vnpay.open({
								width : 768,
								height : 600,
								url : x.data
							});
						} else {
							location.href = x.data;
						}
						return false;
					} else {
						alert(x.Message);
					}
				}
			});
			return false;
		});
		
		$("#frmCreateOrder2").submit(function() {
			var postData = $("#frmCreateOrder2").serialize();
			var submitUrl = $("#frmCreateOrder2").attr("action");
			$.ajax({
				type : "POST",
				url : submitUrl,
				data : postData,
				dataType : 'JSON',
				success : function(x) {
					if (x.code === '00') {
						if (window.vnpay) {
							vnpay.open({
								width : 768,
								height : 600,
								url : x.data
							});
						} else {
							location.href = x.data;
						}
						return false;
					} else {
						alert(x.Message);
					}
				}
			});
			return false;
		});
	</script>
	<script type="text/javascript">
		function showPaymentMethod(id, iconElement) {
			var payment_box = document.getElementById(id);
			if (payment_box.style.display == "grid") {
				payment_box.style.display = "none";
				iconElement.classList.add("bi-arrow-down-square");
				iconElement.classList.remove("bi-arrow-up-square");
			} else {
				payment_box.style.display = "grid";
				iconElement.classList.remove("bi-arrow-down-square");
				iconElement.classList.add("bi-arrow-up-square");
			}
		}
	</script>
</body>
</html>