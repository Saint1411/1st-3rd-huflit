package anhduy.dmt.contracts;

import android.app.Application;

import java.util.ArrayList;

public class App extends Application {
    public static ArrayList<Vocabulary> data;

    @Override
    public void onCreate() {
        super.onCreate();
        if(data == null){
            data = new ArrayList<>();
        }
    }
    public static ArrayList<Vocabulary> initDataForVocabulary(){
        data.add(new Vocabulary(1,R.drawable.germany,"Germany", "/ˈʤɜːməni/","noun", "Description: Since I have known you, I have never felt sorry for anything I have done for you"));
        data.add(new Vocabulary(2,R.drawable.estonia,"Estonia", "/ɛsˈtəʊnɪə/","noun","Description: Since I have known you, I have never felt sorry for anything I have done for you. "));
        data.add(new Vocabulary(3,R.drawable.france,"France", "/ˈfrɑːns/","noun", "Description: Since I have known you, I have never felt sorry for anything I have done for you. "));
        data.add(new Vocabulary(4,R.drawable.ireland,"Ireland", "/ˈaiələnd/","noun", "Description: Since I have known you, I have never felt sorry for anything I have done for you. "));
        data.add(new Vocabulary(5,R.drawable.italy,"Italy", "/ˈItəli/","noun","Description: Since I have known you, I have never felt sorry for anything I have done for you. "));
        data.add(new Vocabulary(6,R.drawable.monaco,"Monaco", "/ˈmɒnəkəʊ/","noun", "Description: Since I have known you, I have never felt sorry for anything I have done for you. "));
        data.add(new Vocabulary(7,R.drawable.nigeria,"Nigeria", "/naɪˈʤɪərɪə/","noun", "Description: Since I have known you, I have never felt sorry for anything I have done for you. "));
        data.add(new Vocabulary(8,R.drawable.russia,"Russia", "/ˈrʌʃə/","noun", "Description: Since I have known you, I have never felt sorry for anything I have done for you. "));
        data.add(new Vocabulary(9,R.drawable.poland,"Poland", "/ˈpəʊlənd/","noun","Description: Since I have known you, I have never felt sorry for anything I have done for you. "));

        return data;
    }
}
