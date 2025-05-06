package com.admin.model;

public class Admin {
    private String fullName;
    private String userName;
    private String email;
    private String gender;
    private String phone;
    private String password;

    // Constructor
    public Admin(String fullName, String userName, String email, String gender, String phone, String password) {
        this.fullName = fullName;
        this.userName = userName;
        this.email = email;
        this.gender = gender;
        this.phone = phone;
        this.password = password;
    }

    // Getters
    public String getFullName() {
        return fullName;
    }

    public String getUserName() {
        return userName;
    }

    public String getEmail() {
        return email;
    }

    public String getGender() {
        return gender;
    }

    public String getPhone() {
        return phone;
    }

    public String getPassword() {
        return password;
    }

}
