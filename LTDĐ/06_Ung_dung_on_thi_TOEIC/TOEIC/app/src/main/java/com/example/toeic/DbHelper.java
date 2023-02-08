package com.example.toeic;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import com.example.toeic.slide.Question;
import com.example.toeic.vocabulary.Vocabulary;
import com.example.toeic.words.Words;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

public class DbHelper {
    static String DB_NAME = "DBToeic.db";
    Context context;
    public  DbHelper (Context context){
        this.context = context;

    }
    public SQLiteDatabase openDB(){
//        File dbFile = context.getDatabasePath(DB_NAME);
//        if(!dbFile.exists()){
//            try{
//                copyDatabase(dbFile);
//            }catch (IOException e){
//                throw new RuntimeException("Error creating source database",e);
//            }
//        }
//        return SQLiteDatabase.openDatabase(dbFile.getPath(),null,SQLiteDatabase.OPEN_READWRITE);
        return context.openOrCreateDatabase(DB_NAME,Context.MODE_PRIVATE,null);
    }

    public void copyDatabase(){
        File dbFile = context.getDatabasePath(DB_NAME);
        if(!dbFile.exists()){
            try {
                InputStream is = context.getAssets().open(DB_NAME);
                OutputStream os = new FileOutputStream(dbFile);
                byte[] buffer = new byte[1024];
                while(is.read(buffer) > 0){
                    os.write(buffer);
                }

                os.flush();
                os.close();
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }
    void closeDB(SQLiteDatabase db){
        db.close();
    }

    public ArrayList<Vocabulary> getAllVocabulary(){
        ArrayList<Vocabulary> tmp = new ArrayList<>();
        SQLiteDatabase db = openDB();
        String sql = "SELECT * FROM TOPIC";
        Cursor cursor = db.rawQuery(sql,null);
        while(cursor.moveToNext()){
            int idTopic = cursor.getInt(0);
            String topicName = cursor.getString(1);
            String numOfWords = cursor.getString(2);
            byte[] byteArray = cursor.getBlob(3);
            //Bitmap bm = BitmapFactory.decodeByteArray(byteArray,0,byteArray.length);
            tmp.add(new Vocabulary(byteArray, topicName, numOfWords, idTopic));
        }
        closeDB(db);
        return tmp;
    }
    public ArrayList<Question> getRandomQuestion(){
        ArrayList<Question> tmp = new ArrayList<>();
        SQLiteDatabase db = openDB();
        String sql = "SELECT * " +
                "FROM question " +
                "ORDER BY RANDOM() " +
                "LIMIT 10 ";
        Cursor cursor = db.rawQuery(sql,null);
        while(cursor.moveToNext()){
            int stt = cursor.getInt(0);
            String question = cursor.getString(1);
            String ans1 = cursor.getString(2);
            String ans2 = cursor.getString(3);
            String ans3 = cursor.getString(4);
            String ans4 = cursor.getString(5);
            String result = cursor.getString(6);
            tmp.add(new Question(stt, question, ans1, ans2 , ans3, ans4, result,""));
        }
        closeDB(db);
        return tmp;
    }
    public ArrayList<Words> getAllWords(int topicNumber){
        ArrayList<Words> tmp = new ArrayList<>();
        SQLiteDatabase db = openDB();
        String sql = "SELECT * " +
                "FROM WORDS " +
                "WHERE topic =  "+ topicNumber;
        Cursor cursor = db.rawQuery(sql,null);
        while(cursor.moveToNext()){
            int stt = cursor.getInt(0);
            String words = cursor.getString(1);
            String phonestic = cursor.getString(2);
            String type = cursor.getString(3);
            String des = cursor.getString(4);
            byte[] byteArray = cursor.getBlob(5);
            int topic = cursor.getInt(6);
            int favorite = cursor.getInt(7);
            int history = cursor.getInt(8);
//            tmp.add(new Words(stt,bm,topic,words,phonestic,type,favorite,history));
            tmp.add(new Words(stt,topic,words,phonestic,type,favorite,history,byteArray,des));
        }
        closeDB(db);
        return tmp;
    }
    public ArrayList<Words> getFavorite(){
        ArrayList<Words> tmp = new ArrayList<>();
        SQLiteDatabase db = openDB();
        String sql = "SELECT * " +
                "FROM WORDS " +
                "WHERE favorite = 1 ";
        Cursor cursor = db.rawQuery(sql,null);
        while(cursor.moveToNext()){
            int stt = cursor.getInt(0);
            String words = cursor.getString(1);
            String phonestic = cursor.getString(2);
            String type = cursor.getString(3);
            String des = cursor.getString(4);
            byte[] byteArray = cursor.getBlob(5);
            int topic = cursor.getInt(6);
            int favorite = cursor.getInt(7);
            int history = cursor.getInt(8);
//            tmp.add(new Words(stt,bm,topic,words,phonestic,type,favorite,history));
            tmp.add(new Words(stt,topic,words,phonestic,type,favorite,history,byteArray,des));
        }
        closeDB(db);
        return tmp;
    }
    public void Like(Words words){
        SQLiteDatabase db = openDB();
        ContentValues cv = new ContentValues();
        cv.put("favorite", 1);
        db.update("WORDS",cv,"idWords= "+words.id,null);
        closeDB(db);
    }
    public void Unlike(Words words){
        SQLiteDatabase db = openDB();
        ContentValues cv = new ContentValues();
        cv.put("favorite", 0);
        db.update("WORDS",cv,"idWords= "+words.id,null);
        closeDB(db);
    }
    public void UnlikeAll(){
        SQLiteDatabase db = openDB();
        ContentValues cv = new ContentValues();
        cv.put("favorite", 0);
        db.update("WORDS",cv,null,null);
        closeDB(db);
    }
    public void Addhistory(Words words){
        SQLiteDatabase db = openDB();
        ContentValues cv = new ContentValues();
        cv.put("history", 1);
        db.update("WORDS",cv,"idWords= "+words.id,null);
        closeDB(db);
    }
    public ArrayList<Words> getHistory(){
        ArrayList<Words> tmp = new ArrayList<>();
        SQLiteDatabase db = openDB();
        String sql = "SELECT * " +
                "FROM WORDS " +
                "WHERE history = 1 ";
        Cursor cursor = db.rawQuery(sql,null);
        while(cursor.moveToNext()){
            int stt = cursor.getInt(0);
            String words = cursor.getString(1);
            String phonestic = cursor.getString(2);
            String type = cursor.getString(3);
            String des = cursor.getString(4);
            byte[] byteArray = cursor.getBlob(5);
            int topic = cursor.getInt(6);
            int favorite = cursor.getInt(7);
            int history = cursor.getInt(8);
//            tmp.add(new Words(stt,bm,topic,words,phonestic,type,favorite,history));
            tmp.add(new Words(stt,topic,words,phonestic,type,favorite,history,byteArray,des));
        }
        closeDB(db);
        return tmp;
    }
    public void deleteAllHistory(){
        SQLiteDatabase db = openDB();
        ContentValues cv = new ContentValues();
        cv.put("history", 0);
        db.update("WORDS",cv,null,null);
        closeDB(db);
    }
}
