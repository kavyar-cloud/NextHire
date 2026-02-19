package com.jobportal.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jobportal.config.HibernateUtil;
import com.jobportal.dto.ApplicationView;
import com.jobportal.entity.Application;

public class ApplicationDao {

    // ===== SAVE APPLICATION =====
    public void saveApplication(Application app) {
        Transaction tx = null;
        Session session = null;
    
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
    
            session.persist(app);
    
            tx.commit();
    
            System.out.println("✅ Application saved successfully");
    
        } catch (Exception e) {
    
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (Exception rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
    
            e.printStackTrace();
            throw new RuntimeException("Error saving application", e);
    
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }
    

    // ===== USER SIDE =====
    public List<ApplicationView> getApplicationsByUser(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                """
                SELECT new com.jobportal.dto.ApplicationView(
                    a.id,
                    j.title,
                    j.company,
                    a.status,
                    a.resumePath,
                    a.appliedAt,
                    a.resumeViewed
                )
                FROM Application a
                JOIN Job j ON a.jobId = j.id
                WHERE a.userId = :uid
                ORDER BY a.appliedAt DESC
                """,
                ApplicationView.class
            )
            .setParameter("uid", userId)
            .list();
        }
    }

    // ===== RECRUITER SIDE =====
    public List<ApplicationView> getApplicationsByRecruiter(int recruiterId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                """
                SELECT new com.jobportal.dto.ApplicationView(
                    a.id,
                    j.title,
                    j.company,
                    u.name,
                    u.email,
                    a.status,
                    a.resumePath,
                    a.appliedAt
                )
                FROM Application a
                JOIN Job j ON a.jobId = j.id
                JOIN User u ON a.userId = u.id
                WHERE j.postedBy = :rid
                ORDER BY a.appliedAt DESC
                """,
                ApplicationView.class
            )
            .setParameter("rid", recruiterId)
            .list();
        }
    }

    // ===== UPDATE STATUS =====
    public void updateStatus(int applicationId, String status) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Application app = session.find(Application.class, applicationId);
            if (app != null) {
                app.setStatus(status.toUpperCase()); // normalize casing
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    // ===== WITHDRAW =====
    public void withdrawApplication(int applicationId) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Application app = session.find(Application.class, applicationId);
            if (app != null && "PENDING".equalsIgnoreCase(app.getStatus())) {
                app.setStatus("WITHDRAWN");
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    // ===== RESUME VIEW TRACK =====
    public String markResumeViewed(int applicationId) {

        Transaction tx = null;
        Session session = null;
        String resumePath = null;
    
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
    
            Application app = session.find(Application.class, applicationId);
    
            if (app == null) {
                throw new RuntimeException("Application not found");
            }
    
            app.setResumeViewed(true);
            resumePath = app.getResumePath();
    
            tx.commit();
    
        } catch (Exception e) {
    
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (Exception ignored) {}
            }
    
            e.printStackTrace();
            throw new RuntimeException("Error marking resume viewed", e);
    
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    
        return resumePath;
    }
    

    // ===== DUPLICATE CHECK =====
    public boolean hasUserApplied(int jobId, int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = session.createQuery(
                "SELECT COUNT(a.id) FROM Application a WHERE a.jobId = :jobId AND a.userId = :userId",
                Long.class
            )
            .setParameter("jobId", jobId)
            .setParameter("userId", userId)
            .uniqueResult();

            return count != null && count > 0;
        }
    }

    // ===== RECRUITER SIDE - BY JOB =====
public List<ApplicationView> getApplicationsByJobAndRecruiter(int jobId, int recruiterId) {
    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
        return session.createQuery(
            """
            SELECT new com.jobportal.dto.ApplicationView(
                a.id,
                j.title,
                j.company,
                u.name,
                u.email,
                a.status,
                a.resumePath,
                a.appliedAt
            )
            FROM Application a
            JOIN Job j ON a.jobId = j.id
            JOIN User u ON a.userId = u.id
            WHERE j.id = :jobId
            AND j.postedBy = :rid
            ORDER BY a.appliedAt DESC
            """,
            ApplicationView.class
        )
        .setParameter("jobId", jobId)
        .setParameter("rid", recruiterId)
        .list();
    }
}

}
