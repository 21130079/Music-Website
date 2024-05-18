<%@page import="Model.ELevel.Level"%>
<%@page import="java.util.UUID"%>
<%@page import="Model.Notification"%>
<%@page import="database.DAONotification"%>
<%@page import="Model.HistoryPremium"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="Model.Account"%>
<%@page import="database.DAOHistoryPremium"%>
<%@page import="Controller.vnpay.Config"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<title>KẾT QUẢ THANH TOÁN</title>
<!-- Bootstrap core CSS -->
<link href="/MusicWebsite/assets/css/bootstrap.min.css" rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="/MusicWebsite/assets/css/jumbotron-narrow.css"
	rel="stylesheet">
<script src="/MusicWebsite/assets/js/jquery-1.11.3.min.js"></script>
</head>

<style>
#back {
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	border-radius: 5px;
	width: 120px;
	height: 40px;
	margin-left: 50px;
	border: none;
	background-color: white;
}

#back:hover {
	background: #f0f0f0;
	transition: 0.2s;
}

a {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: none;
	color: black;
}
</style>

<body>
	<div id="back">
		<a href="/MusicWebsite/index.jsp">&lt;&ensp;&ensp; Back</a>
	</div>
	<%
	//Begin process return from VNPAY
	Map fields = new HashMap();
	for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
		String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
		String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
		if ((fieldValue != null) && (fieldValue.length() > 0)) {
			fields.put(fieldName, fieldValue);
		}
	}

	String vnp_SecureHash = request.getParameter("vnp_SecureHash");
	if (fields.containsKey("vnp_SecureHashType")) {
		fields.remove("vnp_SecureHashType");
	}
	if (fields.containsKey("vnp_SecureHash")) {
		fields.remove("vnp_SecureHash");
	}
	String signValue = Config.hashAllFields(fields);
	%>
	<!--Begin display -->
	<div class="container">
		<div class="header clearfix">
			<h3 class="text-muted">KẾT QUẢ THANH TOÁN</h3>
		</div>
		<div class="table-responsive">
			<div class="form-group">
				<label>Mã giao dịch thanh toán:</label> <label><%=request.getParameter("vnp_TxnRef")%></label>
			</div>
			<div class="form-group">
				<label>Số tiền:</label> <label><%=request.getParameter("vnp_Amount")%></label>
			</div>
			<div class="form-group">
				<label>Mô tả giao dịch:</label> <label><%=request.getParameter("vnp_OrderInfo")%></label>
			</div>
			<div class="form-group">
				<label>Mã lỗi thanh toán:</label> <label><%=request.getParameter("vnp_ResponseCode")%></label>
			</div>
			<div class="form-group">
				<label>Mã giao dịch tại CTT VNPAY-QR:</label> <label><%=request.getParameter("vnp_TransactionNo")%></label>
			</div>
			<div class="form-group">
				<label>Mã ngân hàng thanh toán:</label> <label><%=request.getParameter("vnp_BankCode")%></label>
			</div>
			<div class="form-group">
				<label>Thời gian thanh toán:</label> <label><%=request.getParameter("vnp_PayDate")%></label>
			</div>
			<div class="form-group">
				<label>Tình trạng giao dịch:</label> <label> <%
 if (signValue.equals(vnp_SecureHash)) {
	Account acc = (Account) session.getAttribute("account");
	String amount = session.getAttribute("amount").toString();
	String period = session.getAttribute("period").toString();
	
 	if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
 		out.print("Thành công");

 		new DAONotification().insert(new Notification(UUID.randomUUID().toString(), acc.getUsername(), Level.INFO,
 		"Pay the " + amount + "₫ package in " + period + " successfully", null));

 		int typePre = 0;

 		switch ((String) request.getParameter("vnp_Amount").substring(0, 3)) {
 		case "200": {
 	typePre = 1;
 	break;
 		}
 		case "700": {
 	typePre = 2;
 	break;
 		}
 		case "550": {
 	typePre = 3;
 	break;
 		}
 		case "255": {
 	typePre = 4;
 	break;
 		}
 		case "450": {
 	typePre = 5;
 	break;
 		}
 		case "225": {
 	typePre = 6;
 	break;
 		}
 		}

 		HistoryPremium hist = new HistoryPremium(acc, typePre, null, null);
 		new DAOHistoryPremium().insert(hist);
 	} else {
 		out.print("Không thành công");
 		new DAONotification().insert(new Notification(UUID.randomUUID().toString(), acc.getUsername(), Level.INFO,
 		"Pay the " + amount + "₫ package in " + period + " failed", null));
 	}

 } else {
 	out.print("invalid signature");
 }
 %></label>
			</div>
		</div>
		<p>&nbsp;</p>
		<footer class="footer">
			<p>&copy; VNPAY 2020</p>
		</footer>
	</div>
</body>
</html>
