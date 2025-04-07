package com.lighting.chat.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.jdbc.pool.DataSource;

public class ChatDAO {
    
    private Connection conn;
    private Statement stat;
    private PreparedStatement pstat;
    private ResultSet rs;
    
    public ChatDAO() {
        
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
    
    
    /**
     * 1대1 채팅의 메시지를 tblChatHistory 테이블에 삽입합니다.
     * @param chatRoomSeq 채팅방 시퀀스 (tblChatRoomSeq)
     * @param tblMemberSeq 메시지 전송 회원의 시퀀스
     * @param content 메시지 내용
     * @param status 읽음 여부 ('0' : 읽지 않음, '1' : 읽음 등)
     */
    public void insertChatHistory(String chatRoomSeq, String tblMemberSeq, String content, String status) {
        try {
            String sql = "INSERT INTO tblChatHistory (tblChatHistorySeq, tblChatRoomSeq, tblMemberSeq, content, postDate, status) "
                       + "VALUES (seqChatHistory.nextval, ?, ?, ?, sysdate, ?)";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, chatRoomSeq);
            pstat.setString(2, tblMemberSeq);
            pstat.setString(3, content);
            pstat.setString(4, status);
            pstat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    
    /**
     * 특정 채팅방의 채팅 내역을 조회
     */
    public List<ChatDTO> getChatHistory(String chatRoomSeq) {
        List<ChatDTO> list = new ArrayList<>();
        try {
            String sql = "SELECT tblChatHistorySeq, tblChatRoomSeq, tblMemberSeq, content, postDate, status "
                       + "FROM tblChatHistory WHERE tblChatRoomSeq = ? ORDER BY postDate ASC";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, chatRoomSeq);
            System.out.println("getChatHistory의 채팅방 번호!!"+chatRoomSeq);
            rs = pstat.executeQuery();
            while(rs.next()){
                ChatDTO chatDTO = new ChatDTO();
                // 값이 int나 Timestamp인 경우, String으로 변환하거나 ChatDTO의 타입을 변경하세요.
                chatDTO.setTblChatHistorySeq(rs.getString("tblChatHistorySeq"));
                chatDTO.setTblChatRoomSeq(rs.getString("tblChatRoomSeq"));
                // 채팅 생성자 정보가 별도로 필요하면 적절히 설정
                chatDTO.setChatCreatorSeq(rs.getString("tblMemberSeq"));
                chatDTO.setTblMemberSeq(rs.getString("tblMemberSeq"));
                chatDTO.setContent(rs.getString("content"));
                chatDTO.setPostDate(rs.getTimestamp("postDate").toString());
                chatDTO.setStatus(rs.getString("status"));
                list.add(chatDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



    public String getNicknameBySeq(String memberSeq) {
        String myNickname = null;
        try {
            
            String sql ="select nickname from tblmember where tblmemberseq=?";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, memberSeq);
            rs = pstat.executeQuery();
            if (rs.next()) {
                myNickname = rs.getString("nickname");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return myNickname;
    }
    
    
    
    
}
