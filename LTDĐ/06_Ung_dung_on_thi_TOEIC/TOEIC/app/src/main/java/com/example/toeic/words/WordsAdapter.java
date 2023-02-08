package com.example.toeic.words;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import com.example.toeic.BottomSheet;
import com.example.toeic.R;
import com.example.toeic.favorite.FavoriteActivity;
import com.example.toeic.vocabulary.Vocabulary;

import java.util.ArrayList;
import java.util.List;

//import de.hdodenhof.circleimageview.CircleImageView;

public class WordsAdapter extends RecyclerView.Adapter<WordsAdapter.VocabularyVH> {
    ArrayList<Words> vocabularies;
    Listener listener;
    public WordsAdapter(ArrayList<Words> vocabularies, Listener listener) {
        this.listener = listener;
        this.vocabularies = vocabularies;
    }

    @NonNull
    @Override
    public VocabularyVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.words_row, parent,false);
        return new VocabularyVH(view);

    }

    @Override
    public void onBindViewHolder(@NonNull VocabularyVH holder, int position) {
        Words words = vocabularies.get(position);
        byte[] img = words.getImgWord();
        holder.imgWord.setImageBitmap(convertCompressedByteArrayToBitmap(img));
        holder.txWord.setText(words.getWord());
        holder.txPhonetic.setText(words.getPhonetic());
        holder.txTypeWord.setText(words.getTypeWord());
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                listener.onItemListener(words,position);
            }
        });
    }
    public static Bitmap convertCompressedByteArrayToBitmap(byte[] src){
       return BitmapFactory.decodeByteArray(src, 0, src.length);
    }
    @Override
    public int getItemCount() {
        return vocabularies.size();
    }
    class VocabularyVH extends RecyclerView.ViewHolder{
        ImageView imgWord;
        TextView txWord, txPhonetic, txTypeWord;

        public VocabularyVH(@NonNull View itemView) {
            super(itemView);
            imgWord = itemView.findViewById(R.id.imgWord);
            txWord = itemView.findViewById(R.id.txWord);
            txPhonetic = itemView.findViewById(R.id.txPhonetic);
            txTypeWord = itemView.findViewById(R.id.txTypeWord);
        }
    }
    interface Listener{
        void onItemListener(Words words, int position);
    }
}
