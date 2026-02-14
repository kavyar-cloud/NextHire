package com.jobportal.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jobportal.config.HibernateUtil;
import com.jobportal.dto.ApplicationView;
import com.jobportal.entity.Application;

public class ApplicationDao {

    // Save application
    public void saveApplication(Application app) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(app);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException(e);
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
                app.setStatus(status);
            }
            tx.commit();
        }
    }

    // ===== WITHDRAW =====
    public void withdrawApplication(int applicationId) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Application app = session.find(Application.class, applicationId);
            if (app != null && "Pending".equalsIgnoreCase(app.getStatus())) {
                app.setStatus("Withdrawn");
            }
            tx.commit();
        }
    }

    // ===== RESUME VIEW TRACK =====
    public String markResumeViewed(int applicationId) {
        Transaction tx = null;
        String resumePath;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            Application app = session.find(Application.class, applicationId);
            app.setResumeViewed(true);
            resumePath = app.getResumePath();

            tx.commit();
        }

        return resumePath;
    }

    public boolean hasUserApplied(int jobId, int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = session.createQuery(
                    "SELECT COUNT(a.id) FROM Application a WHERE a.jobId = :jobId AND a.userId = :userId",
                    Long.class)
                .setParameter("jobId", jobId)
                .setParameter("userId", userId)
                .uniqueResult();
    
            return count != null && count > 0;
        }
    }
    
    
    
}
