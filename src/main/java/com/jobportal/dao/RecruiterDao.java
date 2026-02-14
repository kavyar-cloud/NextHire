package com.jobportal.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jobportal.config.HibernateUtil;
import com.jobportal.entity.Recruiter;

public class RecruiterDao {

    // Save a new recruiter (for registration)
    public void saveRecruiter(Recruiter recruiter) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(recruiter);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Failed to save recruiter", e);
        }
    }

    // Login: fetch recruiter by email and password
    public Recruiter getRecruiterByEmailAndPassword(String email, String password) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM Recruiter WHERE email = :email AND password = :password", Recruiter.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .uniqueResult();
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch recruiter", e);
        }
    }

    // Update recruiter profile
    public boolean updateProfile(Recruiter recruiter) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(recruiter);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    // Fetch recruiter by ID (to refresh session after update)
    public Recruiter getRecruiterById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.find(Recruiter.class, id);
        }
    }
}
