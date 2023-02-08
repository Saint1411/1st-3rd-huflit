package com.example.toeic.favorite;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.SearchView;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

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
import com.example.toeic.infoword.InfoActivity;
import com.example.toeic.vocabulary.Vocabulary;
import com.example.toeic.vocabulary.VocabularyAdapter;
import com.example.toeic.words.Words;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class FavoriteActivity extends AppCompatActivity implements FavoriteAdapter.Listener {

    RecyclerView rvFavorite;
    ArrayList<Words> favorites ;
    FavoriteAdapter favoriteAdapter;
    //Update
    private SearchView searchView;
    int pos;
    //database
    DbHelper db;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_favorite);
        db = new DbHelper(FavoriteActivity.this);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        rvFavorite = findViewById(R.id.rvFavorite);
        favorites = new ArrayList<>();
        favoriteAdapter = new FavoriteAdapter(favorites,FavoriteActivity.this);
        rvFavorite.setAdapter(favoriteAdapter);
        initDataForFavorite();
        rvFavorite.setLayoutManager(new LinearLayoutManager(FavoriteActivity.this, LinearLayoutManager.VERTICAL, false));
        rvFavorite.addItemDecoration(new DividerItemDecoration(FavoriteActivity.this, LinearLayoutManager.VERTICAL));

    }

    private void initDataForFavorite() {
        favorites.addAll(db.getFavorite());
        favoriteAdapter.notifyDataSetChanged();
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.fragment_menu, menu);

        SearchManager searchManager = (SearchManager) getSystemService(Context.SEARCH_SERVICE);
        searchView = (SearchView) menu.findItem(R.id.action_search).getActionView();
        searchView.setSearchableInfo(searchManager.getSearchableInfo(getComponentName()));
        searchView.setMaxWidth(Integer.MAX_VALUE);
        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                favoriteAdapter.getFilter().filter(query);
                return false;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                favoriteAdapter.getFilter().filter(newText);
                return false;
            }
        });
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if(item.getItemId() == R.id.action_sort){
            SortWord(favorites);
            favoriteAdapter.notifyDataSetChanged();
        } else if(item.getItemId() == R.id.action_delete){
            db.UnlikeAll();
            favorites.clear();
            favoriteAdapter.notifyDataSetChanged();
        }
        return super.onOptionsItemSelected(item);
    }

    public void SortWord(ArrayList<Words> favorites){
        Collections.sort(favorites, new Comparator<Words>() {
            @Override
            public int compare(Words t1, Words t2) {
                String word1=t1.getWord();
                String word2=t2.getWord();
                int compareWord=word1.compareTo(word2);
                return compareWord;
            }
        });
    }
    @Override
    public boolean onSupportNavigateUp() {
        Intent intent = new Intent(FavoriteActivity.this, MainActivity.class);
        startActivity(intent);
        return super.onSupportNavigateUp();
    }

    @Override
    protected void onResume() {
        super.onResume();
        favorites.clear();
        initDataForFavorite();
    }

    @Override
    public void onClickListener(Words words) {
        Intent intent = new Intent(FavoriteActivity.this, InfoActivity.class);
        intent.putExtra("Info", words);
        startActivity(intent);
    }
}
