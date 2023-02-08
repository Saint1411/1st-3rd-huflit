package com.example.toeic.history;

import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.toeic.R;
import com.example.toeic.words.Words;

import java.util.ArrayList;

public class HistoryAdapter extends RecyclerView.Adapter<HistoryAdapter.ViewHolder>{
    ArrayList<Words> listWords;

    public HistoryAdapter(ArrayList<Words> listWords) {
        this.listWords = listWords;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.favorite_item, parent,false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        Words favorite = listWords.get(position);
        holder.imgWord.setImageBitmap(BitmapFactory.decodeByteArray(favorite.getImgWord(),0,favorite.getImgWord().length));
        holder.txWord.setText(favorite.getWord());
        holder.txPhonetic.setText(favorite.getPhonetic());
        holder.txTypeWord.setText(favorite.getTypeWord());
    }

    @Override
    public int getItemCount() {
        return listWords.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder{
        ImageView imgWord;
        TextView txWord, txPhonetic, txTypeWord;
        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            imgWord = itemView.findViewById(R.id.imgWord);
            txWord = itemView.findViewById(R.id.txWord);
            txPhonetic = itemView.findViewById(R.id.txPhonetic);
            txTypeWord = itemView.findViewById(R.id.txTypeWord);
        }
    }
}
