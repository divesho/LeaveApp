/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.misc.AppContextHelper;
import com.services.StaffServices;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.awt.AppContext;

/**
 *
 * @author divesh
 */
@Controller
@RequestMapping("/staff")
public class StaffController {

    @RequestMapping(value = "/reqForLeave", method = RequestMethod.GET)
    public @ResponseBody
    String reqForLeave(HttpServletRequest req, HttpServletResponse res) {
        
        String casOrDuty = req.getParameter("casOrDuty");
        String fromDate = req.getParameter("fromDate");
        String toDate = req.getParameter("toDate");
        String reason = req.getParameter("reason");
        String user = req.getParameter("user");
        double count = Double.parseDouble(req.getParameter("count"));
        String leaveType = req.getParameter("leaveType");
        String hod = req.getParameter("hod");
        double leaves = Double.parseDouble(req.getParameter("leaves"));
        double leaveBal = Double.parseDouble(req.getParameter("leaveBal"));
        
        SimpleDateFormat format1 = new SimpleDateFormat("MM/dd/yyyy");
        try {
            Calendar startCal = Calendar.getInstance();
            startCal.setTime(format1.parse(fromDate));
            Calendar endCal = Calendar.getInstance();
            endCal.setTime(format1.parse(toDate));
            //int workDays = 0;

            int holidays = 0;
            do {
                System.out.println("Calendar.SUNDAY =>>>> " + Calendar.SUNDAY);
            if (startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
                ++holidays;
            }
            startCal.add(Calendar.DAY_OF_MONTH, 1);
        } while (startCal.getTimeInMillis() <= endCal.getTimeInMillis());
            
            count = count - holidays;
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        JSONObject obj = new JSONObject();
        try {
//            SimpleDateFormat format = new SimpleDateFormat("MM/dd/YYYY");
//            Calendar startCal = Calendar.getInstance();
//            startCal.setTime(format.parse(fromDate));
//            Calendar endCal = Calendar.getInstance();
//            endCal.setTime(format.parse(toDate));
//            int holidays = 0;
//            do {
//                System.out.println("startCal.get(Calendar.DAY_OF_WEEK) "+startCal.get(Calendar.DAY_OF_WEEK));
//                if (startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
//                    ++holidays;
//                }
//                startCal.add(Calendar.DAY_OF_MONTH, 1);
//            } while (startCal.getTimeInMillis() <= endCal.getTimeInMillis());
//            count = count - holidays;
            
            obj.put("casOrDuty", casOrDuty);
            obj.put("fromDate", fromDate);
            obj.put("toDate", toDate);
            obj.put("reason", reason);
            obj.put("user", user);
            obj.put("count", count);
            obj.put("leaveType", leaveType);
            obj.put("hod", hod);
            obj.put("leaves", leaves);
            obj.put("leaveBal", leaveBal);
            StaffServices es = (StaffServices) AppContextHelper.getAppContext().getBean("StaffServices");
            String result = es.reqForLeave(obj);
            if (result == "success") {
                return result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "/changePassw", method = RequestMethod.GET)
    public @ResponseBody
    String changePassw(HttpServletRequest req, HttpServletResponse res) {
        String newPassw = req.getParameter("newPassw");
        String oldPassw = req.getParameter("oldPassw");
        String user = req.getParameter("user");

        JSONObject obj = new JSONObject();
        try {
            obj.put("newPassw", newPassw);
            obj.put("oldPassw", oldPassw);
            obj.put("user", user);
            StaffServices es = (StaffServices) AppContextHelper.getAppContext().getBean("StaffServices");
            String result = es.changePassw(obj);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }
}
