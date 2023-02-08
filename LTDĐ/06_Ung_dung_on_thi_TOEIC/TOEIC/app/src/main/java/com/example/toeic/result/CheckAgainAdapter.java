package com.example.toeic.result;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.toeic.R;
import com.example.toeic.slide.CheckAnswerAdapter;
import com.example.toeic.slide.Question;

import java.util.ArrayList;

public class CheckAgainAdapter extends RecyclerView.Adapter<CheckAgainAdapter.ViewHolder>{
    ArrayList<Question> listAnsWers;


    public CheckAgainAdapter(ArrayList<Question> listAnsWers) {
        this.listAnsWers = listAnsWers;
    }

    @NonNull
    @Override
    public CheckAgainAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_gridview, parent,false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull CheckAgainAdapter.ViewHolder holder, int position) {
        Question question = listAnsWers.get(position);
        if (question.getTraloi().equals(question.getResult()) == true){
            holder.tvNumberAnswer.setTextColor(Color.parseColor("#06d6a0"));
            holder.tvAnswer.setTextColor(Color.parseColor("#06d6a0"));
        } else{
            holder.tvNumberAnswer.setTextColor(Color.parseColor("#ef233c"));
            holder.tvAnswer.setTextColor(Color.parseColor("#ef233c"));
        }
        holder.tvNumberAnswer.setText("Câu "+String.valueOf(position+1)+" :");
        holder.tvAnswer.setText(question.getTraloi());
    }

    @Override
    public int getItemCount() {
        return listAnsWers.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder{
        TextView tvNumberAnswer, tvAnswer;
        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            tvNumberAnswer = itemView.findViewById(R.id.tvNumAnswer);
            tvAnswer = itemView.findViewById(R.id.tvAnswer);
        }
    }
}
