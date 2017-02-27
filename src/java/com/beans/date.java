/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.beans;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author divesh
 */
public class date {

    public static int getweekendcount(String date1,String date2){
        SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");
        int workDays = 0;
        
        try {
            Calendar startCal = Calendar.getInstance();
            startCal.setTime(format.parse(date1));
            Calendar endCal = Calendar.getInstance();
            endCal.setTime(format.parse(date2));
            //int workDays = 0;
            
            do {
                System.out.println("Calendar.SUNDAY = " + Calendar.SUNDAY);
            if (startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
                ++workDays;
            }
            startCal.add(Calendar.DAY_OF_MONTH, 1);
        } while (startCal.getTimeInMillis() <= endCal.getTimeInMillis());
            
            System.out.println("workDays = " + workDays);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return workDays;
    }
    public static void main(String args[]) throws ParseException {
        //String date1 = "10/26/2015";
        Calendar cal = Calendar.getInstance();
        String str = ((cal.get(Calendar.MONTH)+1))+"/"+cal.get(Calendar.DATE)+"/"+cal.get(Calendar.YEAR);
        System.out.println("str  >  "+str);

        Date date1 = new Date("2/29/2015");
        Date date2 = new Date("2/29/2015");
        
        if(date1.compareTo(date2)>0){
                System.out.println("Date1 is after Date2");
        }else if(date1.compareTo(date2)<0){
                System.out.println("Date1 is before Date2");
        }else if(date1.compareTo(date2)==0){
                System.out.println("Date1 is equal to Date2");
                cal.add(Calendar.MONTH, 1);
                String next = ((cal.get(Calendar.MONTH))+1)+"/"+cal.getActualMaximum(Calendar.DAY_OF_MONTH)+"/"+cal.get(Calendar.YEAR);
                System.out.println("str  >  "+next);
        
        }else{
                System.out.println("How to get here?");
        }
        
        Date a = new Date();
        Date b = new Date("02/29/2016");
        System.out.println(a.getTime());
        System.out.println(b.getTime()+604800000);
        
        if(a.getTime() > (b.getTime()+604800000)){
            System.out.println("yes");
        }else{
            System.out.println("no");
        }
    }//end main function
}//end class




