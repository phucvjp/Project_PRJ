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
public class TopBuyer implements Serializable{

    int CUSTOMER_ID;
    String CUSTOMER_NAME;
    double TOTAL;

    public TopBuyer(int CUSTOMER_ID, String CUSTOMER_NAME, double TOTAL) {
        this.CUSTOMER_ID = CUSTOMER_ID;
        this.CUSTOMER_NAME = CUSTOMER_NAME;
        this.TOTAL = TOTAL;
    }

    public TopBuyer() {
    }

    public int getCUSTOMER_ID() {
        return CUSTOMER_ID;
    }

    public void setCUSTOMER_ID(int CUSTOMER_ID) {
        this.CUSTOMER_ID = CUSTOMER_ID;
    }

    public String getCUSTOMER_NAME() {
        return CUSTOMER_NAME;
    }

    public void setCUSTOMER_NAME(String CUSTOMER_NAME) {
        this.CUSTOMER_NAME = CUSTOMER_NAME;
    }

    public double getTOTAL() {
        return TOTAL;
    }

    public void setTOTAL(double TOTAL) {
        this.TOTAL = TOTAL;
    }

}
