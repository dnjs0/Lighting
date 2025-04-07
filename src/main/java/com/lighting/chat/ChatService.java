package com.lighting.chat;

import java.util.List;

import com.lighting.chat.model.ChatDAO;
import com.lighting.chat.model.ChatDTO;
import com.lighting.chat.model.ChatRoomDAO;

public class ChatService {
    
    // 두 회원 간의 채팅방 시퀀스를 조회
    public String getChatRoomSeq(String tblMemberSeq, String nickname) {
        ChatRoomDAO dao = new ChatRoomDAO();
        String chatRoomSeq = dao.getChatRoomSeq(tblMemberSeq, nickname);
        dao.close();
        return chatRoomSeq;
    }
    
    // 채팅방이 없을 경우 새로 생성
    public String createChatRoom(String tblMemberSeq, String nickname) {
        ChatRoomDAO dao = new ChatRoomDAO();
        String chatRoomSeq = dao.createChatRoom(tblMemberSeq, nickname);
        dao.close();
        return chatRoomSeq;
    }
    
    // 사용자가 참여 중인 모든 채팅방 조회
    public List<ChatDTO> getChatRooms(String tblMemberSeq) {
        ChatRoomDAO dao = new ChatRoomDAO();
        List<ChatDTO> chatRooms = dao.getChatRooms(tblMemberSeq);
        dao.close();
        return chatRooms;
    }
    
    // 채팅 메시지(채팅 내역) 삽입
    public void insertChatHistory(String chatRoomSeq, String tblMemberSeq, String content, String status) {
        ChatDAO dao = new ChatDAO();
        dao.insertChatHistory(chatRoomSeq, tblMemberSeq, content, status);
        dao.close();
    }
    
    // 특정 채팅방의 채팅 내역 조회
    public List<ChatDTO> getChatHistory(String chatRoomSeq) {
        ChatDAO dao = new ChatDAO();
        List<ChatDTO> history = dao.getChatHistory(chatRoomSeq);
        dao.close();
        return history;
    }
}
