package com.example.toeic;

import android.app.SearchManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.SearchView;
import androidx.appcompat.widget.Toolbar;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTransaction;

import com.example.toeic.favorite.FavoriteActivity;
import com.example.toeic.history.HistoryActivity;
import com.example.toeic.slide.SlideActivity;
import com.example.toeic.vocabulary.VocabularyFragment;
import com.google.android.material.navigation.NavigationView;

import java.io.File;
import java.io.Serializable;
import java.util.Set;

public class MainActivity extends AppCompatActivity implements Serializable {
    DrawerLayout drawerLayout;
    Toolbar toolbar;
    NavigationView nav;
    ActionBarDrawerToggle actionBarDrawerToggle; //nut 3 gạch điền khiển nav
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar); // gan toolbar vào vị trí của action bar
        drawerLayout = findViewById(R.id.drawer);
        actionBarDrawerToggle = new ActionBarDrawerToggle(MainActivity.this,drawerLayout,toolbar,R.string.open,
                R.string.close);
        drawerLayout.setDrawerListener(actionBarDrawerToggle);
        nav = findViewById(R.id.nav);

        nav.setNavigationItemSelectedListener(new NavigationView.OnNavigationItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {
                display(item.getItemId());
                return false;
            }
        });
        display(R.id.mnuVocab);
    }

    private void display(int itemId) {
        Fragment fragment = null;
        switch (itemId){
            case R.id.mnuVocab:
                fragment = new VocabularyFragment();
                FragmentTransaction ft = getSupportFragmentManager().beginTransaction(); // lap day ko gian cua frame layout
                ft.replace(R.id.content, fragment);
                ft.commit();
                drawerLayout.closeDrawers();
                break;
            case R.id.mnuFavorite:
                Intent intent = new Intent(MainActivity.this, FavoriteActivity.class);
                startActivity(intent);
                break;
            case R.id.mnuSetting:
                Intent intent1 = new Intent(MainActivity.this, SettingActivity.class);
                startActivity(intent1);
                break;
            case R.id.mnuMiniTest:
                Intent intent2 = new Intent(MainActivity.this, SlideActivity.class);
                startActivity(intent2);
                break;
            case R.id.mnuInfo:
                fragment = new InfoFragment();
                FragmentTransaction ft1 = getSupportFragmentManager().beginTransaction(); // lap day ko gian cua frame layout
                ft1.replace(R.id.content, fragment);
                ft1.commit();
                drawerLayout.closeDrawers();
                break;
            case R.id.mnuHistory:
                Intent intent3 = new Intent(MainActivity.this, HistoryActivity.class);
                startActivity(intent3);
                break;
        }
//        FragmentTransaction ft = getSupportFragmentManager().beginTransaction(); // lap day ko gian cua frame layout
//        ft.replace(R.id.content, fragment);
//        ft.commit();
//        drawerLayout.closeDrawers();
    }

    @Override
    protected void onPostCreate(@Nullable Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        actionBarDrawerToggle.syncState();
    }

}