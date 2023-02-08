package com.example.toeic.vocabulary;

import android.app.Application;
import android.content.Context;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;

import com.example.toeic.HomeFragment;
import com.example.toeic.R;
import com.example.toeic.words.WordsFragment;

import java.util.ArrayList;

public class VocabularyAdapter extends RecyclerView.Adapter<VocabularyAdapter.ViewHolder>{
    ArrayList<Vocabulary> listVocab;

    public VocabularyAdapter(ArrayList<Vocabulary> listVocab) {
        this.listVocab = listVocab;

    }
    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.activity_vocabulary, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        Vocabulary vocab = listVocab.get(position);
        //holder.imgVocab.setImageBitmap(vocab.getImgVocab());
        holder.imgVocab.setImageBitmap(BitmapFactory.decodeByteArray(vocab.getImgVocab(),0,vocab.getImgVocab().length));
        holder.tvTopic.setText(vocab.getTopic());
        holder.tvNumOfWords.setText(vocab.getNumberOfWords());
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AppCompatActivity appCompatActivity =(AppCompatActivity)view.getContext();
                appCompatActivity.getSupportFragmentManager().beginTransaction().replace(R.id.content, new WordsFragment(vocab.getTopicNumber())).addToBackStack(null).commit();
            }
        });
    }

    @Override
    public int getItemCount() {
        return listVocab.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder{
        ImageView imgVocab;
        TextView tvTopic, tvNumOfWords;
        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            imgVocab = itemView.findViewById(R.id.imgVocab);
            tvTopic = itemView.findViewById(R.id.tvTopicVocab);
            tvNumOfWords = itemView.findViewById(R.id.tvNumOfVocab);

        }
    }
}
