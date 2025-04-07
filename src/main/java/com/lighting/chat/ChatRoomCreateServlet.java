package com.lighting.chat;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ChatRoomCreateServlet")
public class ChatRoomCreateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ChatService chatService;
    
    @Override
    public void init() throws ServletException {
        chatService = new ChatService();
    }
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        String tblMemberSeq = (String) session.getAttribute("auth");
        String nickname = req.getParameter("nickname");
        
        String generatedChatRoomSeq = chatService.createChatRoom(tblMemberSeq, nickname);
        
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        if(generatedChatRoomSeq != null) {
            out.print("{\"tblChatRoomSeq\":\"" + generatedChatRoomSeq + "\"}");
        } else {
            out.print("{\"error\":\"채팅방 생성 실패\"}");
        }
        out.flush();
    }
}
