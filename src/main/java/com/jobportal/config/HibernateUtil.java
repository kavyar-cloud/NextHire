package com.jobportal.config;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

import com.jobportal.entity.Application;
import com.jobportal.entity.ContactMessage;
import com.jobportal.entity.Job;
import com.jobportal.entity.Recruiter;
import com.jobportal.entity.RecruiterProfile;
import com.jobportal.entity.User;

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
            cfg.setProperty("hibernate.hbm2ddl.auto", "update");
            cfg.setProperty("hibernate.show_sql", "true");
            cfg.setProperty("hibernate.format_sql", "true");

            // Register entities
            cfg.addAnnotatedClass(User.class);
            cfg.addAnnotatedClass(Job.class);
            cfg.addAnnotatedClass(Application.class);
            cfg.addAnnotatedClass(ContactMessage.class);
            cfg.addAnnotatedClass(Recruiter.class);
            cfg.addAnnotatedClass(RecruiterProfile.class);

            // ✅ Build with ServiceRegistry (required in Hibernate 6+)
            return cfg.buildSessionFactory(
                new StandardServiceRegistryBuilder().applySettings(cfg.getProperties()).build()
            );
        } catch (Exception e) {
            throw new RuntimeException("❌ Failed to build SessionFactory", e);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}
