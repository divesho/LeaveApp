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
import com.mongodb.util.JSON;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import org.json.JSONArray;
import org.json.JSONObject;
//import org.springframework.messaging.Message;
//import org.springframework.messaging.MessagingException;
//import sun.rmi.transport.Transport;

/**
 *
 * @author divesh
 */
public class userServicesImpl implements userServices {

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
                dbObj.append("emailId", obj.getString("emailId"));
                dbObj.append("passw", obj.getString("passw"));
                dbObj.append("utype", obj.getString("utype"));
                dbObj.append("leaves", obj.getDouble("leaves"));
                dbObj.append("leaveBal", obj.getDouble("leaveBal"));
                collection.insert(dbObj);
                return "success";
            }
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return "error";
    }

    @Override
    public JSONObject getUser(JSONObject obj) {
        DB db = MongoDBFactory.getDatabase();
        try {
            DBCollection collection = null;
            collection = db.getCollection("userInfo");
            DBObject dbObject = (DBObject) JSON.parse(obj.toString());
            JSONObject returnObj1 = new JSONObject();
            DBCursor cursorDoc = collection.find(dbObject);

            if (cursorDoc.hasNext()) {
                DBObject dbObject1 = cursorDoc.next();
                returnObj1 = new JSONObject(dbObject1.toString());
                BasicDBObject dbObj = new BasicDBObject();
                collection = db.getCollection("leaves");
                if (obj.getString("utype").equals("staff")) {
                    dbObj.append("user", obj.getString("emailId"));
                } else if (obj.getString("utype").equals("hod")) {
                    dbObj.append("hod", obj.getString("emailId"));
                    dbObj.append("hodStatus", "pending");
                } else if (obj.getString("utype").equals("princi")) {
                    //dbObj.append("hod", obj.getString("emailId"));
                    dbObj.append("prncStatus", "pending");
                } else if (obj.getString("utype").equals("admin")) {
                    dbObj.append("admin", obj.getString("emailId"));
                    dbObj.append("status", "pending");
                }
                cursorDoc = collection.find(dbObj);
                JSONArray arr = new JSONArray();
                while (cursorDoc.hasNext()) {
                    DBObject dbObject2 = cursorDoc.next();
                    JSONObject hodObj = new JSONObject(dbObject2.toString());
                    arr.put(hodObj);
                }
                returnObj1.put("notify", arr);

                collection = db.getCollection("yearHL");
                cursorDoc = collection.find();
                JSONArray arr1 = new JSONArray();
                while (cursorDoc.hasNext()) {
                    DBObject dbObject3 = cursorDoc.next();
                    JSONObject hodObj = new JSONObject(dbObject3.toString());
                    arr1.put(hodObj);
                }
                returnObj1.put("yearHL", arr1);

                return returnObj1;

            }

        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return null;
    }

    @Override
    public JSONArray getCalendarEvents(String name) {
        DB db = MongoDBFactory.getDatabase();
        try {
            DBCollection collection = db.getCollection("leaves");
            BasicDBObject dbObj = new BasicDBObject();
            dbObj.append("user", name);
            DBCursor cursorDoc = collection.find(dbObj);
            JSONArray arr = new JSONArray();
            while (cursorDoc.hasNext()) {
                DBObject dbObject2 = cursorDoc.next();
                JSONObject hodObj = new JSONObject(dbObject2.toString());
                arr.put(hodObj);
            }
            collection = db.getCollection("yearHL");
            cursorDoc = collection.find();
            while (cursorDoc.hasNext()) {
                DBObject dbObject2 = cursorDoc.next();
                JSONObject hodObj = new JSONObject(dbObject2.toString());
                arr.put(hodObj);
            }
            return arr;
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return (new JSONArray());
    }

    @Override
    public String sendMail(String mailId, String passw, String utype) {
        boolean flag = true;
        //Get the session object
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        Session session = Session.getDefaultInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("noreplyleaveappjgi@gmail.com", "@admin321");//change accordingly
                    }
                });

        //compose message
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("noreplyleaveappjgi@gmail.com"));//change accordingly
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailId));
            message.setSubject("Leave App Credentials..");
//            String str = "<html><head></head><body><h1>Hi.. </hi><table>";
//            str += "<tr><td><h3>EmailId : </h3></td><td><h3>"+mailId+"</h3></td></tr>";
//            str += "<tr><td><h3>Password : </h3></td><td><h3>"+passw+"</h3></td></tr>";
//            str += "<tr><td><h3>type</h3></td><td><h3>"+utype+"</h3></td></tr>";
//            str += "</table>";
//            str += "<br><br><br><br>~Regards, <br>Admin@jgi.com<br><span style=\"color:red;\">Jain College Of Engineering, Belgaum</span></body></html>";
            String str = "Hi,\nPlease Find Credentials For LeaveApp\n";
            str += "\nEmailId : "+mailId;
            str += "\nPassword : "+passw;
            str += "\nType : "+utype;
            str += "\n\n\n~Regards,\nAdmin\nJain College Of Engineering";
            message.setText(str);

            //send message
            Transport.send(message);

        } catch (MessagingException e) {
            flag = false;
            throw new RuntimeException(e);
        }
        if(flag){
            return "success";
        }else{
            return "fail";
        }
    }

}
