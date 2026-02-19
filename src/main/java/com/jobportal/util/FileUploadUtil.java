package com.jobportal.util;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

public class FileUploadUtil {

    private static final String UPLOAD_DIR = "uploads";

    // 🔥 Save file inside deployed webapp folder
    public static String save(Part filePart, ServletContext context) throws IOException {

        // Clean filename
        String originalFileName = filePart.getSubmittedFileName();
        String fileName = System.currentTimeMillis() + "_" + originalFileName.replaceAll("\\s+", "_");

        // Get real deployed path (Tomcat webapps/JobPortal)
        String uploadPath = context.getRealPath("") + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Save file
        filePart.write(uploadPath + File.separator + fileName);

        // Return relative path (stored in DB)
        return UPLOAD_DIR + "/" + fileName;
    }
}
