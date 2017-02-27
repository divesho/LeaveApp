/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.services;

import com.daoUtils.MongoDBFactory;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author divesh
 */
public class AdminServicesImpl implements AdminServices {

    @Override
    public String updateMonthLeaves() {

        DB db = MongoDBFactory.getDatabase();

        try {
            boolean flag = true;
            Calendar cal = Calendar.getInstance();
            String today = ((cal.get(Calendar.MONTH)+1))+"/"+cal.get(Calendar.DATE)+"/"+cal.get(Calendar.YEAR);

            while (flag) {
                DBCollection collection = db.getCollection("leaveDate");
                DBCursor cursorDoc = collection.find();
                if (cursorDoc.hasNext()) {
                    DBObject dbObject1 = cursorDoc.next();
                    JSONObject dbObj = new JSONObject(dbObject1.toString());
                    String monthEnd = dbObj.getString("updateDate");
                    System.out.println("");
                    Date date1 = new Date(monthEnd);
                    Date date2 = new Date(today);
                    if (date1.compareTo(date2) > 0) {
                        flag=false;
                    } else if (date1.compareTo(date2) < 0) {
                        System.out.println("monthEnd is before today" + date1 + "  : today - " + date2);
                        // update date
                        collection = db.getCollection("leaveDate");
                        BasicDBObject cond1 = new BasicDBObject();
                        cond1.append("updateDate", monthEnd);

                        Calendar cal1 = Calendar.getInstance();
                        cal1.setTime(date1);
                        cal1.add(Calendar.MONTH, 1);
                        String nextDate = ((cal1.get(Calendar.MONTH)) + 1) + "/" + cal1.getActualMaximum(Calendar.DAY_OF_MONTH) + "/" + cal1.get(Calendar.YEAR);
                        System.out.println("nextDate :  "+nextDate+" cal1 : "+cal1.getTime());
                        BasicDBObject dbObj1 = new BasicDBObject();
                        dbObj1.append("$set", new BasicDBObject().append("updateDate", nextDate));
                        collection.update(cond1, dbObj1);

                        // update leaveBal
                        collection = db.getCollection("userInfo");
                        BasicDBObject newObj = new BasicDBObject();
                        BasicDBObject cond = new BasicDBObject();
                        cond.append("utype", "staff");
                        newObj.append("$inc", new BasicDBObject().append("leaveBal", 1));
                        collection.update(cond, newObj, false, true);
                        cond.append("utype", "hod");
                        newObj.append("$inc", new BasicDBObject().append("leaveBal", 1));
                        collection.update(cond, newObj, false, true);
                        cond.append("utype", "admin");
                        newObj.append("$inc", new BasicDBObject().append("leaveBal", 1));
                        collection.update(cond, newObj, false, true);
                        // again compare ..
                        flag=true;
                    } else if (date1.compareTo(date2) == 0) {
                        System.out.println("monthEnd is equal to today");
                        // update date
                        collection = db.getCollection("leaveDate");
                        BasicDBObject cond1 = new BasicDBObject();
                        cond1.append("updateDate", monthEnd);

                        Calendar cal1 = Calendar.getInstance();
                        cal1.setTime(date1);
                        cal1.add(Calendar.MONTH, 1);
                        String nextDate = ((cal1.get(Calendar.MONTH)) + 1) + "/" + cal1.getActualMaximum(Calendar.DAY_OF_MONTH) + "/" + cal1.get(Calendar.YEAR);
                        System.out.println("nextDate :  "+nextDate+" cal1 : "+cal1.getTime());
                        BasicDBObject dbObj1 = new BasicDBObject();
                        dbObj1.append("$set", new BasicDBObject().append("updateDate", nextDate));
                        collection.update(cond1, dbObj1);

                        // update leaveBal
                        collection = db.getCollection("userInfo");
                        BasicDBObject newObj = new BasicDBObject();
                        BasicDBObject cond = new BasicDBObject();
                        cond.append("utype", "staff");
                        newObj.append("$inc", new BasicDBObject().append("leaveBal", 1));
                        collection.update(cond, newObj, false, true);
                        cond.append("utype", "hod");
                        newObj.append("$inc", new BasicDBObject().append("leaveBal", 1));
                        collection.update(cond, newObj, false, true);
                        cond.append("utype", "admin");
                        newObj.append("$inc", new BasicDBObject().append("leaveBal", 1));
                        collection.update(cond, newObj, false, true);
                        flag=false;
                    }
                }
            }
            return "success";
        } catch (Exception e) {
            e.printStackTrace();

        }
        return "fail";
    }
    
