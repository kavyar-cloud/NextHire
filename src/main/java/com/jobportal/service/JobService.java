package com.jobportal.service;


import com.jobportal.dao.JobDao;
import com.jobportal.entity.Job;


public class JobService {


    private final JobDao jobDao = new JobDao();


    public void postJob(String title, String company, String location, String desc, Integer experience, String skills, String salaryRange) {
        Job job = new Job(title, company, location, desc, experience, skills, salaryRange);
        jobDao.saveJob(job);
    }
}