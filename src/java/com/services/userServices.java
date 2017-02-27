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
public interface userServices {
    
    public String storeUsrInfo(JSONObject obj);
    
    public JSONArray getCalendarEvents(String name);

    public JSONObject getUser(JSONObject obj);
    
    public String sendMail(String mailId, String passw, String utype);
}
