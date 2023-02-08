package anhduy.dmt.doanhduy_bt03;

import android.app.Application;

import java.util.ArrayList;

public class Apps extends Application {
    public static ArrayList<Contacts> data;

    @Override
    public void onCreate() {
        super.onCreate();
        if(data == null){
            data = new ArrayList<>();
        }
    }
    public static ArrayList<Contacts> initDataForContacts(){
        data.add(new Contacts(1,"Zachary", "Moore",R.drawable.moore,"(273)-352-7112","zachary.moore@example.com"));
        data.add(new Contacts(2,"Dominic", "Thunes",R.drawable.thunes,"(067)-453-1128","thunes.moore@example.com"));
        data.add(new Contacts(3,"Apolline", "Renard",R.drawable.renard,"(027)--155-0657","apolline.renard@example.com"));
        data.add(new Contacts(4,"Maria", "Pascual",R.drawable.pascual,"(094)-134-9948","maria.pascual@example.com"));
        data.add(new Contacts(5,"Djordy", "Valkema",R.drawable.valkema,"(167)-351-1900","djordy.valkema@example.com"));
        data.add(new Contacts(6,"Jenny", "Jones",R.drawable.jones,"(015)-242-8092","jenny.jones@example.com"));
        data.add(new Contacts(7,"Ceylan", "Çatalbaş",R.drawable.henry,"(536)-393-6219","aceylan.catalbas@example.com"));
        data.add(new Contacts(8,"Seraina", "Henry",R.drawable.moore,"(077)-673-2231","seraina.henry@example.com"));
        return data;
    }

}
