package com.example.buichicuong_bt3;

import android.app.Application;

import java.util.ArrayList;

public class App extends Application {
    public static ArrayList<Phone> data;

    @Override
    public void onCreate() {
        super.onCreate();
        if(data == null){
            data = new ArrayList<>();
        }
        data = initDataForPhoneNumber();
    }

    public static ArrayList<Phone> initDataForPhoneNumber(){
        ArrayList<Phone> tmp = new ArrayList<>();
        tmp.add(new Phone(1,R.drawable.moore,"Zachary","Moore","(273)-352-7112","zachary.moore@example.com","01/01/1990"));
        tmp.add(new Phone(2,R.drawable.thunes,"Dominic"," Thunes","(067)-453-1128","dominic.thunes@example.com","01/01/1990"));
        tmp.add(new Phone(3,R.drawable.renard,"Apolline ","Renard","(027)-155-0657","apolline.renard@example.com","01/01/1990"));
        tmp.add(new Phone(4,R.drawable.pascual,"Maria ","Pascual","(094)-134-9948","maria.pascual@example.com","01/01/1990"));
        tmp.add(new Phone(5,R.drawable.valkema,"Djordy ","Valkema", "(167)-351-1900","djordy.valkema@example.com","01/01/1990"));
        tmp.add(new Phone(6,R.drawable.jones,"Jenny ","Jones","(015)-242-8092","jenny.jones@example.com","01/01/1990"));
        tmp.add(new Phone(7,R.drawable.catalbas,"Ceylan ","Çatalbaş","(036)-393-6219","ceylan.catalbas@example.com","01/01/1990"));
        tmp.add(new Phone(8,R.drawable.henry,"Seraina ","Henry","(077)-673-2231","seraina.henry@example.com","01/01/1990"));
        return tmp;
    }
}
