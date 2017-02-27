/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.misc;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 *
 * @author divesh
 */
public class AppContextHelper {
    public static ApplicationContext context= null;
    
    public static ApplicationContext getAppContext(){
        if(context ==null){
            context = new ClassPathXmlApplicationContext("classpath:../application-context.xml");
        }
        return context;
    }
}
