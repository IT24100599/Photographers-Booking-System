package com.photographerMgr.models;

public class Photographer {
    private String username;
    private String password;
    private String email;
    private String fullName;
    private String gender;
    private String address;
    private String phone;
    private String skills;
    private String description;
    private String experience;
    @SuppressWarnings("unused")
	private String originalAddress;
    @SuppressWarnings("unused")
	private String originalSkills;
    private Double ratings;
    
    public Photographer(String username, Double ratings) {
    	this.username = username;
    	this.ratings = ratings;
    }

    public Photographer(String username, String password, String email, String gender, String address, String phone, String skills, String fName) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fName;
        this.gender = gender;
        setAddress(address);
        this.phone = phone;
        setSkills(skills);
        this.description = "N/A";
        this.experience = "N/A";
        this.originalAddress = getOriginalAddress();
        this.originalSkills = getOriginalSkills();
        this.ratings = 0.0;
    }
    

    public String getDefaultProfilePic() {
		 if (gender!="Hidden") {
			return gender.toLowerCase() + ".gif";
		} else {
			return "unknown.gif";
		}
	}
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
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
    
    public void setSkills(String skills) {
    	if (skills != null) {
            this.skills = skills.replace(",", "@;%");
        } else {
            this.skills = "";
        }
    }
    
    public String getSkills() {
    	return skills;
    }

    public String getOriginalSkills() {
        if (skills != null) {
            return skills.replace("@;%", ",");
        }
        return "";
    }
    
    
    public String getFullName() {
		return fullName;
	}
    
    public void setFullName(String fullName) {
    	this.fullName = fullName;
    }
    
    public void setExperience(String experience) {
    	this.experience = experience;
    }
    
    public String getExperience() {
    			return experience;
    }
    
    public void setDescription(String description) {
    	this.description = description;
    }
    
    public String getDescription() {
		return description;
	}
    
    public Double getRatings() {
    	return ratings;
    }
    
    public void setRatings(Double ratings) {
		this.ratings = ratings;
	}
   

    @Override
    public String toString() {
        return username + ", " + password + ", " + email + ", " + gender + ", " + address + ", " + phone + ", " + skills+", "+fullName;
    }
}
