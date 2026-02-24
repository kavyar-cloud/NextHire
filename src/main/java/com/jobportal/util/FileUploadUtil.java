package com.jobportal.util;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.http.Part;

public class FileUploadUtil {

    
    private static final String UPLOAD_DIR = "E:\\intellij files\\NextHire\\uploads"; // external folder

public static String save(Part filePart) throws IOException {
    String originalFileName = filePart.getSubmittedFileName();
    String fileName = System.currentTimeMillis() + "_" + originalFileName.replaceAll("\\s+", "_");

    File uploadDir = new File(UPLOAD_DIR);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs();
    }

    filePart.write(UPLOAD_DIR + File.separator + fileName);

    // Save relative path in DB
    return "uploads/" + fileName;
}

}
