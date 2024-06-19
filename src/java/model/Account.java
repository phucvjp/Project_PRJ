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
public class Account implements Serializable{

    int CUSTOMER_ID;
    String CUSTOMER_NAME, PHONE, ADDRESS;
    Date BIRTHDAY;
    String EMAIL, SEX, Password;
    int role;
    String cart,fav;

    public Account(int CUSTOMER_ID, String CUSTOMER_NAME, String PHONE, String ADDRESS, Date BIRTHDAY, String EMAIL, String SEX, String Password, int role, String cart, String fav) {
        this.CUSTOMER_ID = CUSTOMER_ID;
        this.CUSTOMER_NAME = CUSTOMER_NAME;
        this.PHONE = PHONE;
        this.ADDRESS = ADDRESS;
        this.BIRTHDAY = BIRTHDAY;
        this.EMAIL = EMAIL;
        this.SEX = SEX;
        this.Password = Password;
        this.role = role;
        this.cart = cart;
        this.fav = fav;
    }

    public Account() {
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

    public String getPHONE() {
        return PHONE;
    }

    public void setPHONE(String PHONE) {
        this.PHONE = PHONE;
    }

    public String getADDRESS() {
        return ADDRESS;
    }

    public void setADDRESS(String ADDRESS) {
        this.ADDRESS = ADDRESS;
    }

    public Date getBIRTHDAY() {
        return BIRTHDAY;
    }

    public void setBIRTHDAY(Date BIRTHDAY) {
        this.BIRTHDAY = BIRTHDAY;
    }

    public String getEMAIL() {
        return EMAIL;
    }

    public void setEMAIL(String EMAIL) {
        this.EMAIL = EMAIL;
    }

    public String getSEX() {
        return SEX;
    }

    public void setSEX(String SEX) {
        this.SEX = SEX;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getCart() {
        return cart;
    }

    public void setCart(String cart) {
        this.cart = cart;
    }

    public String getFav() {
        return fav;
    }

    public void setFav(String fav) {
        this.fav = fav;
    }

        
    public Account(int CUSTOMER_ID, String CUSTOMER_NAME, String PHONE, String ADDRESS, Date BIRTHDAY, String EMAIL, String SEX, String Password, int role, String cart) {
        this.CUSTOMER_ID = CUSTOMER_ID;
        this.CUSTOMER_NAME = CUSTOMER_NAME;
        this.PHONE = PHONE;
        this.ADDRESS = ADDRESS;
        this.BIRTHDAY = BIRTHDAY;
        this.EMAIL = EMAIL;
        this.SEX = SEX;
        this.Password = Password;
        this.role = role;
        this.cart = cart;
    }
    

}
