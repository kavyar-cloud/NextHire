package com.jobportal.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jobportal.config.HibernateUtil;
import com.jobportal.entity.User;

public class UserDao {

    /* ================= SAVE USER (REGISTER) ================= */
    public void saveUser(User user) {
        Transaction tx = null;

        try (Session session = HibernateUtil
                .getSessionFactory()
                .openSession()) {

            tx = session.beginTransaction();
            session.persist(user);
            tx.commit();

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException("Failed to save user", e);
        }
    }


    /* ================= LOGIN ================= */
    public User getUserByEmailAndPassword(String email,
                                          String password) {

        try (Session session = HibernateUtil
                .getSessionFactory()
                .openSession()) {

            return session.createQuery(
                    "FROM User WHERE email = :email AND password = :password",
                    User.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .uniqueResult();

        } catch (Exception e) {
            throw new RuntimeException("Login failed", e);
        }
    }


    /* ================= FETCH BY EMAIL (Forgot Password) ================= */
    public User getUserByEmail(String email) {

        try (Session session = HibernateUtil
                .getSessionFactory()
                .openSession()) {

            return session.createQuery(
                    "FROM User WHERE email = :email",
                    User.class)
                    .setParameter("email", email)
                    .uniqueResult();

        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch user by email", e);
        }
    }


    /* ================= UPDATE PASSWORD ================= */
    public boolean updatePassword(String email,
                                  String newPassword) {

        Transaction tx = null;

        try (Session session = HibernateUtil
                .getSessionFactory()
                .openSession()) {

            tx = session.beginTransaction();

            User user = session.createQuery(
                    "FROM User WHERE email = :email",
                    User.class)
                    .setParameter("email", email)
                    .uniqueResult();

            if (user != null) {
                user.setPassword(newPassword);
                session.merge(user);
                tx.commit();
                return true;
            }

            tx.rollback();
            return false;

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }


    /* ================= UPDATE PROFILE ================= */
    public boolean updateProfile(User user) {

        Transaction tx = null;

        try (Session session = HibernateUtil
                .getSessionFactory()
                .openSession()) {

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


    /* ================= FETCH BY ID ================= */
    public User getUserById(int id) {

        try (Session session = HibernateUtil
                .getSessionFactory()
                .openSession()) {

            return session.find(User.class, id);
        }
    }
}