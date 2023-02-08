package com.example.toeic.result;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.example.toeic.MainActivity;
import com.example.toeic.R;
import com.example.toeic.slide.CheckAnswerAdapter;
import com.example.toeic.slide.Question;
import com.example.toeic.slide.SlideActivity;

import java.util.ArrayList;

public class ResultActivity extends AppCompatActivity {
    ArrayList<Question> listQuestionBegin = new ArrayList<>();
    int right_ans = 0, wrong_ans = 0, no_ans = 0, total_score = 0;
    TextView tvRight,tvWrong,tvNotDone,tvTotal, tvHead;
    Button btn_checkAgain;
    RecyclerView recyclerView;
    Button btnclose,btnfinish;
    //
    String filename = "settings";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_result);
        SharedPreferences sharedPreferences;
        sharedPreferences = getSharedPreferences(filename, Context.MODE_PRIVATE);
        String fontsize = sharedPreferences.getString("fontsize", null);
        tvHead = findViewById(R.id.textView);
        tvRight = findViewById(R.id.tvRightAnswer);
        tvWrong = findViewById(R.id.tvWrongAnswer);
        tvNotDone = findViewById(R.id.tvNotDone);
        tvTotal = findViewById(R.id.tvTotalScore);
        if(fontsize != null){
            tvHead.setTextSize(Float.parseFloat(fontsize));
            tvRight.setTextSize(Float.parseFloat(fontsize));
            tvWrong.setTextSize(Float.parseFloat(fontsize));
            tvNotDone.setTextSize(Float.parseFloat(fontsize));
            tvTotal.setTextSize(Float.parseFloat(fontsize));
        }
        Intent intent = getIntent();
        listQuestionBegin = (ArrayList<Question>) intent.getExtras().getSerializable("listQuestion");
        checkKetQua();
        tvRight.setText("".concat(String.valueOf(right_ans)));
        tvWrong.setText("".concat(String.valueOf(wrong_ans)));
        tvNotDone.setText("".concat(String.valueOf(no_ans)));
        total_score = right_ans * 10;
        tvTotal.setText("".concat(String.valueOf(total_score)).concat(" points"));
        btn_checkAgain = findViewById(R.id.btn_checkAgain);
        btn_checkAgain.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                checkAnswer();
            }
        });
    }
    private void checkKetQua(){
        for(int i = 0; i< listQuestionBegin.size() ;i++){
            if (listQuestionBegin.get(i).getTraloi().equals("")==true) {
                no_ans++;
            } else if (listQuestionBegin.get(i).getResult().equals(listQuestionBegin.get(i).getTraloi())==true){
                right_ans++;
            } else wrong_ans++;
        }
    }
    @Override
    public void onResume() {
        super.onResume();
        SharedPreferences sharedPreferences;
        sharedPreferences = getSharedPreferences(filename, Context.MODE_PRIVATE);
        String fontsize = sharedPreferences.getString("fontsize", null);
        if(fontsize != null){
            tvHead.setTextSize(Float.parseFloat(fontsize));
            tvRight.setTextSize(Float.parseFloat(fontsize));
            tvWrong.setTextSize(Float.parseFloat(fontsize));
            tvNotDone.setTextSize(Float.parseFloat(fontsize));
            tvTotal.setTextSize(Float.parseFloat(fontsize));
        }
    }
    private void checkAnswer(){
        Dialog dialog = new Dialog(ResultActivity.this);
        dialog.setContentView(R.layout.check_answer_dialog);
        CheckAgainAdapter answerAdapter = new CheckAgainAdapter(listQuestionBegin);
        dialog.setTitle("YOUR ANSWERS :");
        recyclerView = dialog.findViewById(R.id.gvListAnswers);
        //GridLayoutManager grm = new GridLayoutManager(SlideActivity.this,3);
        recyclerView.setAdapter(answerAdapter);
        recyclerView.setLayoutManager(new GridLayoutManager(ResultActivity.this,2));
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
                dialog.dismiss();
                Intent intent = new Intent(ResultActivity.this, MainActivity.class);
                startActivity(intent);
                finish();
            }
        });
    }
}