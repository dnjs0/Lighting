package com.lighting.chat;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.lighting.chat.model.ChatDTO;

@WebServlet("/chat/chatview.do")
public class ChatView extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String tblMemberSeq = (String) session.getAttribute("auth");
        
        if(tblMemberSeq == null) {
            resp.sendRedirect(req.getContextPath() + "/user/login.do");
            return;
        }
        
        ChatService chatService = new ChatService();
        List<ChatDTO> chatRooms = chatService.getChatRooms(tblMemberSeq);
        req.setAttribute("chatRooms", chatRooms);
        
        // 채팅방 목록을 보여줄 JSP (View)로 포워딩
        req.getRequestDispatcher("/WEB-INF/views/chat/chatview2.jsp").forward(req, resp);
    }
}
