/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.services;

import com.daoUtils.MongoDBFactory;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import org.bson.types.ObjectId;
import org.json.JSONObject;

/**
 *
 * @author divesh
 */
public class HodServicesImpl implements HodServices{

    @Override
    public String approveOrIgnoreReq(JSONObject obj) {
        DB db = MongoDBFactory.getDatabase();
        try{
            DBCollection collection = db.getCollection("leaves");
            BasicDBObject dbObj1 = new BasicDBObject();
            BasicDBObject dbObj2 = new BasicDBObject();
            dbObj1.append("_id", new ObjectId(obj.getString("id")));
            String str = dbObj1.toString();
            System.out.printf("dbObj1 "+dbObj1.toString());
            BasicDBObject dbObj3 = new BasicDBObject();
            if(obj.getString("status").equals("ignored")){
                dbObj3.append("status", "ignored");
            }else{
               if(obj.getString("otherStatus").equals("approved")){
                    dbObj3.append("status", "approved");
                }else{
                    dbObj3.append("status", "pending");
                } 
            }
            if(obj.getString("utype").equals("hod")){
                dbObj3.append("hodStatus", obj.getString("status"));
            }else{
                dbObj3.append("prncStatus", obj.getString("status"));
            }
            dbObj3.append("leaves", obj.getDouble("uleaves"));
            dbObj3.append("leaveBal", obj.getDouble("uleaveBal"));
            dbObj2.append("$set", dbObj3);
            collection.update(dbObj1,dbObj2);
            
            collection = db.getCollection("userInfo");
            BasicDBObject dbObj4 = new BasicDBObject();
            BasicDBObject dbObj5 = new BasicDBObject();
            BasicDBObject dbObj6 = new BasicDBObject();
            dbObj4.append("emailId", obj.getString("user"));
            dbObj5.append("leaves", obj.getDouble("uleaves"));
            dbObj5.append("leaveBal", obj.getDouble("uleaveBal"));
            dbObj6.append("$set", dbObj5);
            collection.update(dbObj4,dbObj6);
            
            return "success";            
        }catch(Exception e){
            e.printStackTrace();
        }

        return "fail";
    }
    
}
