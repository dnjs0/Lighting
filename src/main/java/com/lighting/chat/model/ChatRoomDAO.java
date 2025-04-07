package com.lighting.chat.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ChatRoomDAO {
    
    private Connection conn;
    private Statement stat;
    private PreparedStatement pstat;
    private ResultSet rs;
    
    public ChatRoomDAO() {
            
        try {
            
            Context ctx = new InitialContext();
            Context env = (Context)ctx.lookup("java:comp/env");
            DataSource ds = (DataSource)env.lookup("jdbc/pool");
            
            conn = ds.getConnection();
            stat = conn.createStatement();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
            
    }
    
    public void close() {
        try {
            this.conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    

    public String getChatRoomSeq(String tblMemberSeq, String nickname) {
        String chatRoomSeq = null;
        System.out.println(tblMemberSeq);
        System.out.println(nickname);
        try {
            String sql = "SELECT tblChatRoomSeq FROM tblChatRoom  "
                    + "WHERE (chatCreatorSeq = ? AND chatPartnerSeq = (select tblmemberseq from tblmember where nickname=?)) "
                    + "OR (chatCreatorSeq = (select tblmemberseq from tblmember where nickname=?) AND chatPartnerSeq = ?)";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, tblMemberSeq);
            pstat.setString(2, nickname);
            pstat.setString(3, nickname);
            pstat.setString(4, tblMemberSeq);
            rs = pstat.executeQuery();
            if (rs.next()) {
                chatRoomSeq = rs.getString("tblChatRoomSeq");
            }
            System.out.println("getChatRoomSeq의채팅방seq : "+chatRoomSeq);
            return chatRoomSeq;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return chatRoomSeq;
    }
    
    /**
     * 두 회원 간의 채팅방이 없을 경우 새로 생성하고, 생성된 채팅방 시퀀스를 반환합니다.
     */
    public String createChatRoom(String tblMemberSeq, String nickname) {
        System.out.println("createChatRoom의 시작");
        System.out.println("보낸 사람 seq"+tblMemberSeq);
        System.out.println("받는 사람 닉네임 : "+nickname);
        String generatedChatRoomSeq = null;
        try {
            String sql = "INSERT INTO tblChatRoom (tblChatRoomSeq, chatCreatorSeq, chatPartnerSeq, createDate) "
                    + "VALUES (seqChatRoom.nextval, ?, (select tblmemberseq from tblmember where nickname=?), sysdate)";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, tblMemberSeq);
            pstat.setString(2, nickname);
            pstat.executeUpdate();
            generatedChatRoomSeq = getChatRoomSeq(tblMemberSeq, nickname);
            System.out.println("생성된 방 번호"+generatedChatRoomSeq);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return generatedChatRoomSeq;
    }
    
    public List<ChatDTO> getChatRooms(String tblMemberSeq) {
        List<ChatDTO> list = new ArrayList<>();
        try {
            // 자신이 채팅방의 생성자이거나 파트너로 참여한 모든 채팅방을 조회합니다.
            String sql = "SELECT t.tblChatRoomSeq, t.chatCreatorSeq, t.chatPartnerSeq, t.createDate, " +
                    "CASE WHEN t.chatCreatorSeq = ? THEN m2.nickname ELSE m.nickname END as nickname " +
                    "FROM tblChatRoom t " +
                    "LEFT JOIN tblMember m ON t.chatCreatorSeq = m.tblMemberSeq " +
                    "LEFT JOIN tblMember m2 ON t.chatPartnerSeq = m2.tblMemberSeq " +
                    "WHERE t.chatCreatorSeq = ? OR t.chatPartnerSeq = ?";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, tblMemberSeq);
            pstat.setString(2, tblMemberSeq);
            pstat.setString(3, tblMemberSeq);
            rs = pstat.executeQuery();
            while(rs.next()){
                ChatDTO dto = new ChatDTO();
                dto.setTblChatRoomSeq(rs.getString("tblChatRoomSeq"));
                dto.setChatCreatorSeq(rs.getString("chatCreatorSeq"));
                dto.setChatPartnerSeq(rs.getString("chatPartnerSeq"));
                dto.setCreateDate(rs.getString("createDate"));
                dto.setNickname(rs.getString("nickname"));
                list.add(dto);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
}
