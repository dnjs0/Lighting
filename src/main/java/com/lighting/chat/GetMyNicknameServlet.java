package com.lighting.chat;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lighting.chat.model.ChatDAO;

@WebServlet("/chat/getMyNickname.do")

public class GetMyNicknameServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //GetMyNicknameServlet.java
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("auth") != null) {
            String memberSeq = (String) session.getAttribute("auth");
            System.out.println("겟마이닉넴 " +memberSeq);
            // DB 접근 로직: memberSeq를 기반으로 닉네임 조회 
            ChatDAO dao = new ChatDAO();
            String nickname = dao.getNicknameBySeq(memberSeq);
            System.out.println("겟마이닉넴 " +memberSeq);
            resp.setContentType("application/json");
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write("{\"nickname\": \"" + nickname + "\"}");
            
            dao.close();
        } else {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인 필요");
        }


    }

}