/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.misc.AppContextHelper;
import com.services.StaffServices;
import com.services.AdminServices;
import com.services.userServices;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author divesh
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @RequestMapping(value = "/updateLeaveBal", method = RequestMethod.GET)
    public @ResponseBody
    String updateLeaveBal(HttpServletRequest req, HttpServletResponse res) {
        try{
            AdminServices hs = (AdminServices) AppContextHelper.getAppContext().getBean("AdminServices");
            String result = hs.updateMonthLeaves();
            if(result == "success"){
                return "success";
            }
        }catch(Exception e){
            System.out.println("error **** "+e.getMessage());
        }
        return "fail";
    }
    
    @RequestMapping(value = "/getUpdateLeaveBalDate", method = RequestMethod.GET)
    public @ResponseBody
    String getUpdateLeaveBalDate(HttpServletRequest req, HttpServletResponse res) {
        String result = "";
        try{
            AdminServices hs = (AdminServices) AppContextHelper.getAppContext().getBean("AdminServices");
            result = hs.getUpdateLeaveBalDate();
        }catch(Exception e){
            System.out.println("error **** "+e.getMessage());
        }
        return result;
    }
    
    @RequestMapping(value="/usrReg", method = RequestMethod.GET)
    public @ResponseBody 
    String storeUsrInfo(HttpServletRequest req, HttpServletResponse res){
        String fname = req.getParameter("fname");
        String lname = req.getParameter("lname");
        String gender = req.getParameter("gender");
        String emailId = req.getParameter("emailId");
        String passw = req.getParameter("passw");
        String utype = req.getParameter("type");
        String date = req.getParameter("date");
        
        JSONObject obj = new JSONObject();
        try{
            obj.put("fname",fname);
            obj.put("lname",lname);
            obj.put("gender",gender);
            obj.put("emailId",emailId);
            obj.put("passw",passw);
            obj.put("utype",utype);
            obj.put("dateOfJoin",date);
            if(utype.equals("staff")){
                obj.put("permStaff","no");
                obj.put("leaves",1);
                obj.put("leaveBal",1);
            }
            else{
                obj.put("permStaff","yes");
                obj.put("leaves",12);
                obj.put("leaveBal",1);
            }
            AdminServices hs = (AdminServices) AppContextHelper.getAppContext().getBean("AdminServices");
            String msg = hs.storeUsrInfo(obj);
            if(msg == "success"){
                userServices us = (userServices) AppContextHelper.getAppContext().getBean("userServices");
                String retMsg = us.sendMail(emailId,passw,utype);
                return retMsg;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return "fail";
    }
    
    @RequestMapping(value="/usrRegUpdate", method = RequestMethod.GET)
    public @ResponseBody 
    String usrRegUpdate(HttpServletRequest req, HttpServletResponse res){
        String utype = req.getParameter("utype");
        String permStaff = req.getParameter("permStaff");
        String leaves = req.getParameter("leaves");
        String leaveBal = req.getParameter("leaveBal");
        String emailId = req.getParameter("emailId");
        String firstEdit = req.getParameter("firstEdit");
        
        JSONObject obj = new JSONObject();
        try{
            obj.put("permStaff",permStaff);
            obj.put("leaves",leaves);
            obj.put("leaveBal",leaveBal);
            obj.put("utype",utype);
            obj.put("emailId",emailId);
            obj.put("firstEdit",firstEdit);
            
            AdminServices hs = (AdminServices) AppContextHelper.getAppContext().getBean("AdminServices");
            String msg = hs.updateUsrInfo(obj);
            return msg;
        }catch(Exception e){
            e.printStackTrace();
        }
        return "fail";
    }
    
    @RequestMapping(value="/addYL", method = RequestMethod.GET)
    public @ResponseBody 
    String storeYearHL(HttpServletRequest req, HttpServletResponse res){
        String data = req.getParameter("data");
        try{
            JSONArray arr = new JSONArray(data);
            AdminServices hs = (AdminServices) AppContextHelper.getAppContext().getBean("AdminServices");
            String msg = hs.storeYearHL(arr);
            return msg;
        }catch(Exception e){
            e.printStackTrace();
        }
        return "fail";
    }
    
    @RequestMapping(value="/removeUsr", method = RequestMethod.GET)
    public @ResponseBody 
    String removeUsr(HttpServletRequest req, HttpServletResponse res){
        String emailId = req.getParameter("emailId");
        
        JSONObject obj = new JSONObject();
        try{
            obj.put("emailId",emailId);
            AdminServices hs = (AdminServices) AppContextHelper.getAppContext().getBean("AdminServices");
            String msg = hs.removeUser(obj);
            return msg;
        }catch(Exception e){
            e.printStackTrace();
        }
        return "fail";
    }
    
    @RequestMapping(value="/getAllUsers", method = RequestMethod.GET)
    public @ResponseBody String getAllUsers(HttpServletRequest req, HttpServletResponse res){
        try{
            AdminServices hs = (AdminServices) AppContextHelper.getAppContext().getBean("AdminServices");
            JSONArray arr = hs.getAllUsers();
            if(arr != null){
                return arr.toString();
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return "fail";
    }
    
}
