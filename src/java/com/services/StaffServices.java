/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.services;

import org.json.JSONObject;

/**
 *
 * @author divesh
 */
public interface StaffServices {
    
    public String reqForLeave(JSONObject obj);
    
    public String changePassw(JSONObject obj);
    
    
}
