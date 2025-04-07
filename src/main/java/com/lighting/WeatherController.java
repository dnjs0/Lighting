package com.lighting;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

@WebServlet("/weather.do")
public class WeatherController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션에서 회원 정보를 추출 (없으면 null)
        HttpSession session = req.getSession(false);
        String tblMemberSeq = (session != null) ? (String) session.getAttribute("auth") : null;
        
        // WeatherService를 호출하여 날씨 데이터 획득
        WeatherService weatherService = new WeatherService();
        JSONObject weatherData = weatherService.getWeatherData(tblMemberSeq);
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter writer = resp.getWriter();
        writer.print(weatherData);
        writer.close();
    }
}
