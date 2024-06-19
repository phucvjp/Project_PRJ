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
public class Product implements Serializable{

    int PRODUCT_ID;
    String PRODUCT_NAME;
    double PRICE;
    int PAGES;
    String SIZE;
    double WEIGHT;
    String DESCRIPTION, LANGUAGE, BOOK_FORMAT;
    int AUTHOR_ID, PUBLISHER_ID, CATEGORY_ID;
    Date PUBLIC_DAY;
    int AMOUNT;
    String image="";

    public Product() {
    }

    public Product(int PRODUCT_ID, String PRODUCT_NAME, double PRICE, int PAGES, String SIZE, double WEIGHT, String DESCRIPTION, String LANGUAGE, String BOOK_FORMAT, int AUTHOR_ID, int PUBLISHER_ID, int CATEGORY_ID, Date PUBLIC_DAY, int AMOUNT, String image) {
        this.PRODUCT_ID = PRODUCT_ID;
        this.PRODUCT_NAME = PRODUCT_NAME;
        this.PRICE = PRICE;
        this.PAGES = PAGES;
        this.SIZE = SIZE;
        this.WEIGHT = WEIGHT;
        this.DESCRIPTION = DESCRIPTION;
        this.LANGUAGE = LANGUAGE;
        this.BOOK_FORMAT = BOOK_FORMAT;
        this.AUTHOR_ID = AUTHOR_ID;
        this.PUBLISHER_ID = PUBLISHER_ID;
        this.CATEGORY_ID = CATEGORY_ID;
        this.PUBLIC_DAY = PUBLIC_DAY;
        this.AMOUNT = AMOUNT;
        this.image = image;
    }

    public int getPRODUCT_ID() {
        return PRODUCT_ID;
    }

    public void setPRODUCT_ID(int PRODUCT_ID) {
        this.PRODUCT_ID = PRODUCT_ID;
    }

    public String getPRODUCT_NAME() {
        return PRODUCT_NAME;
    }

    public void setPRODUCT_NAME(String PRODUCT_NAME) {
        this.PRODUCT_NAME = PRODUCT_NAME;
    }

    public double getPRICE() {
        return PRICE;
    }

    public void setPRICE(double PRICE) {
        this.PRICE = PRICE;
    }

    public int getPAGES() {
        return PAGES;
    }

    public void setPAGES(int PAGES) {
        this.PAGES = PAGES;
    }

    public String getSIZE() {
        return SIZE;
    }

    public void setSIZE(String SIZE) {
        this.SIZE = SIZE;
    }

    public double getWEIGHT() {
        return WEIGHT;
    }

    public void setWEIGHT(double WEIGHT) {
        this.WEIGHT = WEIGHT;
    }

    public String getDESCRIPTION() {
        return DESCRIPTION;
    }

    public void setDESCRIPTION(String DESCRIPTION) {
        this.DESCRIPTION = DESCRIPTION;
    }

    public String getLANGUAGE() {
        return LANGUAGE;
    }

    public void setLANGUAGE(String LANGUAGE) {
        this.LANGUAGE = LANGUAGE;
    }

    public String getBOOK_FORMAT() {
        return BOOK_FORMAT;
    }

    public void setBOOK_FORMAT(String BOOK_FORMAT) {
        this.BOOK_FORMAT = BOOK_FORMAT;
    }

    public int getAUTHOR_ID() {
        return AUTHOR_ID;
    }

    public void setAUTHOR_ID(int AUTHOR_ID) {
        this.AUTHOR_ID = AUTHOR_ID;
    }

    public int getPUBLISHER_ID() {
        return PUBLISHER_ID;
    }

    public void setPUBLISHER_ID(int PUBLISHER_ID) {
        this.PUBLISHER_ID = PUBLISHER_ID;
    }

    public int getCATEGORY_ID() {
        return CATEGORY_ID;
    }

    public void setCATEGORY_ID(int CATEGORY_ID) {
        this.CATEGORY_ID = CATEGORY_ID;
    }


    public Date getPUBLIC_DAY() {
        return PUBLIC_DAY;
    }

    public void setPUBLIC_DAY(Date PUBLIC_DAY) {
        this.PUBLIC_DAY = PUBLIC_DAY;
    }

    public int getAMOUNT() {
        return AMOUNT;
    }

    public void setAMOUNT(int AMOUNT) {
        this.AMOUNT = AMOUNT;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String Image) {
        this.image = Image;
    }

}
