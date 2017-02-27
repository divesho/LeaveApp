/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.beans;

import java.util.Objects;

/**
 *
 * @author divesh
 */
public class userInfo {
    private String usrFname;
    private String usrLname;
    private String emailId;
    private String passw;

    public String getUsrFname() {
        return usrFname;
    }

    public void setUsrFname(String usrFname) {
        this.usrFname = usrFname;
    }

    public String getUsrLname() {
        return usrLname;
    }

    public void setUsrLname(String usrLname) {
        this.usrLname = usrLname;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public String getPassw() {
        return passw;
    }

    public void setPassw(String passw) {
        this.passw = passw;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 29 * hash + Objects.hashCode(this.usrFname);
        hash = 29 * hash + Objects.hashCode(this.usrLname);
        hash = 29 * hash + Objects.hashCode(this.emailId);
        hash = 29 * hash + Objects.hashCode(this.passw);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final userInfo other = (userInfo) obj;
        if (!Objects.equals(this.usrFname, other.usrFname)) {
            return false;
        }
        if (!Objects.equals(this.usrLname, other.usrLname)) {
            return false;
        }
        if (!Objects.equals(this.emailId, other.emailId)) {
            return false;
        }
        if (!Objects.equals(this.passw, other.passw)) {
            return false;
        }
        return true;
    }
    
    @Override
    public String toString(){
        return "userInfo:{'usrFname':"+usrFname+", 'usrLname':"+usrLname+", 'emailID':"+emailId+", 'passw':"+passw+"}"; 
    }
    
}
