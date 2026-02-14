package com.jobportal.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jobportal.config.HibernateUtil;
import com.jobportal.entity.User;

public class UserDao {

    // Save a new user (for registration)
    public void saveUser(User user) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(user);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Failed to save user", e);
        }
    }

    // Login: fetch user by email and password
    public User getUserByEmailAndPassword(String email, String password) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM User WHERE email = :email AND password = :password", User.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .uniqueResult();
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch user", e);
        }
    }

    // Update profile
    public boolean updateProfile(User user) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(user);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }
    

    // Fetch user by ID (to refresh session after update)
    public User getUserById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.find(User.class, id);  // ✅ modern replacement
        }
    }
    
    
}
