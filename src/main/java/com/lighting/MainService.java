package com.lighting;

import java.util.List;
import com.lighting.model.MainDAO;
import com.lighting.model.MainDTO;

public class MainService {

    // 메인 데이터 요청에 따른 게시글 목록 조회
    public List<MainDTO> getMeetingList(String categorySubSeq, String tblMemberSeq, String showAll) {
        MainDAO dao = new MainDAO();
        List<MainDTO> meetingList;
        
        if ("true".equals(showAll)) {
            meetingList = dao.getMeetingList();
        } else {
            if (tblMemberSeq != null && (categorySubSeq == null || categorySubSeq.trim().isEmpty())) {
                categorySubSeq = dao.getHighestInterestCategory(tblMemberSeq);
            }
            if (categorySubSeq != null && !categorySubSeq.trim().isEmpty() && tblMemberSeq != null) {
                dao.insertInterestScore(tblMemberSeq, categorySubSeq);
            }
            if (categorySubSeq != null && !categorySubSeq.trim().isEmpty()) {
                meetingList = dao.getMeetingListByCategory(categorySubSeq);
            } else {
                meetingList = dao.getMeetingList();
            }
        }
        dao.close();
        return meetingList;
    }
    
    // 검색 요청에 따른 게시글 목록 조회 및 검색 기록 저장
    public List<MainDTO> searchMeetingPosts(String searchKeyword, String tblCategorySubSeq, String tblMemberSeq) {
        MainDAO dao = new MainDAO();
        if (tblMemberSeq != null) {
            dao.insertSearchHistory(searchKeyword, tblMemberSeq, tblCategorySubSeq);
            dao.insertInterestScore(tblMemberSeq, tblCategorySubSeq);
        }
        List<MainDTO> meetingList = dao.searchMeetingPosts(searchKeyword, tblCategorySubSeq);
        dao.close();
        return meetingList;
    }
    
    // 메인 화면 요청 시 게시글 목록 조회 (회원인 경우 최고 관심 카테고리 기준)
    public List<MainDTO> getMeetingListForMain(String tblMemberSeq) {
        MainDAO dao = new MainDAO();
        String categorySubSeq = null;
        if (tblMemberSeq != null) {
            categorySubSeq = dao.getHighestInterestCategory(tblMemberSeq);
        }
        List<MainDTO> meetingList;
        if (categorySubSeq != null && !categorySubSeq.trim().isEmpty()) {
            meetingList = dao.getMeetingListByCategory(categorySubSeq);
        } else {
            meetingList = dao.getMeetingList();
        }
        dao.close();
        return meetingList;
    }
}
