drop table tblRejectionReason cascade constraints;
drop table tblEvaluation cascade constraints;

drop table tblWishlist cascade constraints;
drop table tblLocationCoordinate cascade constraints;
drop table tblMeeting cascade constraints;
drop table tblParticipationRequest cascade constraints;

drop table tblChatHistory cascade constraints;
drop table tblInterest cascade constraints;
drop table tblMeetingPost cascade constraints;
drop table tblSearchHistory cascade constraints;

drop table tblActivityRegion cascade constraints;
drop table tblBlockList cascade constraints;
drop table tblFriendList cascade constraints;
drop table tblFriendRequest cascade constraints;
drop table tblLoginStatus cascade constraints;
drop table tblPasswordError cascade constraints;
drop table tblCategorySub cascade constraints;
drop table tblChatRoom cascade constraints;
drop table tblPhotoPost cascade constraints;

drop table tblMember cascade constraints;
drop table tblCategoryMain cascade constraints;
drop table tblActivityRegionCoordinate cascade constraints;

drop table tblEmail cascade constraints;

/* 회원 */
CREATE TABLE tblMember (
	tblMemberSeq NUMBER NOT NULL, /* 회원seq */
	id VARCHAR2(20) NOT NULL UNIQUE, /* 아이디 */
	pw VARCHAR2(20) NOT NULL, /* 비밀번호 */
	name VARCHAR2(30) NOT NULL, /* 이름 */
	nickname VARCHAR2(30) NOT NULL, /* 닉네임 */
	birthday DATE NOT NULL, /* 생년월일 */
	tel VARCHAR2(20) NOT NULL UNIQUE, /* 연락처 */
	email VARCHAR2(100) NOT NULL UNIQUE, /* 이메일 */
	gender VARCHAR2(1) NOT NULL, /* 성별 */
	photoFileName VARCHAR2(1020) NOT NULL, /* 사진파일명 */
	registrationDate DATE DEFAULT sysdate NOT NULL, /* 가입일 */
	status NUMBER DEFAULT 0 NOT NULL /* 회원상태 */
);

DROP SEQUENCE seqMember;
CREATE SEQUENCE seqMember start with 1001;

ALTER TABLE tblMember
	ADD
		CONSTRAINT PK_tblMember
		PRIMARY KEY (
			tblMemberSeq
		);
		
/* 활동지역좌표 */
CREATE TABLE tblActivityRegionCoordinate (
	tblActivityRegionCoordinateSeq NUMBER NOT NULL, /* 활동지역좌표seq */
	sido VARCHAR2(255) NOT NULL, /* 시,도(지역명) */
	gugun VARCHAR2(255) NOT NULL, /* 구,군(지역명) */
	latitude NUMBER NOT NULL, /* 위도 */
	longitude NUMBER NOT NULL /* 경도 */
);

DROP SEQUENCE seqActivityRegionCoordinate;
CREATE SEQUENCE seqActivityRegionCoordinate start with 26;

ALTER TABLE tblActivityRegionCoordinate
	ADD
		CONSTRAINT PK_tblActivityRegionCoordinate
		PRIMARY KEY (
			tblActivityRegionCoordinateSeq
		);
		
/* 대분류 */
CREATE TABLE tblCategoryMain (
	tblCategoryMainSeq NUMBER NOT NULL, /* 대분류seq */
	categoryName VARCHAR2(255) NOT NULL /* 분류명 */
);

ALTER TABLE tblCategoryMain
	ADD
		CONSTRAINT PK_tblCategoryMain
		PRIMARY KEY (
			tblCategoryMainSeq
		);
		

/* 활동지역 */
CREATE TABLE tblActivityRegion (
	tblMemberSeq NUMBER NOT NULL, /* 회원seq */
	tblActivityRegionCoordinateSeq NUMBER NOT NULL /* 활동지역좌표seq */
);

ALTER TABLE tblActivityRegion
	ADD
		CONSTRAINT PK_tblActivityRegion
		PRIMARY KEY (
			tblMemberSeq
		);

