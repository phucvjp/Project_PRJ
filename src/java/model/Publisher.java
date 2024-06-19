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
public class Publisher implements Serializable{
    int PUBLISHER_ID;
    String PUBLISHER_NAME;

    public Publisher(int PUBLISHER_ID, String PUBLISHER_NAME) {
        this.PUBLISHER_ID = PUBLISHER_ID;
        this.PUBLISHER_NAME = PUBLISHER_NAME;
    }

    public Publisher() {
    }

    public int getPUBLISHER_ID() {
        return PUBLISHER_ID;
    }

    public void setPUBLISHER_ID(int PUBLISHER_ID) {
        this.PUBLISHER_ID = PUBLISHER_ID;
    }

    public String getPUBLISHER_NAME() {
        return PUBLISHER_NAME;
    }

    public void setPUBLISHER_NAME(String PUBLISHER_NAME) {
        this.PUBLISHER_NAME = PUBLISHER_NAME;
    }
    
}
