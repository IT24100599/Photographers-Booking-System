package com.userMgr.services;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import com.userMgr.models.ImageModel;

public class ImageService {
    private static final String UPLOAD_DIR = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\uploads";
    
    // Initialize upload directory
    public void init(String appPath) {
        Path uploadPath = Paths.get(appPath, UPLOAD_DIR);
        if (!Files.exists(uploadPath)) {
            try {
                Files.createDirectories(uploadPath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Save uploaded image and return the image model
    public ImageModel saveImage(String appPath, String userId, String fileName, byte[] fileContent) 
            throws IOException {
        // Create a unique file name to prevent overwrites
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
        
        // Create the file path
        Path filePath = Paths.get(appPath, UPLOAD_DIR, uniqueFileName);
        
        // Save the file
        Files.write(filePath, fileContent);
        
        // Create and return the image model
        return new ImageModel(userId, uniqueFileName);
    }
    
    // Get the image file
    public File getImageFile(String appPath, String fileName) {
        Path filePath = Paths.get(appPath, UPLOAD_DIR, fileName);
        File file = filePath.toFile();
        
        if (file.exists()) {
            return file;
        }
        
        // Return a default image if file doesn't exist
        return Paths.get(appPath, UPLOAD_DIR, "default.png").toFile();
    }
    
    // Get image URL relative to context
    public String getImageUrl(String fileName) {
        return UPLOAD_DIR + "/" + fileName;
    }
}