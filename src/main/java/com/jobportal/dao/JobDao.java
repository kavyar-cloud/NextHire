package com.jobportal.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jobportal.config.HibernateUtil;
import com.jobportal.entity.Job;

public class JobDao {

    // Save a new job
    public void saveJob(Job job) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            
            session.persist(job);  
            tx.commit();       
            
            System.out.println("✅ Job saved successfully: " + job.getTitle());
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            System.out.println("❌ Failed to save job: " + job.getTitle());
        }
    }
    



    // Get all jobs
    public List<Job> getAllJobs() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Job", Job.class).list();
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch jobs", e);
        }
    }

    // Optional: Get jobs by recruiter
    public List<Job> getJobsByRecruiter(int recruiterId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Job WHERE postedBy = :recruiterId", Job.class)
                    .setParameter("recruiterId", recruiterId)
                    .list();
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch jobs by recruiter", e);
        }
    }

    public boolean emailExists(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = session.createQuery(
                            "SELECT COUNT(u) FROM User u WHERE u.email = :email", Long.class)
                    .setParameter("email", email)
                    .uniqueResult();
            return count != null && count > 0;
        }
    }

    public int getApplicationCount(int jobId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
    
            Long count = session.createQuery(
                "SELECT COUNT(a.id) FROM Application a WHERE a.jobId = :jobId",
                Long.class
            )
            .setParameter("jobId", jobId)
            .uniqueResult();
    
            return count != null ? count.intValue() : 0;
        }
    }

    public Job getJobById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.find(Job.class, id);
        }
    }
    

}
