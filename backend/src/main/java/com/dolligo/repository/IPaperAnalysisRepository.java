package com.dolligo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.dolligo.dto.Paperanalysis;
import com.dolligo.dto.Paperstate;

@Repository
public interface IPaperAnalysisRepository extends JpaRepository<Paperanalysis, Integer>{

//	@Query(value = "update paperanalysis set ignore = ignore+1 where pid = ?1", nativeQuery = true)
//	void updateIgnore(int pid);

	
	@Query(value = "select sum(distributed) as distributed, sum(visit) as visit, sum(interest) as interest, sum(block) as block "
			+ " from paperanalysis where pid in (select p_id from paper where p_aid = ?1 "
			+ " and now() between starttime and endtime)", nativeQuery = true)
	Paperanalysis getRecentPaperAnalysis(int aid);

	@Query(value = "select * from paperanalysis where pid = ?1", nativeQuery = true)
	Paperanalysis findByPid(int pid);

	@Query(value = "select * from paperanalysis where pid in "
			+ "( select p_id from paper where p_aid = ?1 ) order by id DESC ", nativeQuery = true)
	List<Paperanalysis> findAllByAid(String aid);
	
    

}
