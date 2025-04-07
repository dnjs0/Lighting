package com.lighting.chat;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.lighting.chat.model.ChatDTO;

@WebServlet("/chat/chat.do")
public class Chat extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private ChatService chatService;
    
    @Override
    public void init() throws ServletException {
        chatService = new ChatService();
    }
    
    // POST: 채팅 메시지 저장
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain; charset=UTF-8");
        
        HttpSession session = req.getSession();
        String tblMemberSeq = (String) session.getAttribute("auth");
        if(tblMemberSeq == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            PrintWriter out = resp.getWriter();
            out.write("Unauthorized: 로그인 필요");
            out.flush();
            return;
        }
        
        String nickname = req.getParameter("nickname");
        String content = req.getParameter("content");
        if(nickname == null || content == null || nickname.isEmpty() || content.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            PrintWriter out = resp.getWriter();
            out.write("Bad Request: partnerId 와 message 필수");
            out.flush();
            return;
        }
        
        String chatRoomSeq = chatService.getChatRoomSeq(tblMemberSeq, nickname);
        if(chatRoomSeq == null) {
            chatRoomSeq = chatService.createChatRoom(tblMemberSeq, nickname);
        }
        
        chatService.insertChatHistory(chatRoomSeq, tblMemberSeq, content, "0");
        
        PrintWriter out = resp.getWriter();
        out.write("메시지 전송 완료");
        out.flush();
    }
    
    // GET: 특정 채팅방의 채팅 내역 조회
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String tblMemberSeq = (String) session.getAttribute("auth");
        if(tblMemberSeq == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            PrintWriter out = response.getWriter();
            out.write("Unauthorized: 로그인 필요");
            out.flush();
            return;
        }
        
        String nickname = request.getParameter("nickname");
        if(nickname == null || nickname.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            PrintWriter out = response.getWriter();
            out.write("Bad Request: nickname 필수");
            out.flush();
            return;
        }
        
        String chatRoomSeq = chatService.getChatRoomSeq(tblMemberSeq, nickname);
        if(chatRoomSeq == null) {
            JSONArray jsonArray = new JSONArray();
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.write(jsonArray.toString());
            out.flush();
            return;
        }
        
        List<ChatDTO> messages = chatService.getChatHistory(chatRoomSeq);
        JSONArray jsonArray = new JSONArray();
        for(ChatDTO dto : messages) {
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("chatHistorySeq", dto.getTblChatHistorySeq());
            jsonObj.put("chatRoomSeq", dto.getTblChatRoomSeq());
            // 내가 보낸 메시지면 "나"로, 아니면 상대 닉네임 사용
            jsonObj.put("sender", tblMemberSeq.equals(dto.getTblMemberSeq()) ? "나" : nickname);
            jsonObj.put("content", dto.getContent());
            jsonObj.put("postDate", dto.getPostDate().toString());
            jsonObj.put("status", dto.getStatus());
            jsonArray.add(jsonObj);
        }
        
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.write(jsonArray.toString());
        out.flush();
    }
}
