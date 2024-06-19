/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author TUF A15
 */
public class Order implements Serializable{

    int ORDER_ID, CUSTOMER_ID;
    Date ORDER_DATE;
    double TOTAL_PRICE;
    boolean PAYING=false;

    public Order(int ORDER_ID, int CUSTOMER_ID, Date ORDER_DATE, double TOTAL_PRICE, boolean PAYING) {
        this.ORDER_ID = ORDER_ID;
        this.CUSTOMER_ID = CUSTOMER_ID;
        this.ORDER_DATE = ORDER_DATE;
        this.TOTAL_PRICE = TOTAL_PRICE;
        this.PAYING = PAYING;
    }

    public boolean isPAYING() {
        return PAYING;
    }

    public void setPAYING(boolean PAYING) {
        this.PAYING = PAYING;
    }

    public int getORDER_ID() {
        return ORDER_ID;
    }

    public void setORDER_ID(int ORDER_ID) {
        this.ORDER_ID = ORDER_ID;
    }

    public int getCUSTOMER_ID() {
        return CUSTOMER_ID;
    }

    public void setCUSTOMER_ID(int CUSTOMER_ID) {
        this.CUSTOMER_ID = CUSTOMER_ID;
    }

    public Date getORDER_DATE() {
        return ORDER_DATE;
    }

    public void setORDER_DATE(Date ORDER_DATE) {
        this.ORDER_DATE = ORDER_DATE;
    }

    public double getTOTAL_PRICE() {
        return TOTAL_PRICE;
    }

    public void setTOTAL_PRICE(double TOTAL_PRICE) {
        this.TOTAL_PRICE = TOTAL_PRICE;
    }

    public Order() {
    }

    public Order(int ORDER_ID, int CUSTOMER_ID, Date ORDER_DATE, double TOTAL_PRICE) {
        this.ORDER_ID = ORDER_ID;
        this.CUSTOMER_ID = CUSTOMER_ID;
        this.ORDER_DATE = ORDER_DATE;
        this.TOTAL_PRICE = TOTAL_PRICE;
    }

}
