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
public class Evaluation  implements Serializable{
    int CUSTOMER_ID,PRODUCT_ID;
    String EVA_CONTENT;
    double EVA_SCORE;
    Date EVA_TIME;

    public Evaluation() {
    }

    public Evaluation(int CUSTOMER_ID, int PRODUCT_ID, String EVA_CONTENT, double EVA_SCORE, Date EVA_TIME) {
        this.CUSTOMER_ID = CUSTOMER_ID;
        this.PRODUCT_ID = PRODUCT_ID;
        this.EVA_CONTENT = EVA_CONTENT;
        this.EVA_SCORE = EVA_SCORE;
        this.EVA_TIME = EVA_TIME;
    }

    public void setCUSTOMER_ID(int CUSTOMER_ID) {
        this.CUSTOMER_ID = CUSTOMER_ID;
    }

    public void setPRODUCT_ID(int PRODUCT_ID) {
        this.PRODUCT_ID = PRODUCT_ID;
    }

    public void setEVA_CONTENT(String EVA_CONTENT) {
        this.EVA_CONTENT = EVA_CONTENT;
    }

    public void setEVA_SCORE(double EVA_SCORE) {
        this.EVA_SCORE = EVA_SCORE;
    }

    public void setEVA_TIME(Date EVA_TIME) {
        this.EVA_TIME = EVA_TIME;
    }
    

}
