package com.example.toeic.history;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.SearchView;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.app.Activity;
import android.app.SearchManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;

import com.example.toeic.DbHelper;
import com.example.toeic.MainActivity;
import com.example.toeic.R;
import com.example.toeic.favorite.FavoriteActivity;
import com.example.toeic.favorite.FavoriteAdapter;
import com.example.toeic.infoword.InfoActivity;
import com.example.toeic.words.Words;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class HistoryActivity extends AppCompatActivity {

    RecyclerView rvFavorite;
    ArrayList<Words> listWords ;
    HistoryAdapter historyAdapter;
    //Update

    //database
    DbHelper db;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_favorite);
        db = new DbHelper(HistoryActivity.this);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        rvFavorite = findViewById(R.id.rvFavorite);
        listWords = new ArrayList<>();
        historyAdapter = new HistoryAdapter(listWords);
        rvFavorite.setAdapter(historyAdapter);
        initDataForFavorite();
        rvFavorite.setLayoutManager(new LinearLayoutManager(HistoryActivity.this, LinearLayoutManager.VERTICAL, false));
        rvFavorite.addItemDecoration(new DividerItemDecoration(HistoryActivity.this, LinearLayoutManager.VERTICAL));

    }

    private void initDataForFavorite() {
        listWords.clear();
        listWords.addAll(db.getHistory());
        historyAdapter.notifyDataSetChanged();
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.history_menu, menu);
        return true;
    }


    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (item.getItemId() == R.id.mnu_del_all){
            db.deleteAllHistory();
            initDataForFavorite();
        }
        return super.onOptionsItemSelected(item);
    }


    @Override
    public boolean onSupportNavigateUp() {
        Intent intent = new Intent(HistoryActivity.this, MainActivity.class);
        startActivity(intent);
        return super.onSupportNavigateUp();
    }

    @Override
    protected void onResume() {
        super.onResume();
        //listWords.clear();
        initDataForFavorite();
    }

}
