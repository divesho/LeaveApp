/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.services;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author divesh
 */
public interface AdminServices {
    
    public String updateMonthLeaves();
    
    public String getUpdateLeaveBalDate();
    
    public String removeUser(JSONObject obj);
    
    public JSONArray getAllUsers();
    
    public String storeUsrInfo(JSONObject obj);
    
    public String updateUsrInfo(JSONObject obj);
    
    public String storeYearHL(JSONArray arr);
    
    
    
}
