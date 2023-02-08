package com.example.toeic.favorite;

import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.toeic.R;
import com.example.toeic.vocabulary.Vocabulary;
import com.example.toeic.vocabulary.VocabularyAdapter;
import com.example.toeic.words.Words;

import java.util.ArrayList;
import java.util.List;

//import de.hdodenhof.circleimageview.CircleImageView;
// Thêm implement Filterable
public class FavoriteAdapter extends RecyclerView.Adapter<FavoriteAdapter.FavoriteVH> implements Filterable {
    ArrayList<Words> favorites;
    ArrayList<Words> favoritesOld;
    Listener listener;
    public FavoriteAdapter(ArrayList<Words> vocabularies, Listener listener) {
        //tạo mới 1 danh sách trong search
        this.favorites = vocabularies;
        this.favoritesOld=vocabularies;
        this.listener = listener;
    }

    @NonNull
    @Override
    public FavoriteAdapter.FavoriteVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.favorite_item, parent,false);
        return new FavoriteVH(view);

    }

    @Override
    public void onBindViewHolder(@NonNull FavoriteAdapter.FavoriteVH holder, int position) {
        Words favorite = favorites.get(position);
        holder.imgWord.setImageBitmap(BitmapFactory.decodeByteArray(favorite.getImgWord(), 0,favorite.getImgWord().length));
        holder.txWord.setText(favorite.getWord());
        holder.txPhonetic.setText(favorite.getPhonetic());
        holder.txTypeWord.setText(favorite.getTypeWord());
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                listener.onClickListener(favorite);
            }
        });
    }

    @Override
    public int getItemCount() {
        return favorites.size();
    }



    class FavoriteVH extends RecyclerView.ViewHolder{
        ImageView imgWord;
        TextView txWord, txPhonetic, txTypeWord;

        public FavoriteVH(@NonNull View itemView) {
            super(itemView);
            imgWord = itemView.findViewById(R.id.imgWord);
            txWord = itemView.findViewById(R.id.txWord);
            txPhonetic = itemView.findViewById(R.id.txPhonetic);
            txTypeWord = itemView.findViewById(R.id.txTypeWord);
        }
    }
    ///Update thêm chức năng tìm kiếm
    @Override
    public Filter getFilter() {
        return new Filter() {
            @Override
            protected FilterResults performFiltering(CharSequence charSequence) {
                String Strsearch = charSequence.toString();
                if(Strsearch.isEmpty()) favorites = favoritesOld;
                else {
                    List<Words> filteredList = new ArrayList<>();
                    for (Words favorite : favorites) {
                        if(favorite.getWord().toLowerCase().contains(Strsearch.toLowerCase())){
                            filteredList.add(favorite);
                        }
                    }
                    favorites = (ArrayList<Words>) filteredList;
                }
                FilterResults filterResults = new FilterResults();
                filterResults.values = favorites;
                return filterResults;
            }

            @Override
            protected void publishResults(CharSequence charSequence, FilterResults filterResults) {
                favorites = (ArrayList<Words>) filterResults.values;
                notifyDataSetChanged();

            }
        };
    }
    interface Listener{
        void onClickListener(Words words);
    }

}
