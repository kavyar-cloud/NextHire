package com.jobportal.dao;

import com.jobportal.config.HibernateUtil;
import com.jobportal.entity.ContactMessage;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class ContactDao {

    // Save contact message
    public void saveMessage(ContactMessage message) {
        Transaction tx = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            tx = session.beginTransaction();
            session.persist(message);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback(); // ✅ SAFE
                } catch (Exception ignored) {
                }
            }
            throw new RuntimeException("Failed to save contact message", e);
        } finally {
            session.close(); // ✅ ALWAYS close
        }
    }

    // Fetch all messages (Admin use)
    public List<ContactMessage> getAllMessages() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            return session.createQuery(
                    "FROM ContactMessage ORDER BY createdAt DESC",
                    ContactMessage.class
            ).list();
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch contact messages", e);
        } finally {
            session.close();
        }
    }

    // Delete a message (optional)
    public void deleteMessage(int messageId) {
        Transaction tx = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            tx = session.beginTransaction();
            ContactMessage msg = session.find(ContactMessage.class, messageId);
            if (msg != null) {
                session.remove(msg);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (Exception ignored) {
                }
            }
            throw new RuntimeException("Failed to delete contact message", e);
        } finally {
            session.close();
        }
    }
}
