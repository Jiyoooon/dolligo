package com.dolligo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.dolligo.dto.Paper;
import com.dolligo.dto.RandomGps;
import com.dolligo.dto.TimeGraph;

@Repository
public interface IRandomGpsRepository extends JpaRepository<RandomGps, Integer>{
		
	@Query(value = "select * from random_gps where (6371 * acos(cos(radians(37.4976716)) * cos(radians(37 + lat)) * " + 
			"cos(radians(127 + lon) - radians(127.0267342)) + sin(radians(37.4976716)) * sin(radians(37 + lat)))) <= 0.1", nativeQuery = true)
	List<RandomGps> findAllByGps();
}
