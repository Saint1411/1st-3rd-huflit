package com.example.toeic.infoword;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.result.ActivityResultLauncher;
import androidx.appcompat.app.AppCompatActivity;


import com.example.toeic.DbHelper;
import com.example.toeic.MainActivity;
import com.example.toeic.R;
import com.example.toeic.favorite.FavoriteActivity;
import com.example.toeic.vocabulary.Vocabulary;
import com.example.toeic.words.Words;


public class InfoActivity extends AppCompatActivity {
    Words words;
    ImageView imgWord4, imgHeart4;
    TextView tvWord4;
    TextView tvPhonetic4;
    TextView tvType4;
    TextView tvDes4;
    Vocabulary vocabulary;
    //database
    DbHelper db;




    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_info);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        db = new DbHelper(InfoActivity.this);
        tvWord4=findViewById(R.id.tvWord4);
        tvPhonetic4=findViewById(R.id.tvPhonetic4);
        tvType4=findViewById(R.id.tvType4);
        imgWord4 = findViewById(R.id.imgWord4);
        imgHeart4=findViewById(R.id.imgHeart4);
        tvDes4 = findViewById(R.id.tvDes4);
        Intent intent= getIntent();
        words= (Words) intent.getSerializableExtra("Info");
        imgWord4.setImageBitmap(BitmapFactory.decodeByteArray(words.getImgWord(),0,words.getImgWord().length));
        tvDes4.setText(words.getDescription());
        tvWord4.setText(words.getWord());
        tvPhonetic4.setText(words.getPhonetic());
        tvType4.setText(words.getTypeWord());
        if (words.getFavorite() != 1) {
            imgHeart4.setImageResource(R.drawable.ic_baseline_favorite_border_24);
        } else {
            imgHeart4.setImageResource(R.drawable.ic_baseline_favorite_24);
        }
        imgHeart4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (words.getFavorite() == 1){
                    words.setFavorite(0);
                    Unlike(words);

                } else {
                    words.setFavorite(1);
                    Like(words);

                }
            }
        });
    }
    private void Unlike(Words words) {
        imgHeart4.setImageResource(R.drawable.ic_baseline_favorite_border_24);
        //imgHeart4.se
        Toast.makeText(InfoActivity.this,"Removed",Toast.LENGTH_SHORT).show();
        db.Unlike(words);
    }
    private void Like(Words words) {
        imgHeart4.setImageResource(R.drawable.ic_baseline_favorite_24);
        Toast.makeText(InfoActivity.this,"Added to favorite",Toast.LENGTH_SHORT).show();
        db.Like(words);
    }
    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed();
        return super.onSupportNavigateUp();
    }
    
}