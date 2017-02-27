/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.daoUtils;

import com.mongodb.DB;
import com.mongodb.MongoClient;
import java.net.UnknownHostException;

/**
 *
 * @author divesh
 */
public class MongoDBFactory {
    private static DB db = null;
    
    private static void createDB(){
        try{
            MongoClient mc = new MongoClient("localhost",27017);
            db = mc.getDB("userInfo");
        }catch(Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        
    }
    
    public static DB getDatabase(){
        if(db == null){
            createDB();
        }
        return db;
    }
    
}
