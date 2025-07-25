package com.itwillbs.clish.home.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwillbs.clish.course.dto.ClassDTO;

import com.itwillbs.clish.home.mapper.MainMapper;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class MainService {
	private final MainMapper mainMapper;
	
	public MainService(MainMapper mainMapper) {
		this.mainMapper = mainMapper;
	}
	
	public List<ClassDTO> getClassList() {
			
		return mainMapper.selectClassInfo();
	}
	public List<ClassDTO> getClassList2() {
		
		return mainMapper.selectClassInfo2();
	}
	public List<ClassDTO> getClassListLongLatest() {
		
		return mainMapper.selectClassLongLatest();
	}
	public List<ClassDTO> getClassListShortLatest() {
		
		return mainMapper.selectClassInfoShortLatest();
	}
	
		
}
