/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;

/**
 *
 * @author TUF A15
 */
public class OrderDetail implements Serializable{
    int ORDER_ID,PRODUCT_ID;
    double PRICE;
    int AMOUNT;
    boolean EVALUATED;

    public OrderDetail() {
    }

    public OrderDetail(int ORDER_ID, int PRODUCT_ID, double PRICE, int AMOUNT, boolean evaluated) {
        this.ORDER_ID = ORDER_ID;
        this.PRODUCT_ID = PRODUCT_ID;
        this.PRICE = PRICE;
        this.AMOUNT = AMOUNT;
        this.EVALUATED = evaluated;
    }

    public boolean isEVALUATED() {
        return EVALUATED;
    }

    public void setEVALUATED(boolean evaluated) {
        this.EVALUATED = evaluated;
    }

    public int getORDER_ID() {
        return ORDER_ID;
    }

    public void setORDER_ID(int ORDER_ID) {
        this.ORDER_ID = ORDER_ID;
    }

    public int getPRODUCT_ID() {
        return PRODUCT_ID;
    }

    public void setPRODUCT_ID(int PRODUCT_ID) {
        this.PRODUCT_ID = PRODUCT_ID;
    }

    public double getPRICE() {
        return PRICE;
    }

    public void setPRICE(double PRICE) {
        this.PRICE = PRICE;
    }

    public int getAMOUNT() {
        return AMOUNT;
    }

    public void setAMOUNT(int AMOUNT) {
        this.AMOUNT = AMOUNT;
    }

}
