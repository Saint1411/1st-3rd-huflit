package com.example.toeic.slide;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListAdapter;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.toeic.R;

import java.util.ArrayList;

public class CheckAnswerAdapter extends RecyclerView.Adapter<CheckAnswerAdapter.ViewHolder>{
    ArrayList<Question> listAnsWers;

    public CheckAnswerAdapter(ArrayList<Question> listAnsWers,Context context) {
        this.listAnsWers = listAnsWers;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_gridview, parent,false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        Question question = listAnsWers.get(position);
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
