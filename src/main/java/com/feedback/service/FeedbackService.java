package com.feedback.service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;

import com.feedback.model.Feedback;

public class FeedbackService {
    private static final String FEEDBACK_FILE_NAME = "C:\\Users\\Tharusha\\Documents\\Java projects\\feedback\\src\\main\\webapp\\WEB-INF\\feedbacks.txt";
  
    public boolean saveFeedback(Feedback feedback, HttpServletRequest request) {
        try {

            File file = new File(FEEDBACK_FILE_NAME);
            

            if (!isWritable(file)) {
                String userHome = System.getProperty("user.home");
                file = new File(userHome + File.separator + FEEDBACK_FILE_NAME);
            }
            if (!isWritable(file)) {
                String tempDir = System.getProperty("java.io.tmpdir");
                file = new File(tempDir + File.separator + FEEDBACK_FILE_NAME);
            }
            
            File parentDir = file.getParentFile();
            if (parentDir != null && !parentDir.exists()) {
                parentDir.mkdirs();
            }
            

            System.out.println("Writing feedback to: " + file.getAbsolutePath());
            

            
            if (!file.exists()) {
                file.createNewFile();
            }
            

            FileWriter fw = new FileWriter(file, true);
            
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(feedback.toString());
            bw.newLine();
            bw.close();
            
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private boolean isWritable(File file) {

        if (file.exists()) {
            return file.canWrite();
        }
        
        try {

            if (file.createNewFile()) {
                file.delete();
                return true;
                
                
            }
            return false;
        } catch (IOException e) {
            return false;
        }
    }
}