package com.example.toeic.introduce;

import android.content.Context;

public class SharedPreferences {
    private static final String SHARED_PREFERENCES= "SHARED_PREFERENCES";
    private Context context;

    public SharedPreferences(Context context) {
        this.context = context;
    }

    public void putBoolenValue(String key, Boolean value){
        android.content.SharedPreferences sharedPreferences = context.getSharedPreferences(SHARED_PREFERENCES,0);
        android.content.SharedPreferences.Editor editor=sharedPreferences.edit();
        editor.putBoolean(key,value);
        editor.apply();
    }

    public boolean getBoolenValue(String key){
        android.content.SharedPreferences sharedPreferences = context.getSharedPreferences(SHARED_PREFERENCES,0);
        return sharedPreferences.getBoolean(key,false);
    }
}
