package com.jobportal.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jobportal.config.HibernateUtil;
import com.jobportal.entity.RecruiterProfile;

public class RecruiterProfileDao {

    public RecruiterProfile findByUserId(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                "FROM RecruiterProfile rp WHERE rp.user.id = :uid",
                RecruiterProfile.class
            ).setParameter("uid", userId)
             .uniqueResult();
        }
    }

    public void saveOrUpdate(RecruiterProfile profile) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(profile);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }
}
