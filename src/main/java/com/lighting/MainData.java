package com.lighting;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import com.lighting.model.MainDTO;

@WebServlet("/maindata.do")
public class MainData extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categorySubSeq = req.getParameter("tblCategorySubSeq");
        String showAll = req.getParameter("showAll");
        HttpSession session = req.getSession();
        String tblMemberSeq = (session != null) ? (String) session.getAttribute("auth") : null;
        
        MainService service = new MainService();
        List<MainDTO> meetingList = service.getMeetingList(categorySubSeq, tblMemberSeq, showAll);
        
        JSONArray arr = new JSONArray();
        for (MainDTO dto : meetingList) {
            JSONObject obj = new JSONObject();
            obj.put("tblMeetingPostSeq", dto.getTblMeetingPostSeq());
            obj.put("tblMemberSeq", dto.getTblMemberSeq());
            obj.put("tblCategorySubSeq", dto.getTblCategorySubSeq());
            obj.put("meetingPhoto", dto.getMeetingPhoto());
            obj.put("title", dto.getTitle());
            obj.put("memberPhoto", dto.getMemberPhoto());
            obj.put("nickname", dto.getNickname());
            obj.put("capacity", dto.getCapacity());
            arr.add(obj);
        }
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter writer = resp.getWriter();
        writer.print(arr);
        writer.close();
    }
}
