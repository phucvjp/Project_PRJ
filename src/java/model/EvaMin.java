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
public class EvaMin implements Serializable {

    int CUSTOMER_ID;
    String CUSTOMER_NAME, EVA_CONTENT;
    double EVA_SCORE;
    Date EVA_TIME;

    public EvaMin(int CUSTOMER_ID, String CUSTOMER_NAME, String EVA_CONTENT, double EVA_SCORE, Date EVA_TIME) {
        this.CUSTOMER_ID = CUSTOMER_ID;
        this.CUSTOMER_NAME = CUSTOMER_NAME;
        this.EVA_CONTENT = EVA_CONTENT;
        this.EVA_SCORE = EVA_SCORE;
        this.EVA_TIME = EVA_TIME;
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

    public String getEVA_CONTENT() {
        return EVA_CONTENT;
    }

    public void setEVA_CONTENT(String EVA_CONTENT) {
        this.EVA_CONTENT = EVA_CONTENT;
    }

    public double getEVA_SCORE() {
        return EVA_SCORE;
    }

    public void setEVA_SCORE(double EVA_SCORE) {
        this.EVA_SCORE = EVA_SCORE;
    }

    public Date getEVA_TIME() {
        return EVA_TIME;
    }

    public void setEVA_TIME(Date EVA_TIME) {
        this.EVA_TIME = EVA_TIME;
    }

    public EvaMin(String CUSTOMER_Name, String EVA_CONTENT, double EVA_SCORE, Date EVA_TIME) {
        this.CUSTOMER_NAME = CUSTOMER_Name;
        this.EVA_CONTENT = EVA_CONTENT;
        this.EVA_SCORE = EVA_SCORE;
        this.EVA_TIME = EVA_TIME;
    }
}
