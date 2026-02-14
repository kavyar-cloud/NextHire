package com.jobportal.dto;

import java.time.LocalDateTime;

public class ApplicationView {

    private int applicationId;

    // Job info
    private String jobTitle;
    private String company;

    // Applicant info (recruiter view)
    private String applicantName;
    private String applicantEmail;

    // Application info
    private String status;
    private String resumePath;
    private LocalDateTime appliedAt;
    private boolean resumeViewed; // ✅ NEW FIELD

    /* =========================
       CONSTRUCTOR FOR USER VIEW
       ========================= */
    public ApplicationView(
            int applicationId,
            String jobTitle,
            String company,
            String status,
            String resumePath,
            LocalDateTime appliedAt,
            boolean resumeViewed
    ) {
        this.applicationId = applicationId;
        this.jobTitle = jobTitle;
        this.company = company;
        this.status = status;
        this.resumePath = resumePath;
        this.appliedAt = appliedAt;
        this.resumeViewed = resumeViewed;
    }

    /* ==============================
       CONSTRUCTOR FOR RECRUITER VIEW
       ============================== */
    public ApplicationView(
            int applicationId,
            String jobTitle,
            String company,
            String applicantName,
            String applicantEmail,
            String status,
            String resumePath,
            LocalDateTime appliedAt
    ) {
        this.applicationId = applicationId;
        this.jobTitle = jobTitle;
        this.company = company;
        this.applicantName = applicantName;
        this.applicantEmail = applicantEmail;
        this.status = status;
        this.resumePath = resumePath;
        this.appliedAt = appliedAt;
    }

    /* ========= GETTERS ========= */

    public int getApplicationId() {
        return applicationId;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public String getCompany() {
        return company;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public String getApplicantEmail() {
        return applicantEmail;
    }

    public String getStatus() {
        return status;
    }

    public String getResumePath() {
        return resumePath;
    }

    public LocalDateTime getAppliedAt() {
        return appliedAt;
    }

    public boolean isResumeViewed() {
        return resumeViewed;
    }
}
