package com.example.toeic.slide;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.viewpager2.widget.ViewPager2;

import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ListAdapter;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.example.toeic.App;
import com.example.toeic.DbHelper;
import com.example.toeic.MainActivity;
import com.example.toeic.R;
import com.example.toeic.favorite.FavoriteActivity;
import com.example.toeic.result.CheckAgainAdapter;
import com.example.toeic.result.ResultActivity;
import com.google.android.material.button.MaterialButton;

import org.w3c.dom.Text;

import java.util.ArrayList;

public class SlideActivity extends AppCompatActivity {
    ViewPager2 viewPager2;
    SlideAdapter slideAdapter;
    ArrayList<Question> listQuestion = new ArrayList<>();

    ArrayList<Question> listBaiLam;

    MaterialButton btn_prev,btn_next;
    //
    RecyclerView recyclerView;
    Button btnclose,btnfinish;
    Menu myMenu;
    // settings
    String filename = "settings";
    //database
    DbHelper db = new DbHelper(SlideActivity.this);
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_slide);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        viewPager2 = findViewById(R.id.viewpager);
        //button
        btn_prev = findViewById(R.id.btn_prev);
        btn_next = findViewById(R.id.btn_next);
        //
        //listQuestion = App.listQuestion;

        listQuestion = db.getRandomQuestion();

        initData();

        SlideAdapter slide = new SlideAdapter(SlideActivity.this,listBaiLam);
        viewPager2.setAdapter(slide);
        viewPager2.setOffscreenPageLimit(10);
        //swipe event
        viewPager2.registerOnPageChangeCallback(new ViewPager2.OnPageChangeCallback() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
                if(viewPager2.getCurrentItem() == 0) {
                    btn_prev.setVisibility(View.INVISIBLE);
                }
                else if(viewPager2.getCurrentItem() + 1 == listQuestion.size()){
                    btn_next.setVisibility(View.INVISIBLE);
                }
                else {
                    btn_prev.setVisibility(View.VISIBLE);
                    btn_next.setVisibility(View.VISIBLE);
                }
                super.onPageScrolled(position, positionOffset, positionOffsetPixels);
            }
            /*@Override
            public void onPageSelected(int position) {
                super.onPageSelected(position);
            }

            @Override
            public void onPageScrollStateChanged(int state) {
                super.onPageScrollStateChanged(state);
            } */
        });
        //onClick swipe event
        btn_next.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                viewPager2.setCurrentItem(viewPager2.getCurrentItem()+1);
            }
        });
        btn_prev.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                viewPager2.setCurrentItem(viewPager2.getCurrentItem()-1);
            }
        });
    }
    void initData(){
     listBaiLam = new ArrayList<>();
     listBaiLam.clear();
     listBaiLam = listQuestion;
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.submit_menu, menu);
        myMenu = menu;

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()) {
            case R.id.mnuSubmit:
                checkAnswer();
                break;
        }
        return super.onOptionsItemSelected(item);
    }
    private void checkAnswer(){
        Dialog dialog = new Dialog(SlideActivity.this);
        dialog.setContentView(R.layout.check_answer_dialog);
        CheckAnswerAdapter answerAdapter = new CheckAnswerAdapter(listBaiLam/*listQuestion*/,SlideActivity.this);
        dialog.setTitle("YOUR ANSWERS :");
        recyclerView = dialog.findViewById(R.id.gvListAnswers);
        //GridLayoutManager grm = new GridLayoutManager(SlideActivity.this,3);
        recyclerView.setAdapter(answerAdapter);
        recyclerView.setLayoutManager(new GridLayoutManager(SlideActivity.this,2));
        //recyclerView.setAdapter(answerAdapter);
        //recyclerView.setLayoutManager(new LinearLayoutManager(SlideActivity.this,LinearLayoutManager.VERTICAL,false));
        dialog.show();
        btnclose = dialog.findViewById(R.id.btn_Cancel);
        btnfinish = dialog.findViewById(R.id.btn_Finish);
        btnclose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });
        btnfinish.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(SlideActivity.this, ResultActivity.class);
                intent.putExtra("listQuestion", listBaiLam/*listQuestion*/);
                startActivity(intent);
                finish();
            }
        });
    }
    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed();
        return super.onSupportNavigateUp();
    }

}