    @Override
    public String getUpdateLeaveBalDate() {
        try{
            DB db = MongoDBFactory.getDatabase();
            DBCollection collection = db.getCollection("leaveDate");
            DBCursor cursorDoc = collection.find();
            if (cursorDoc.hasNext()) {
                DBObject dbObject1 = cursorDoc.next();
                JSONObject dbObj = new JSONObject(dbObject1.toString());
                String monthEnd = dbObj.getString("updateDate");
                return monthEnd;
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        return "";
    }

    @Override
    public String storeUsrInfo(JSONObject obj) {
        DB db = MongoDBFactory.getDatabase();
        DBCollection collection = db.getCollection("userInfo");
        try {

            DBObject query1 = new BasicDBObject("emailId", obj.getString("emailId"));
            DBCursor cursorDoc = collection.find(query1);
            if (cursorDoc.hasNext()) {
                DBObject dbObject1 = cursorDoc.next();
                JSONObject returnObj = new JSONObject(dbObject1.toString());
                System.out.print("error obj -- >" + returnObj.toString());
                return "duplicate";
            } else {
                BasicDBObject dbObj = new BasicDBObject();
                dbObj.append("usrFname", obj.getString("fname"));
                dbObj.append("usrLname", obj.getString("lname"));
                dbObj.append("gender", obj.getString("gender"));
                dbObj.append("emailId", obj.getString("emailId"));
                dbObj.append("passw", obj.getString("passw"));
                dbObj.append("utype", obj.getString("utype"));
                dbObj.append("leaves", obj.getDouble("leaves"));
                dbObj.append("dateOfJoin", obj.getString("dateOfJoin"));
                dbObj.append("leaveBal", obj.getDouble("leaveBal"));
                dbObj.append("permStaff", obj.getString("permStaff"));
                dbObj.append("firstEdit", "yes");
                
                collection.insert(dbObj);
                return "success";
            }
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return "error";
    }

    @Override
    public String updateUsrInfo(JSONObject obj) {
        DB db = MongoDBFactory.getDatabase();
        DBCollection collection = db.getCollection("userInfo");
        try {
            BasicDBObject dbObj = new BasicDBObject();
            dbObj.append("utype", obj.getString("utype"));
            dbObj.append("leaves", obj.getDouble("leaves"));
            dbObj.append("leaveBal", obj.getDouble("leaveBal"));
            dbObj.append("permStaff", obj.getString("permStaff"));
            dbObj.append("firstEdit", obj.getString("firstEdit"));

            BasicDBObject newObj = new BasicDBObject();
            BasicDBObject cond = new BasicDBObject();
            cond.append("emailId", obj.getString("emailId"));
            newObj.append("$set", dbObj);
            collection.update(cond, newObj, false, true);
            return "success";
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return "error";
    }

    @Override
    public String removeUser(JSONObject obj) {
        DB db = MongoDBFactory.getDatabase();
        DBCollection collection = db.getCollection("userInfo");
        try {
            DBObject query1 = new BasicDBObject("emailId", obj.getString("emailId"));
            collection.remove(query1);
            return "success";
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return "error";
    }

    @Override
    public JSONArray getAllUsers() {
        DB db = MongoDBFactory.getDatabase();
        DBCollection collection = db.getCollection("userInfo");
        try {
            JSONArray arr = new JSONArray();
            //DBObject query1 = new BasicDBObject("emailId", obj.getString("emailId"));
            DBCursor cursorDoc = collection.find();
            while (cursorDoc.hasNext()) {
                DBObject dbObject1 = cursorDoc.next();
                JSONObject returnObj = new JSONObject(dbObject1.toString());
                arr.put(returnObj);
            }
            return arr;
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return null;
    }
    
    @Override
    public String storeYearHL(JSONArray arr) {
        DB db = MongoDBFactory.getDatabase();
        DBCollection collection = db.getCollection("yearHL");
        try {
            //DBObject query1 = new BasicDBObject("emailId", obj.getString("emailId"));
            BasicDBObject dbObj = new BasicDBObject();
            collection.remove(dbObj);
            for(int i=0; i<arr.length(); i++){
                BasicDBObject dbObj1 = new BasicDBObject();
                dbObj1.append("reason",arr.getJSONObject(i).get("reason"));
                dbObj1.append("date",arr.getJSONObject(i).get("date"));
                dbObj1.append("status","yearHL");
                collection.insert(dbObj1);
            }
            return "success";
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return "error";
    }
}
