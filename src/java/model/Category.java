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
public class Category implements Serializable {
    int CATEGORY_ID;
    String CATEGORY_NAME;

    public Category() {
    }

    public Category(int CATEGORY_ID, String CATEGORY_NAME) {
        this.CATEGORY_ID = CATEGORY_ID;
        this.CATEGORY_NAME = CATEGORY_NAME;
    }

    public int getCATEGORY_ID() {
        return CATEGORY_ID;
    }

    public void setCATEGORY_ID(int CATEGORY_ID) {
        this.CATEGORY_ID = CATEGORY_ID;
    }

    public String getCATEGORY_NAME() {
        return CATEGORY_NAME;
    }

    public void setCATEGORY_NAME(String CATEGORY_NAME) {
        this.CATEGORY_NAME = CATEGORY_NAME;
    }
    
}
