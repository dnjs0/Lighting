package com.lighting;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lighting.model.MainDTO;

@WebServlet("/main.do")
public class Main extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String tblMemberSeq = (String) session.getAttribute("auth");
        
        MainService service = new MainService();
        List<MainDTO> meetingList = service.getMeetingListForMain(tblMemberSeq);
        
        req.setAttribute("meetingList", meetingList);
        req.getRequestDispatcher("/WEB-INF/views/main.jsp").forward(req, resp);
    }
}
