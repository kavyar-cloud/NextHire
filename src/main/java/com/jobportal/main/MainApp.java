package com.jobportal.main;

import com.jobportal.dao.JobDao;
import com.jobportal.entity.Job;

public class MainApp {
    public static void main(String[] args) {
        Job job = new Job();
        job.setTitle("Software Developer");
        job.setDescription("Develop cool apps!");

        JobDao jobDao = new JobDao();
        jobDao.saveJob(job);

        System.out.println("Job saved successfully!");
    }
}
