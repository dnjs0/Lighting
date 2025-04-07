package com.lighting;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import com.lighting.model.MainDAO;

public class WeatherService {

    private static final String API_URL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
    private static final String AUTH_KEY = "j6HKCi8s4LL9mRV%2FFfnurB8qjGDnvcJkoWOnJXH8q1VIqhraXMaTUGgtv7FDv7Sp2DhrSaDGzvNo599YB16w%2BQ%3D%3D";
    
    public JSONObject getWeatherData(String tblMemberSeq) {
        String location = "서울특별시 강남구"; // 기본값
        double latitude = 37.5;
        double longitude = 127.0;
        
        MainDAO dao = new MainDAO();
        if (tblMemberSeq != null) {
            location = dao.getUserLocation(tblMemberSeq);
            double[] coords = dao.getUserCoordinates(tblMemberSeq);
            if (coords != null && coords.length == 2) {
                latitude = coords[0];
                longitude = coords[1];
            }
        }
        dao.close();
        
        // 위경도를 nx, ny 좌표로 변환
        int[] xy = convertToXY(latitude, longitude);
        int nx = xy[0];
        int ny = xy[1];
        
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String baseDate = dateFormat.format(cal.getTime());
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int previousHour = (hour - 1 + 24) % 24;
        String baseTime = String.format("%02d00", previousHour);
        
        String temperature = "";
        String precipitationType = "";
        
        try {
            String nxStr = Integer.toString(nx);
            String nyStr = Integer.toString(ny);
            StringBuilder urlBuilder = new StringBuilder(API_URL);
            urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + AUTH_KEY);
            urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=10");
            urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=1");
            urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=JSON");
            urlBuilder.append("&" + URLEncoder.encode("base_date", "UTF-8") + "=" + URLEncoder.encode(baseDate, "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("base_time", "UTF-8") + "=" + URLEncoder.encode(baseTime, "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("nx", "UTF-8") + "=" + URLEncoder.encode(nxStr, "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("ny", "UTF-8") + "=" + URLEncoder.encode(nyStr, "UTF-8"));
            
            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            
            BufferedReader rd;
            if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();
            String result = sb.toString();
            
            JSONParser parser = new JSONParser();
            JSONObject root = (JSONObject) parser.parse(result);
            JSONObject response = (JSONObject) root.get("response");
            JSONObject body = (JSONObject) response.get("body");
            JSONObject items = (JSONObject) body.get("items");
            JSONArray itemArray = (JSONArray) items.get("item");
            
            for (Object obj : itemArray) {
                JSONObject item = (JSONObject) obj;
                String category = (String) item.get("category");
                String obsrValue = item.get("obsrValue").toString();
                if ("T1H".equals(category)) {
                    temperature = obsrValue;
                }
                if ("PTY".equals(category)) {
                    precipitationType = obsrValue;
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        JSONObject weatherObj = new JSONObject();
        weatherObj.put("location", location);
        weatherObj.put("temperature", temperature);
        weatherObj.put("precipitationType", precipitationType);
        return weatherObj;
    }
    
    // 좌표 변환 메서드 (위경도 -> 격자 좌표)
    private int[] convertToXY(double lat, double lng) {
        double RE = 6371.00877;
        double GRID = 5.0;
        double SLAT1 = 30.0;
        double SLAT2 = 60.0;
        double OLON = 126.0;
        double OLAT = 38.0;
        int XO = 43;
        int YO = 136;
        
        double DEGRAD = Math.PI / 180.0;
        double re = RE / GRID;
        double slat1Rad = SLAT1 * DEGRAD;
        double slat2Rad = SLAT2 * DEGRAD;
        double olonRad = OLON * DEGRAD;
        double olatRad = OLAT * DEGRAD;
        
        double sn = Math.tan(Math.PI * 0.25 + slat2Rad * 0.5) / Math.tan(Math.PI * 0.25 + slat1Rad * 0.5);
        sn = Math.log(Math.cos(slat1Rad) / Math.cos(slat2Rad)) / Math.log(sn);
        double sf = Math.tan(Math.PI * 0.25 + slat1Rad * 0.5);
        sf = Math.pow(sf, sn) * Math.cos(slat1Rad) / sn;
        double ro = Math.tan(Math.PI * 0.25 + olatRad * 0.5);
        ro = re * sf / Math.pow(ro, sn);
        
        double ra = Math.tan(Math.PI * 0.25 + lat * DEGRAD * 0.5);
        ra = re * sf / Math.pow(ra, sn);
        double theta = lng * DEGRAD - olonRad;
        if (theta > Math.PI) theta -= 2.0 * Math.PI;
        if (theta < -Math.PI) theta += 2.0 * Math.PI;
        theta *= sn;
        int nx = (int)Math.floor(ra * Math.sin(theta) + XO + 0.5);
        int ny = (int)Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
        return new int[]{nx, ny};
    }
}
