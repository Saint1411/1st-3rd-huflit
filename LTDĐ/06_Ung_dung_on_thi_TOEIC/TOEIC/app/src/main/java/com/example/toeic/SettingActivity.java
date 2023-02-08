package com.example.toeic;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.transition.Slide;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.example.toeic.slide.SlideActivity;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

public class SettingActivity extends AppCompatActivity {
    Spinner spinner;
    String fontsize;
    String filename = "settings";
    //
    TextView tvSetting, tvLabel;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_setting);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        SharedPreferences sharedPreferences = getSharedPreferences(filename, Context.MODE_PRIVATE);
        fontsize = sharedPreferences.getString("fontsize", null);

        tvSetting = findViewById(R.id.textView7);
        tvLabel = findViewById(R.id.textView8);
        spinner = findViewById(R.id.spinner);
        if(fontsize != null){
            tvLabel.setTextSize(Float.parseFloat(fontsize));
            tvSetting.setTextSize(Float.parseFloat(fontsize));
        }
        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
                fontsize = getFontSize(i);
            }

            @Override
            public void onNothingSelected(AdapterView<?> adapterView) {

            }
        });
    }
    String getFontSize(int i){
        String[] font = getResources().getStringArray(R.array.settings);
        return font[i].split("sp")[0];
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.settings_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (R.id.mnu_saveSetting == item.getItemId()){
            SavaSetting();
        }
        return super.onOptionsItemSelected(item);
    }
    private void SavaSetting(){
        SharedPreferences sharedPreferences = getSharedPreferences(filename, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString("fontsize",fontsize);
        editor.commit();
        AlertDialog.Builder builder = new AlertDialog.Builder(SettingActivity.this);
        builder.setMessage("Your settings are saved !!!");
        builder.setPositiveButton("OK",new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
                Intent intent = new Intent(SettingActivity.this,MainActivity.class);
                startActivity(intent);
            }
        });
        builder.show();
    }
    @Override
    public boolean onSupportNavigateUp() {
        //onBackPressed();
        Intent intent = new Intent(SettingActivity.this, SlideActivity.class);
        startActivity(intent);
        return super.onSupportNavigateUp();
    }
    @Override
    protected void onResume() {
        super.onResume();
        SharedPreferences sharedPreferences = getSharedPreferences(filename, Context.MODE_PRIVATE);
        String fontsize = sharedPreferences.getString("fontsize", null);
        if(fontsize != null){
            tvLabel.setTextSize(Float.parseFloat(fontsize));
            tvSetting.setTextSize(Float.parseFloat(fontsize));
        }
    }
}