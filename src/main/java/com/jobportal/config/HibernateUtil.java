package com.jobportal.config;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.jobportal.entity.RecruiterProfile;

public class HibernateUtil {
    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            Configuration cfg = new Configuration();

            // JDBC settings
            cfg.setProperty("hibernate.connection.driver_class", "org.postgresql.Driver");
            cfg.setProperty("hibernate.connection.url", "jdbc:postgresql://localhost:5432/job_portal");
            cfg.setProperty("hibernate.connection.username", "postgres");
            cfg.setProperty("hibernate.connection.password", "system");

            // Hibernate settings
            cfg.setProperty("hibernate.dialect", "org.hibernate.dialect.PostgreSQLDialect");
            cfg.setProperty("hibernate.hbm2ddl.auto", "update"); // or update during dev
            cfg.setProperty("hibernate.show_sql", "true");
            cfg.setProperty("hibernate.format_sql", "true");

            // Entities
            cfg.addAnnotatedClass(com.jobportal.entity.User.class);
            cfg.addAnnotatedClass(com.jobportal.entity.Job.class);
            cfg.addAnnotatedClass(com.jobportal.entity.Application.class);
            cfg.addAnnotatedClass(com.jobportal.entity.ContactMessage.class);
            cfg.addAnnotatedClass(RecruiterProfile.class);


            return cfg.buildSessionFactory();
        } catch (Exception e) {
            throw new RuntimeException("Failed to build SessionFactory", e);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}
