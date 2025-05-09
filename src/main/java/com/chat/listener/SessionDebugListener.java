package com.chat.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class SessionDebugListener implements HttpSessionListener {
    
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        System.out.println("==== Session Created ====");
        System.out.println("Session ID: " + session.getId());
        System.out.println("Creation Time: " + new java.util.Date(session.getCreationTime()));
        System.out.println("=========================");
    }
    
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        System.out.println("==== Session Destroyed ====");
        System.out.println("Session ID: " + session.getId());
        System.out.println("Last Access: " + new java.util.Date(session.getLastAccessedTime()));
        System.out.println("Duration: " + ((System.currentTimeMillis() - session.getCreationTime()) / 1000) + " seconds");
        System.out.println("===========================");
    }
}