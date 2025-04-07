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

@WebServlet("/searchdata.do")
public class SearchData extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        String searchKeyword = req.getParameter("searchKeyword");
        String tblCategorySubSeq = req.getParameter("tblCategorySubSeq");
        HttpSession session = req.getSession(true);
        String tblMemberSeq = (session != null && session.getAttribute("auth") != null)
                ? (String) session.getAttribute("auth") : null;
        
        MainService service = new MainService();
        List<MainDTO> meetingList = service.searchMeetingPosts(searchKeyword, tblCategorySubSeq, tblMemberSeq);
        
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
        
        PrintWriter writer = resp.getWriter();
        writer.print(arr);
        writer.close();
    }
}
