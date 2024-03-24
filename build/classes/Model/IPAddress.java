package test1;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import org.json.JSONObject;

public class IPAddress {
	
	public String getIPPublic() {
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
	public String nameCountry(String ipAddress) {
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
	public static void main(String[] args) {
		IPAddress t = new IPAddress();
		String ip = t.getIPPublic();
		String name = t.nameCountry(ip);
		System.out.println(name);
		
	}
}
