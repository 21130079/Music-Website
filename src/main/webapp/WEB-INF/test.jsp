<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
try {
    // Lấy đối tượng HttpServletRequest từ request
    HttpServletRequest request1 = (HttpServletRequest) request;

    // Lấy địa chỉ IP từ header 'X-Forwarded-For'
    String ipAddress = request1.getHeader("X-Forwarded-For");
    
    // Kiểm tra nếu 'X-Forwarded-For' không tồn tại hoặc trống
    if (ipAddress == null || ipAddress.isEmpty()) {
        // Nếu không có header 'X-Forwarded-For', lấy địa chỉ IP từ 'RemoteAddr'
        ipAddress = request.getRemoteAddr();
    } else {
        // Nếu có header 'X-Forwarded-For', lấy địa chỉ IP đầu tiên trong danh sách
        // (X-Forwarded-For có thể chứa nhiều địa chỉ IP do proxy chèn)
        String[] ipList = ipAddress.split(",");
        ipAddress = ipList[0].trim();
    }
    
    // In địa chỉ IP ra trình duyệt
    out.println("Địa chỉ IP của bạn là: " + ipAddress);
} catch (Exception e) {
    e.printStackTrace();
}
%>
</body>
</html>