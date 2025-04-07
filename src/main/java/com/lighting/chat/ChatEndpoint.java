package com.lighting.chat;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;
import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

@ServerEndpoint(value = "/chat/{chatRoomSeq}", configurator = ChatEndpointConfigurator.class)
public class ChatEndpoint {

    private static ConcurrentHashMap<String, Set<Session>> chatRooms = new ConcurrentHashMap<>();
    private ChatService chatService = new ChatService();
    
    @OnOpen
    public void onOpen(Session session, @PathParam("chatRoomSeq") String chatRoomSeq) {
        HttpSession httpSession = (HttpSession) session.getUserProperties().get("httpSession");
        String tblMemberSeq = (httpSession != null) ? (String) httpSession.getAttribute("auth") : null;
        
        chatRooms.putIfAbsent(chatRoomSeq, new CopyOnWriteArraySet<>());
        Set<Session> sessions = chatRooms.get(chatRoomSeq);
        // 1:1 채팅 방에서는 최대 두 명만 허용
        if(sessions.size() >= 2) {
            try {
                session.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
            System.out.println("채팅방 " + chatRoomSeq + "에 이미 두 명 접속 중입니다.");
            return;
        }
        
        chatRooms.get(chatRoomSeq).add(session);
        System.out.println("접속된 세션, 채팅방번호: " + chatRoomSeq + ", 회원 시퀀스: " + tblMemberSeq);
    }
    
    @OnMessage
    public void onMessage(String message, Session session, @PathParam("chatRoomSeq") String chatRoomSeq) {
        try {
            HttpSession httpSession = (HttpSession) session.getUserProperties().get("httpSession");
            String tblMemberSeq = (httpSession != null) ? (String) httpSession.getAttribute("auth") : null;
            
            JSONParser parser = new JSONParser();
            JSONObject json = (JSONObject) parser.parse(message);
            String sender = (String) json.get("sender");
            String content = (String) json.get("content");
            
            JSONObject response = new JSONObject();
            response.put("sender", sender);
            response.put("content", content);
            response.put("timestamp", System.currentTimeMillis());
            
            // 채팅 메시지를 데이터베이스에 저장
            chatService.insertChatHistory(chatRoomSeq, tblMemberSeq, content, "0");
            
            Set<Session> sessions = chatRooms.get(chatRoomSeq);
            for (Session s : sessions) {
                if(s.isOpen()){
                    s.getBasicRemote().sendText(response.toString());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @OnClose
    public void onClose(Session session, @PathParam("chatRoomSeq") String chatRoomSeq) {
        Set<Session> sessions = chatRooms.get(chatRoomSeq);
        if(sessions != null) {
            sessions.remove(session);
        }
        System.out.println("연결 종료, 채팅방번호: " + chatRoomSeq);
    }
    
    @OnError
    public void onError(Session session, Throwable throwable, @PathParam("chatRoomSeq") String chatRoomSeq) {
        System.out.println("오류 발생, 채팅방번호: " + chatRoomSeq);
        throwable.printStackTrace();
    }
}
