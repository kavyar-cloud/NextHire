package com.jobportal.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "recruiter")
public class Recruiter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private String email;
    private String phone;

    @Column(name = "company_name")
    private String companyName;

    private String website;
    private String location;
    private String industry;

    private String logo;        // path to company logo
    private String profileDoc;  // path to company profile PDF

    @Column(length = 2000)
    private String summary;

    // Constructors
    public Recruiter() {}

    public Recruiter(int id, String name, String email, String phone,
                     String companyName, String website, String location,
                     String industry, String logo, String profileDoc, String summary) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.companyName = companyName;
        this.website = website;
        this.location = location;
        this.industry = industry;
        this.logo = logo;
        this.profileDoc = profileDoc;
        this.summary = summary;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getIndustry() { return industry; }
    public void setIndustry(String industry) { this.industry = industry; }

    public String getLogo() { return logo; }
    public void setLogo(String logo) { this.logo = logo; }

    public String getProfileDoc() { return profileDoc; }
    public void setProfileDoc(String profileDoc) { this.profileDoc = profileDoc; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
}
