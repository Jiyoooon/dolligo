package com.dolligo.service;

import java.util.List;

import com.dolligo.dto.AdvertiserAnalysis;
import com.dolligo.dto.CircleAge;
import com.dolligo.dto.CircleGender;
import com.dolligo.dto.Paper;
import com.dolligo.dto.Paperanalysis;
import com.dolligo.dto.TimeGraph;

public interface IAdvertiserPaperService {
	Paperanalysis getRecentAnalysis(int pid);

	List<AdvertiserAnalysis> getAllAdvertiserAnalysis(int aid);
	
	TimeGraph getTimeTable(int aid);
	
	CircleAge getCircleAge(int aid);
	CircleGender getCircleGender(int aid);
	
	List<Paperanalysis> getAllAnalysis(String aid);

	Paper getPaperDetail(String aid, int pid);

	List<Paper> getAllPaper(String aid);

	void insertPaper(Paper paper);
}