ALTER TABLE tblActivityRegion
	ADD
		CONSTRAINT FK_tblMember_TO_tblActivityRegion
		FOREIGN KEY (
			tblMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblActivityRegion
	ADD
		CONSTRAINT FK_tblActivityRegionCoordinate_TO_tblActivityRegion
		FOREIGN KEY (
			tblActivityRegionCoordinateSeq
		)
		REFERENCES tblActivityRegionCoordinate (
			tblActivityRegionCoordinateSeq
		);
		
/* 차단목록 */
CREATE TABLE tblBlockList (
	blockerMemberSeq NUMBER NOT NULL, /* 회원seq */
	blockedMemberSeq NUMBER NOT NULL, /* 회원seq2 */
	blockDate DATE DEFAULT sysdate NOT NULL /* 차단일 */
);

ALTER TABLE tblBlockList
	ADD
		CONSTRAINT PK_tblBlockList
		PRIMARY KEY (
			blockerMemberSeq,
			blockedMemberSeq
		);

ALTER TABLE tblBlockList
	ADD
		CONSTRAINT FK_tblMember_TO_tblBlockList
		FOREIGN KEY (
			blockerMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblBlockList
	ADD
		CONSTRAINT FK_tblMember_TO_tblBlockList2
		FOREIGN KEY (
			blockedMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);
		
/* 친구목록 */
CREATE TABLE tblFriendList (
	mainMemberSeq NUMBER NOT NULL, /* 회원seq */
	subMemberSeq NUMBER NOT NULL, /* 회원seq2 */
	addDate DATE DEFAULT sysdate NOT NULL /* 친구등록일 */
);

ALTER TABLE tblFriendList
	ADD
		CONSTRAINT PK_tblFriendList
		PRIMARY KEY (
			mainMemberSeq,
			subMemberSeq
		);

ALTER TABLE tblFriendList
	ADD
		CONSTRAINT FK_tblMember_TO_tblFriendList
		FOREIGN KEY (
			mainMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblFriendList
	ADD
		CONSTRAINT FK_tblMember_TO_tblFriendList2
		FOREIGN KEY (
			subMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);
		
/* 친구신청 */
CREATE TABLE tblFriendRequest (
	tblFriendRequestseq NUMBER NOT NULL, /* 친구신청seq */
	requestingMemberSeq NUMBER NOT NULL, /* 회원seq */
	requestedMemberSeq NUMBER NOT NULL, /* 회원seq2 */
	approvalStatus VARCHAR2(1) /* 승인여부 */
);

DROP SEQUENCE seqFriendRequest;
CREATE SEQUENCE seqFriendRequest;

ALTER TABLE tblFriendRequest
	ADD
		CONSTRAINT PK_tblFriendRequest
		PRIMARY KEY (
			tblFriendRequestseq
		);

ALTER TABLE tblFriendRequest
	ADD
		CONSTRAINT FK_tblMember_TO_tblFriendRequest
		FOREIGN KEY (
			requestingMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblFriendRequest
	ADD
		CONSTRAINT FK_tblMember_TO_tblFriendRequest2
		FOREIGN KEY (
			requestedMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);
		
/* 로그인상태 */
CREATE TABLE tblLoginStatus (
	tblMemberSeq NUMBER NOT NULL, /* 회원seq */
	status VARCHAR2(1) NOT NULL /* 상태 */
);

ALTER TABLE tblLoginStatus
	ADD
		CONSTRAINT PK_tblLoginStatus
		PRIMARY KEY (
			tblMemberSeq
		);

ALTER TABLE tblLoginStatus
	ADD
		CONSTRAINT FK_tblMember_TO_tblLoginStatus
		FOREIGN KEY (
			tblMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);
		
/* 비밀번호오류 */
CREATE TABLE tblPasswordError (
	tblMemberSeq NUMBER NOT NULL, /* 회원seq */
	count NUMBER DEFAULT 0 NOT NULL /* 횟수 */
);

ALTER TABLE tblPasswordError
	ADD
		CONSTRAINT PK_tblPasswordError
		PRIMARY KEY (
			tblMemberSeq
		);

ALTER TABLE tblPasswordError
	ADD
		CONSTRAINT FK_tblMember_TO_tblPasswordError
		FOREIGN KEY (
			tblMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);		

/* 중분류 */
CREATE TABLE tblCategorySub (
	tblCategorySubSeq NUMBER NOT NULL, /* 중분류seq */
	tblCategoryMainSeq NUMBER NOT NULL, /* 대분류seq */
	categoryName VARCHAR2(255) NOT NULL /* 분류명 */
);

DROP SEQUENCE seqCategorySub;
CREATE SEQUENCE seqCategorySub start with 51;

ALTER TABLE tblCategorySub
	ADD
		CONSTRAINT PK_tblCategorySub
		PRIMARY KEY (
			tblCategorySubSeq
		);

ALTER TABLE tblCategorySub
	ADD
		CONSTRAINT FK_tblCategoryMain_TO_tblCategorySub
		FOREIGN KEY (
			tblCategoryMainSeq
		)
		REFERENCES tblCategoryMain (
			tblCategoryMainSeq
		);
		
/* 채팅방 */
CREATE TABLE tblChatRoom (
	tblChatRoomSeq NUMBER NOT NULL, /* 채팅방seq */
	chatCreatorSeq NUMBER NOT NULL, /* 회원seq */
	chatPartnerSeq NUMBER NOT NULL, /* 회원seq2 */
	createDate DATE DEFAULT sysdate NOT NULL /* 개설일 */
);

DROP SEQUENCE seqChatRoom;
CREATE SEQUENCE seqChatRoom;

ALTER TABLE tblChatRoom
	ADD
		CONSTRAINT PK_tblChatRoom
		PRIMARY KEY (
			tblChatRoomSeq
		);

ALTER TABLE tblChatRoom
	ADD
		CONSTRAINT FK_tblMember_TO_tblChatRoom
		FOREIGN KEY (
			chatCreatorSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblChatRoom
	ADD
		CONSTRAINT FK_tblMember_TO_tblChatRoom2
		FOREIGN KEY (
			chatPartnerSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);
		
/* 사진게시글 */
CREATE TABLE tblPhotoPost (
	tblPhotoPostSeq NUMBER NOT NULL, /* 사진게시글seq */
	photoFileName VARCHAR2(1020) NOT NULL, /* 내용 */
	postDate DATE DEFAULT sysdate NOT NULL, /* 게시일 */
	tblMemberSeq NUMBER NOT NULL /* 회원seq */
);

DROP SEQUENCE seqPhotoPost;
CREATE SEQUENCE seqPhotoPost start with 501;

ALTER TABLE tblPhotoPost
	ADD
		CONSTRAINT PK_tblPhotoPost
		PRIMARY KEY (
			tblPhotoPostSeq
		);

ALTER TABLE tblPhotoPost
	ADD
		CONSTRAINT FK_tblMember_TO_tblPhotoPost
		FOREIGN KEY (
			tblMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);
		
/* 채팅내역 */
CREATE TABLE tblChatHistory (
	tblChatHistorySeq NUMBER NOT NULL, /* 채팅내역seq */
	tblChatRoomSeq NUMBER NOT NULL, /* 채팅방seq */
	tblMemberSeq NUMBER NOT NULL, /* 회원seq */
	content VARCHAR2(4000) NOT NULL, /* 내용 */
	postDate DATE DEFAULT sysdate NOT NULL, /* 작성시간 */
	status VARCHAR2(1) DEFAULT 0 NOT NULL /* 읽음여부 */
);

DROP SEQUENCE seqChatHistory;
CREATE SEQUENCE seqChatHistory;

ALTER TABLE tblChatHistory
	ADD
		CONSTRAINT PK_tblChatHistory
		PRIMARY KEY (
			tblChatHistorySeq
		);

ALTER TABLE tblChatHistory
	ADD
		CONSTRAINT FK_tblMember_TO_tblChatHistory
		FOREIGN KEY (
			tblMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblChatHistory
	ADD
		CONSTRAINT FK_tblChatRoom_TO_tblChatHistory
		FOREIGN KEY (
			tblChatRoomSeq
		)
		REFERENCES tblChatRoom (
			tblChatRoomSeq
		);
		
/* 관심도 */
CREATE TABLE tblInterest (
	tblInterestSeq NUMBER NOT NULL, /* 관심도seq */
	tblMemberSeq NUMBER NOT NULL, /* 회원seq */
	tblCategorySubSeq NUMBER NOT NULL, /* 중분류seq */
	score NUMBER NOT NULL /* 점수 */
);

DROP SEQUENCE seqInterest;
CREATE SEQUENCE seqInterest;

ALTER TABLE tblInterest
	ADD
		CONSTRAINT PK_tblInterest
		PRIMARY KEY (
			tblInterestSeq
		);

ALTER TABLE tblInterest
	ADD
		CONSTRAINT FK_tblMember_TO_tblInterest
		FOREIGN KEY (
			tblMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblInterest
	ADD
		CONSTRAINT FK_tblCategorySub_TO_tblInterest
		FOREIGN KEY (
			tblCategorySubSeq
		)
		REFERENCES tblCategorySub (
			tblCategorySubSeq
		);		



/* 모임게시글 */
CREATE TABLE tblMeetingPost (
	tblMeetingPostSeq NUMBER NOT NULL, /* 모임게시글seq */
	title VARCHAR2(300) NOT NULL, /* 제목 */
	content VARCHAR2(4000) NOT NULL, /* 내용 */
	postDate DATE DEFAULT sysdate NOT NULL, /* 게시일 */
	location VARCHAR2(255) NOT NULL, /* 장소명 */
	capacity NUMBER NOT NULL, /* 정원 */
	startTime DATE NOT NULL, /* 모임시작시간 */
	endTime DATE NOT NULL, /* 모임끝시간 */
	photoFileName VARCHAR2(1020) NOT NULL, /* 사진파일명 */
	tblMemberSeq NUMBER NOT NULL, /* 회원seq */
	tblCategorySubSeq NUMBER NOT NULL /* 중분류seq */
);

DROP SEQUENCE seqMeetingPost;
CREATE SEQUENCE seqMeetingPost start with 501;

ALTER TABLE tblMeetingPost
	ADD
		CONSTRAINT PK_tblMeetingPost
		PRIMARY KEY (
			tblMeetingPostSeq
		);

ALTER TABLE tblMeetingPost
	ADD
		CONSTRAINT FK_tblMember_TO_tblMeetingPost
		FOREIGN KEY (
			tblMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblMeetingPost
	ADD
		CONSTRAINT FK_tblCategorySub_TO_tblMeetingPost
		FOREIGN KEY (
			tblCategorySubSeq
		)
		REFERENCES tblCategorySub (
			tblCategorySubSeq
		);
		
/* 검색기록 */
CREATE TABLE tblSearchHistory (
	tblSearchHistorySeq NUMBER NOT NULL, /* 검색기록seq */
	searchKeyword VARCHAR2(255) NOT NULL, /* 검색어 */
	tblMemberSeq NUMBER NOT NULL, /* 회원seq */
	tblCategorySubSeq NUMBER NOT NULL /* 중분류seq */
);

DROP SEQUENCE seqSearchHistory;
CREATE SEQUENCE seqSearchHistory;

ALTER TABLE tblSearchHistory
	ADD
		CONSTRAINT PK_tblSearchHistory
		PRIMARY KEY (
			tblSearchHistorySeq
		);

ALTER TABLE tblSearchHistory
	ADD
		CONSTRAINT FK_tblMember_TO_tblSearchHistory
		FOREIGN KEY (
			tblMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblSearchHistory
	ADD
		CONSTRAINT FK_tblCategorySub_TO_tblSearchHistory
		FOREIGN KEY (
			tblCategorySubSeq
		)
		REFERENCES tblCategorySub (
			tblCategorySubSeq
		);
		
/* 찜목록 */
CREATE TABLE tblWishlist (
	tblWishlistSeq NUMBER NOT NULL, /* 찜목록seq */
	tblMemberSeq NUMBER NOT NULL, /* 회원seq */
	tblMeetingPostSeq NUMBER NOT NULL /* 모임게시글seq */
);

DROP SEQUENCE seqWishlist;
CREATE SEQUENCE seqWishlist;

ALTER TABLE tblWishlist
	ADD
		CONSTRAINT PK_tblWishlist
		PRIMARY KEY (
			tblWishlistSeq
		);

ALTER TABLE tblWishlist
	ADD
		CONSTRAINT FK_tblMember_TO_tblWishlist
		FOREIGN KEY (
			tblMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblWishlist
	ADD
		CONSTRAINT FK_tblMeetingPost_TO_tblWishlist
		FOREIGN KEY (
			tblMeetingPostSeq
		)
		REFERENCES tblMeetingPost (
			tblMeetingPostSeq
		);		

/* 장소좌표 */
CREATE TABLE tblLocationCoordinate (
	tblMeetingPostSeq NUMBER NOT NULL, /* 모임게시글seq */
	latitude NUMBER NOT NULL, /* 장소(위도) */
	longitude NUMBER NOT NULL /* 장소(경도) */
);

DROP SEQUENCE seqLocationCoordinate;
CREATE SEQUENCE seqLocationCoordinate;

ALTER TABLE tblLocationCoordinate
	ADD
		CONSTRAINT PK_tblLocationCoordinate
		PRIMARY KEY (
			tblMeetingPostSeq
		);

ALTER TABLE tblLocationCoordinate
	ADD
		CONSTRAINT FK_tblMeetingPost_TO_tblLocationCoordinate
		FOREIGN KEY (
			tblMeetingPostSeq
		)
		REFERENCES tblMeetingPost (
			tblMeetingPostSeq
		);
		
/* 모임 */
CREATE TABLE tblMeeting (
	tblMeetingSeq NUMBER NOT NULL, /* 모임seq */
	tblMeetingPostSeq NUMBER NOT NULL /* 모임게시글seq */
);

DROP SEQUENCE seqMeeting;
CREATE SEQUENCE seqMeeting;

ALTER TABLE tblMeeting
	ADD
		CONSTRAINT PK_tblMeeting
		PRIMARY KEY (
			tblMeetingSeq
		);

ALTER TABLE tblMeeting
	ADD
		CONSTRAINT FK_tblMeetingPost_TO_tblMeeting
		FOREIGN KEY (
			tblMeetingPostSeq
		)
		REFERENCES tblMeetingPost (
			tblMeetingPostSeq
		);
		
/* 참여신청 */
CREATE TABLE tblParticipationRequest (
	tblParticipationRequestSeq NUMBER NOT NULL, /* 참여신청seq */
	tblMeetingPostSeq NUMBER NOT NULL, /* 모임게시글seq */
	tblMemberSeq NUMBER NOT NULL, /* 회원seq */
	approvalStatus VARCHAR2(1) /* 승인여부 */
);

DROP SEQUENCE seqParticipationRequest;
CREATE SEQUENCE seqParticipationRequest;

ALTER TABLE tblParticipationRequest
	ADD
		CONSTRAINT PK_tblParticipationRequest
		PRIMARY KEY (
			tblParticipationRequestSeq
		);

ALTER TABLE tblParticipationRequest
	ADD
		CONSTRAINT FK_tblMeetingPost_TO_tblParticipationRequest
		FOREIGN KEY (
			tblMeetingPostSeq
		)
		REFERENCES tblMeetingPost (
			tblMeetingPostSeq
		)
	ON DELETE CASCADE;

ALTER TABLE tblParticipationRequest
	ADD
		CONSTRAINT FK_tblMember_TO_tblParticipationRequest
		FOREIGN KEY (
			tblMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);
		
/* 거절사유 */
CREATE TABLE tblRejectionReason (
	tblRejectionReasonSeq NUMBER NOT NULL, /* 거절사유seq */
	tblParticipationRequestSeq NUMBER NOT NULL, /* 참여신청seq */
	reason VARCHAR2(500) NOT NULL /* 거절사유 */
);

DROP SEQUENCE seqRejectionReason;
CREATE SEQUENCE seqRejectionReason;

ALTER TABLE tblRejectionReason
	ADD
		CONSTRAINT PK_tblRejectionReason
		PRIMARY KEY (
			tblRejectionReasonSeq
		);

ALTER TABLE tblRejectionReason
	ADD
		CONSTRAINT FK_tblParticipationRequest_TO_tblRejectionReason
		FOREIGN KEY (
			tblParticipationRequestSeq
		)
		REFERENCES tblParticipationRequest (
			tblParticipationRequestSeq
		)
	ON DELETE CASCADE;	
		
/* 평가 */
CREATE TABLE tblEvaluation (
	tblMeetingSeq NUMBER NOT NULL, /* 모임seq */
	evaluatorMemberSeq NUMBER NOT NULL, /* 회원seq */
	evaluatedMemberSeq NUMBER NOT NULL, /* 회원seq2 */
	score NUMBER NOT NULL /* 점수 */
);

ALTER TABLE tblEvaluation
	ADD
		CONSTRAINT PK_tblEvaluation
		PRIMARY KEY (
			tblMeetingSeq,
			evaluatorMemberSeq,
			evaluatedMemberSeq
		);

ALTER TABLE tblEvaluation
	ADD
		CONSTRAINT FK_tblMember_TO_tblEvaluation
		FOREIGN KEY (
			evaluatorMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblEvaluation
	ADD
		CONSTRAINT FK_tblMember_TO_tblEvaluation2
		FOREIGN KEY (
			evaluatedMemberSeq
		)
		REFERENCES tblMember (
			tblMemberSeq
		);

ALTER TABLE tblEvaluation
	ADD
		CONSTRAINT FK_tblMeeting_TO_tblEvaluation
		FOREIGN KEY (
			tblMeetingSeq
		)
		REFERENCES tblMeeting (
			tblMeetingSeq
		);		
/* 이메일 */
CREATE TABLE tblEmail (
	email VARCHAR2(40) NOT NULL, /* 이메일 */
	validNumber VARCHAR2(255) NOT NULL, /* 인증번호 */
	regdate DATE NOT NULL /* 시간 */
);

ALTER TABLE tblEmail
	ADD
		CONSTRAINT PK_TABLE5
		PRIMARY KEY (
			email
		);

ALTER TABLE tblParticipationRequest
	DROP
		CONSTRAINT FK_tblMeetingPost_TO_tblParticipationRequest;
		
ALTER TABLE tblParticipationRequest
	ADD
		CONSTRAINT FK_tblMeetingPost_TO_tblParticipationRequest
		FOREIGN KEY (
			tblMeetingPostSeq
		)
		REFERENCES tblMeetingPost (
			tblMeetingPostSeq
		)
	ON DELETE CASCADE;
	

ALTER TABLE tblRejectionReason
	DROP
		CONSTRAINT FK_tblParticipationRequest_TO_tblRejectionReason;

ALTER TABLE tblRejectionReason
	ADD
		CONSTRAINT FK_tblParticipationRequest_TO_tblRejectionReason
		FOREIGN KEY (
			tblParticipationRequestSeq
		)
		REFERENCES tblParticipationRequest (
			tblParticipationRequestSeq
		)
	ON DELETE CASCADE;

ALTER TABLE tblWishlist
	DROP
		CONSTRAINT FK_tblMeetingPost_TO_tblWishlist;

ALTER TABLE tblWishlist
	ADD
		CONSTRAINT FK_tblMeetingPost_TO_tblWishlist
		FOREIGN KEY (
			tblMeetingPostSeq
		)
		REFERENCES tblMeetingPost (
			tblMeetingPostSeq
		)
	ON DELETE CASCADE;

CREATE OR REPLACE PROCEDURE UpdateAndInsertRejectionReason(
    p_tblMeetingPostSeq IN NUMBER,
    p_reason IN VARCHAR2
)
IS
BEGIN
    -- approvalStatus가 NULL인 레코드를 N으로 UPDATE
    UPDATE tblParticipationRequest
    SET approvalStatus = 'N'
    WHERE tblMeetingPostSeq = p_tblMeetingPostSeq
      AND approvalStatus IS NULL;
    
    -- 업데이트된 레코드 중 이미 tblRejectionReason에 없는 항목만 INSERT
    INSERT INTO tblRejectionReason (tblRejectionReasonSeq, tblParticipationRequestSeq, reason)
    SELECT seqRejectionReason.NEXTVAL, p.tblParticipationRequestSeq, p_reason
    FROM tblParticipationRequest p
    WHERE p.tblMeetingPostSeq = p_tblMeetingPostSeq
      AND p.approvalStatus = 'N'
      AND NOT EXISTS (
          SELECT 1
          FROM tblRejectionReason r
          WHERE r.tblParticipationRequestSeq = p.tblParticipationRequestSeq
      );
END;
/