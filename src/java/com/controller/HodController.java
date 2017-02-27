/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.misc.AppContextHelper;
import com.services.HodServices;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
@RequestMapping("/hod")
public class HodController {
    
    @RequestMapping(value="/approveOrIgnoreReq", method = RequestMethod.GET)
    public @ResponseBody String acceptReq(HttpServletRequest req, HttpServletResponse res){
        String user = req.getParameter("user");
        String id = req.getParameter("id");
        String msg = req.getParameter("msg");
        String status = req.getParameter("status");
        String otherStatus = req.getParameter("otherStatus");
        String utype = req.getParameter("utype");
        
//        int ucount = Integer.parseInt(req.getParameter("ucount"));
        double uleaves = Double.parseDouble(req.getParameter("uleaves"));
        double uleaveBal = Double.parseDouble(req.getParameter("uleaveBal"));
        HodServices ms = (HodServices)AppContextHelper.getAppContext().getBean("HodServices");
        
//        if(uleaves > 0 ){
//            if(uleaveBal > 0 && uleaveBal > ucount){
//                uleaveBal -= ucount;
//                uleaves -= ucount;
//            }
//        }
//        uleaveBal -= ucount;
//        uleaves -= ucount;
        
        JSONObject obj = new JSONObject();
        try{
            obj.put("user", user);
            obj.put("id", id);
            obj.put("msg", msg);
            obj.put("status", status); 
            obj.put("uleaves", uleaves); 
            obj.put("uleaveBal", uleaveBal); 
            obj.put("otherStatus", otherStatus);
            obj.put("utype", utype);
            
            String result = ms.approveOrIgnoreReq(obj);
            return result;
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return "Some error Occurred";
    }
    
}
