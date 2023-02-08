package com.example.buichicuong_bt3;

import java.io.Serializable;
import java.util.Date;

public class Phone implements Serializable , Comparable<Phone>{
    int stt;
    String fname,lname, phoneNumber,email;
    int avatar;
    String birthday;

    public Phone(int stt,int avatar, String fname,String lname, String phoneNumber, String email,String birthday) {
        this.stt = stt;
        this.fname = fname;
        this.lname = lname;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.avatar = avatar;
        this.birthday = birthday;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getFullName(){return this.fname + " " + this.lname;}
    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public int getStt() {
        return stt;
    }

    public void setStt(int stt) {
        this.stt = stt;
    }

    public int getAvatar() {
        return avatar;
    }

    public void setAvatar(int avatar) {
        this.avatar = avatar;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public int compareTo(Phone phone) {
        if(fname.compareToIgnoreCase(phone.fname) == 0){
            return lname.compareToIgnoreCase(phone.lname);
        }
        return fname.compareToIgnoreCase(phone.fname);
    }
}
