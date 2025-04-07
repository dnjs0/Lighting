package com.lighting.chat.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString


public class ChatDTO {
    //tblChatRoom
    private String tblChatRoomSeq;
    private String chatCreatorSeq;
    private String chatPartnerSeq;
    private String createDate;
    private String tblMemberSeq;
    
    private String nickname;
    
    //tblChatHistroy
    private String tblChatHistorySeq;
    private String content;
    private String postDate;
    private String status;
    

}
