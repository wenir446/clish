package com.itwillbs.clish.admin.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.clish.admin.mapper.AdminClassMapper;
import com.itwillbs.clish.common.file.FileDTO;
import com.itwillbs.clish.common.file.FileMapper;
import com.itwillbs.clish.common.file.FileUtils;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.course.dto.CurriculumDTO;
import com.itwillbs.clish.course.mapper.CurriculumMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class AdminClassService {
	private final AdminClassMapper adminClassMapper;
	private final CurriculumMapper curriculumMapper;
	private final NotificationService notificationService;
	private final CategoryService categoryService;
	private final FileMapper fileMapper;
	
	@Autowired
	private HttpSession session;
	
	// 강좌 리스트
	public List<Map<String, Object>> getClassList() {
		return adminClassMapper.selectClassList();
	}
	
	@Transactional
	public int modifyStatus(String userIdx, String idx, int status) {
		int update = adminClassMapper.updateClassStatus(idx, status);
		
		if (update > 0) {
		  notificationService.send(userIdx, 3, "등록 요청하신 강좌가 승인되었습니다.");
		  return update;
		} 
		
		return 0;
	}
	
	// 강좌 정보 수정
	@Transactional
	public int modifyClassInfo(String idx, ClassDTO classInfo, List<CurriculumDTO> curriculumList) throws IllegalStateException, IOException {
		int update = adminClassMapper.updateClassInfo(idx, classInfo);
		int updateCurriculume = 0;
		
		classInfo.setClassIdx(idx);
		
		if (classInfo.getFiles() != null && classInfo.getFiles().length > 0) {
			List<FileDTO> classFileList = FileUtils.uploadFile(classInfo, session);

		    if (!classFileList.isEmpty()) {
		        fileMapper.insertFiles(classFileList);
		    }
		}
		
		curriculumMapper.deleteCurriculumByClassIdx(idx);
		
		 for (CurriculumDTO dto : curriculumList) {
		        if (dto.getCurriculumTitle() != null && !dto.getCurriculumTitle().trim().isEmpty()) {
		            dto.setClassIdx(idx);
		            curriculumMapper.insertCurriculumModify(dto);
		            updateCurriculume = 1;
		        }
		    }
		
		if (update > 0 || updateCurriculume > 0) {
			notificationService.send(classInfo.getUserIdx(), 3, "강좌 정보가 수정되었습니다.");
			return update;
		}
		return 0;
	}
	
	// 카테고리 삭제
	public int removeCategory(String categoryIdx, int depth) {
		boolean isReferenced = adminClassMapper.existsByCategory(categoryIdx, depth);
		
		if (isReferenced) {
			return 0;
		} else {
			categoryService.removeCategory(categoryIdx);
			return 1;
		}
	}

}
