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
public class Author implements Serializable {
    int AUTHOR_ID;
    String AUTHOR_NAME;

    public Author() {
    }

    public int getAUTHOR_ID() {
        return AUTHOR_ID;
    }

    public void setAUTHOR_ID(int AUTHOR_ID) {
        this.AUTHOR_ID = AUTHOR_ID;
    }

    public String getAUTHOR_NAME() {
        return AUTHOR_NAME;
    }

    public void setAUTHOR_NAME(String AUTHOR_NAME) {
        this.AUTHOR_NAME = AUTHOR_NAME;
    }

    public Author(int AUTHOR_ID, String AUTHOR_NAME) {
        this.AUTHOR_ID = AUTHOR_ID;
        this.AUTHOR_NAME = AUTHOR_NAME;
    }
    
}
