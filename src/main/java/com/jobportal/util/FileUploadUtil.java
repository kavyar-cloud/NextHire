package com.jobportal.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.http.Part;

public class FileUploadUtil {

    // Folder to save uploaded files (inside project)
    private static final String UPLOAD_DIR = "uploads";

    public static String save(Part filePart) throws IOException {
        String fileName = extractFileName(filePart);
    
        // Force save inside webapp/uploads
        String uploadPath = System.getProperty("user.dir")
                + File.separator + "src"
                + File.separator + "main"
                + File.separator + "webapp"
                + File.separator + UPLOAD_DIR;
    
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
    
        String filePath = uploadPath + File.separator + System.currentTimeMillis() + "_" + fileName;
        try (InputStream input = filePart.getInputStream();
             FileOutputStream output = new FileOutputStream(filePath)) {
    
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }
    
        // Return relative path for DB
        return UPLOAD_DIR + "/" + new File(filePath).getName();
    }
    
    
    

    private static String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                String fileName = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                // 🔥 Sanitize filename: replace spaces with underscores
                fileName = fileName.replaceAll("\\s+", "_");
                return fileName;
            }
        }
        return "";
    }
    
}
