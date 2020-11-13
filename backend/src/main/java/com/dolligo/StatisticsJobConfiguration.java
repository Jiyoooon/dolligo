package com.dolligo;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j // 로그 사용을 위한 lombok 어노테이션
@RequiredArgsConstructor // 생성자 DI를 위한 lombok 어노테이션
@Configuration
public class StatisticsJobConfiguration {
	@Autowired
	private JobBuilderFactory jobBuilderFactory; //생성자 di 받음
	@Autowired
	private StepBuilderFactory stepBuilderFactory;
	
	@Bean
	public Job statisticsJob() {
		return jobBuilderFactory.get("statisticsJob")
				.start(step1())
				.build();
	}

	@Bean
	public Step step1() {
		return stepBuilderFactory.get("statisticsStep1")
				.tasklet((contribution, chunkContext) -> {
//					log.info(">>>>> This is Step1");
					//광고주별 advertiseranalysis 통계 데이터 계산해서 저장..!
					// 성별 원형 퍼센테이지
					// 연령별 원형 퍼센테이지
					// 시간대별 사용자 액션 카운트
					System.out.println(">>>>>> This is Step1");
					return RepeatStatus.FINISHED;
				})
				.build();
	}
	
	
}
