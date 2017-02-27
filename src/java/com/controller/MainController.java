/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.misc.AppContextHelper;
import com.services.userServices;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.request;
import org.springframework.web.bind.annotation.*;

/**
 *
 * @author divesh
 */
@Controller
@RequestMapping("/main")
public class MainController {
    
    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest req, HttpServletResponse res, HttpSession session){
        session = req.getSession(false);
        System.out.println("User="+session.getAttribute("user"));
        if(session != null){
            session.invalidate();
        }
        return "forward:../resources/index.jsp";
    }
    
    @RequestMapping(value="/getCalendarEvents", method = RequestMethod.GET)
    public @ResponseBody String storeUsrInfo(HttpServletRequest req, HttpServletResponse res){
        JSONArray arr = new JSONArray();
        String name = req.getParameter("user");
        try{
            userServices us = (userServices) AppContextHelper.getAppContext().getBean("userServices");
            arr = us.getCalendarEvents(name);
        }catch(Exception e){
            e.printStackTrace();
        }
        System.out.println("arr **************  >> "+arr.toString());
        return arr.toString();
    }
    
    @RequestMapping(value="/login", method = RequestMethod.GET)
    public String getUser(HttpServletRequest req, HttpServletResponse res, HttpSession session){
        String emailId = req.getParameter("emailId");
        String passw = req.getParameter("passw");
        String utype = req.getParameter("type");
        String returnUri = "../resources/";
        JSONObject obj = new JSONObject();
        JSONObject returnObj = new JSONObject();
        try{
            obj.put("emailId",emailId);
            obj.put("passw",passw);
            obj.put("utype",utype);
            userServices us = (userServices) AppContextHelper.getAppContext().getBean("userServices");
            returnObj = us.getUser(obj);
            System.out.println("returnObj --> "+returnObj);
            if(returnObj != null){
                req.setAttribute("obj", returnObj);
                session = req.getSession();
                session.setAttribute("user", emailId);
                if(utype.equals("staff")){
                    returnUri = returnUri+"staffDashboard.jsp";
                }else if(utype.equals("hod")){
                    returnUri = returnUri+"hodDashboard.jsp";
                }else if(utype.equals("princi")){
                    returnUri = returnUri+"princDashboard.jsp";
                }else if(utype.equals("admin")){
                    returnUri = returnUri+"adminDashboard.jsp";
                }
                return "forward:"+returnUri;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        req.setAttribute("err", "EmailId or Password is wrong");
        String str = "../resources/index.jsp";
        return "forward:"+str;
    }
}
