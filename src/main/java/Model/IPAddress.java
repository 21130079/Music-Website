package Model;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import org.json.JSONObject;

import jakarta.servlet.http.HttpServletRequest;

public class IPAddress {
	
	public static String getIPPublic() {
		String result = "";
		  try {
	            URL url = new URL("http://checkip.amazonaws.com");
	            URLConnection conn = url.openConnection();
	            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String publicIP = reader.readLine().trim();
	          
	            result+=publicIP;
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
		return result;
	}
	
	    public static String getClientIpAddress(HttpServletRequest request) {
	        String ipAddress = request.getHeader("X-Forwarded-For");
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getHeader("Proxy-Client-IP");
	        }
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getHeader("WL-Proxy-Client-IP");
	        }
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
	        }
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getHeader("HTTP_X_FORWARDED");
	        }
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getHeader("HTTP_X_CLUSTER_CLIENT_IP");
	        }
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getHeader("HTTP_CLIENT_IP");
	        }
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getHeader("HTTP_FORWARDED_FOR");
	        }
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getHeader("HTTP_FORWARDED");
	        }
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getHeader("HTTP_VIA");
	        }
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getHeader("REMOTE_ADDR");
	        }
	        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	            ipAddress = request.getRemoteAddr();
	        }
	        return ipAddress;
	    }
	
	public static String getNameCountry(String ipAddress) {
		String result = "";
		try {  
            URL url = new URL("https://ipinfo.io/" + ipAddress + "/json");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");
            
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + conn.getResponseCode());
            }
            
            BufferedReader br = new BufferedReader(new InputStreamReader(
                (conn.getInputStream())));
            
            String output;
            StringBuilder response = new StringBuilder();
            
            while ((output = br.readLine()) != null) {
                response.append(output);
            }
            
            conn.disconnect();
            
            JSONObject jsonObject = new JSONObject(response.toString());
            
            String country = jsonObject.getString("country");
           result += country;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
		return result;
	}

}
