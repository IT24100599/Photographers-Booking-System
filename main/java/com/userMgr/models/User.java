package com.userMgr.models;

public class User {
	private String fullName;	
    private String username;
    private String password;
    private String email;
    private String gender;
    private String address;
    private String phone;

    
    public User() {
    	this.fullName = "Null";
		this.username = "Null";
		this.password = "Null";
		this.email = "Null";
		this.gender = "Hidden";
		this.address = "Null";
		this.phone = "Null";
    }

    public User(String fullName ,String username, String password, String email, String gender, String address, String phone) {
        this.fullName = fullName;
    	this.username = username;
        this.password = password;
        this.email = email;
        this.gender = gender;
        setAddress(address); 
        this.phone = phone;
    }
    
    public String getDefaultProfilePic() {
		 if (gender!="Hidden") {
			return gender.toLowerCase() + ".gif";
		} else {
			return "unknown.gif";
		}
	}
    
    public String getFullName() {
    	return fullName;
    }
    
    public void setFullName(String fullName) {
		this.fullName = fullName;
	}
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
    	username = username.toLowerCase();
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        if (address != null) {
            // Replace all commas with "@;%"
            this.address = address.replace(",", "@;%");
        } else {
            this.address = "";
        }
    }
    
    public String getOriginalAddress() {
        if (address != null) {
            return address.replace("@;%", ",");
        }
        return "";
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return fullName + ", " + username + ", " + password + ", " + email + ", " + gender + ", " + address + ", " + phone;
    }
}
