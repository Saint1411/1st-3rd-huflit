package com.example.toeic;

import android.app.Application;

import com.example.toeic.slide.Question;

import java.io.File;
import java.util.ArrayList;

public class App extends Application {
    //public static ArrayList<Question> listQuestion;
    DbHelper db;

    @Override
    public void onCreate() {
        super.onCreate();
        db = new DbHelper(this);
//        File dbFile = getDatabasePath("DBToeic.db");
//        if(!dbFile.exists()){
//            db.openDB();
//            db.copyDatabase(dbFile);
//        }
        db.copyDatabase();
    }
}
