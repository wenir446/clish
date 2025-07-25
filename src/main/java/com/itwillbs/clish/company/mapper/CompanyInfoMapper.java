package com.itwillbs.clish.company.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.clish.admin.dto.InquiryJoinUserDTO;
import com.itwillbs.clish.myPage.dto.InqueryDTO;
import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;


@Mapper
public interface CompanyInfoMapper {
	

	// 로그인한 기업회원 정보 조회
	UserDTO selectUserInfo(UserDTO user);
	
	// 기업 정보 수정
	int updateUserInfo(UserDTO user);
	
	// 기업회원 사업자등록증 정보 수정 처리
	int updateCompanyInfo(CompanyDTO company);

	// 기업 - 나의 문의 목록(리스트) 조회
	List<InquiryJoinUserDTO> selectInquiriesByUserIdx(String userIdx);
	
	// 문의 등록버튼 로직
	void insertInquery(InqueryDTO dto);
	
	// user_id로 실제 user_idx 조회
	String selectUserIdxByUserId(String userId);

	

}
