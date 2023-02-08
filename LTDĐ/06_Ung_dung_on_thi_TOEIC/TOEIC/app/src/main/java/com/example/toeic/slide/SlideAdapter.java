package com.example.toeic.slide;

import android.content.Context;
import android.content.SharedPreferences;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.toeic.R;

import java.util.ArrayList;
import java.util.concurrent.locks.AbstractQueuedSynchronizer;

public class SlideAdapter extends RecyclerView.Adapter<SlideAdapter.ViewHolder> {
    ArrayList<Question> listQuestion;
    Context context;

    public SlideAdapter(Context context, ArrayList<Question> listQuestion) {
        this.context = context;
        this.listQuestion = listQuestion;
    }


    @NonNull
    @Override
    public SlideAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.item_slide_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        int pos = position;
        SharedPreferences sharedPreferences = context.getSharedPreferences("settings", Context.MODE_PRIVATE);
        String fontsize = sharedPreferences.getString("fontsize", null);
        if(fontsize != null){
            holder.tvQuestion.setTextSize(Float.parseFloat(fontsize));
            holder.rd_btn1.setTextSize(Float.parseFloat(fontsize));
            holder.rd_btn2.setTextSize(Float.parseFloat(fontsize));
            holder.rd_btn3.setTextSize(Float.parseFloat(fontsize));
            holder.rd_btn4.setTextSize(Float.parseFloat(fontsize));
        }
        Question question = listQuestion.get(position);
        holder.tvQuestion.setText(question.getQuestion());
        holder.rd_btn1.setHint(question.answer1);
        holder.rd_btn2.setHint(question.answer2);
        holder.rd_btn3.setHint(question.answer3);
        holder.rd_btn4.setHint(question.answer4);
        holder.radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup radioGroup, int i) {
                listQuestion.get(pos).id_choice = i;
                listQuestion.get(pos).setTraloi(getChoiceFormID(i));
            }
        });
        holder.radioGroup.clearCheck();
    }
    //lấy giá trị choice chuyển thành A/B/C/D
    public String getChoiceFormID(int ID)
    {
        switch (ID){
            case R.id.rd_btn1:
                return "A";
            case R.id.rd_btn2:
                return "B";
            case R.id.rd_btn3:
                return "C";
            case R.id.rd_btn4:
                return "D";
            default:
                return "";
        }
    }
    @Override
    public int getItemCount() {
        return listQuestion.size();
    }
    class ViewHolder extends RecyclerView.ViewHolder{
        TextView tvQuestion;
        RadioButton rd_btn1, rd_btn2, rd_btn3, rd_btn4;
        RadioGroup radioGroup;
        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            tvQuestion = itemView.findViewById(R.id.Question);
            rd_btn1 = itemView.findViewById(R.id.rd_btn1);
            rd_btn2 = itemView.findViewById(R.id.rd_btn2);
            rd_btn3 = itemView.findViewById(R.id.rd_btn3);
            rd_btn4 = itemView.findViewById(R.id.rd_btn4);
            radioGroup = itemView.findViewById(R.id.rd_group);
        }
    }
}
