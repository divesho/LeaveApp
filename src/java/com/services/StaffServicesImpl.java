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
import java.util.Date;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author divesh
 */
public class StaffServicesImpl implements StaffServices{

    @Override
    public String reqForLeave(JSONObject obj) {
        DB db = MongoDBFactory.getDatabase();
        
        JSONArray arr1 = new JSONArray();
        double count = 0.0;
        //String fromdate = "";
        //String todate = "";
        try{
            count = obj.getDouble("count");
            Date fromdate = new Date(obj.getString("fromDate"));
            Date todate = new Date(obj.getString("toDate"));
            
            DBCollection collection = db.getCollection("yearHL");
            DBCursor cursorDoc = collection.find();
            
            while (cursorDoc.hasNext()) {
                DBObject dbObj = cursorDoc.next();
                JSONObject hodObj = new JSONObject(dbObj.toString());
                arr1.put(hodObj);
            }
            
            for(int i=0; i<arr1.length(); i++){
                Date hlDay = new Date(arr1.getJSONObject(i).getString("date"));
                int compFrom = hlDay.compareTo(fromdate);
                if(fromdate.compareTo(todate) == 0 && compFrom == 0){
                    count--;
                    break;
                }
                int compTo = hlDay.compareTo(todate);
                if((compFrom == 0 || compFrom > 0) && (compTo == 0 || compTo < 0)){
                    count--;
                }
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        
        
        DBCollection collection = db.getCollection("leaves");
        BasicDBObject dbObj = new BasicDBObject();
        try{
            System.out.println(obj.toString());
            
            dbObj.append("casOrDuty", obj.getString("casOrDuty"));
            dbObj.append("fromDate", obj.getString("fromDate"));
            dbObj.append("toDate", obj.getString("toDate"));
            dbObj.append("reason", obj.getString("reason"));
            dbObj.append("user", obj.getString("user"));
            dbObj.append("count", count);
            dbObj.append("leaves", obj.getDouble("leaves"));
            dbObj.append("leaveBal", obj.getDouble("leaveBal"));
            dbObj.append("hod", obj.getString("hod"));
            dbObj.append("status","pending");
            dbObj.append("hodStatus","pending");
            Date today = new Date();
            Date fromdate = new Date(obj.getString("fromDate"));
            if(count < 3.0){
                dbObj.append("prncStatus","approved");
            }else{
                dbObj.append("prncStatus","pending");
            }
            
            
            if((obj.getString("leaveType")).equals(""))
                dbObj.append("leaveType", "FullDays");
            else
                dbObj.append("leaveType", obj.getString("leaveType"));
            collection.insert(dbObj);
            return "success";
            //return "success";
        }catch(Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return "fail";
    }
    
    @Override
    public String changePassw(JSONObject obj) {
        DB db = MongoDBFactory.getDatabase();
        DBCollection collection = db.getCollection("userInfo");
        BasicDBObject dbObj1 = new BasicDBObject();
        try{
            DBObject query1 = new BasicDBObject("emailId", obj.getString("user"));
            DBCursor cursorDoc = collection.find(query1);
            if(cursorDoc.hasNext()){
                DBObject dbObject1 = cursorDoc.next();
                JSONObject resultObj = new JSONObject(dbObject1.toString());
                System.out.print("error obj -- >"+resultObj.toString());
                if((obj.getString("oldPassw")).equals(resultObj.getString("passw"))){
                    BasicDBObject newObj = new BasicDBObject();
                    newObj.append("$set", new BasicDBObject().append("passw", obj.getString("newPassw")));
                    dbObj1.append("emailId", obj.getString("user"));
                    collection.update(dbObj1,newObj);
                    return "success";
                }else{
                    return "wrongPssw";
                }
            }else{
                return "fail";
            }
            //return "success";
        }catch(Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return "fail";
    }
    
}
