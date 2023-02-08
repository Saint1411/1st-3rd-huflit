package anhduy.dmt.contracts.Favorite;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

import anhduy.dmt.contracts.R;
import anhduy.dmt.contracts.Vocabulary;

public class FavoriteAdapter extends RecyclerView.Adapter<FavoriteAdapter.FavoriteVH>{

    ArrayList<Vocabulary> vocabularies;
    //Listener listener;

    public FavoriteAdapter(ArrayList<Vocabulary> vocabularies) {
        //this.listener=listener;
        this.vocabularies = vocabularies;
    }
    @NonNull
    @Override
    public FavoriteVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.add_to_favorite, parent,false);
        return new FavoriteVH(view);
    }

    @Override
    public void onBindViewHolder(@NonNull FavoriteVH holder, int position) {
        Vocabulary vocabulary = vocabularies.get(position);
        holder.imgWordF.setImageResource(vocabulary.getImgWord());
        holder.txWordF.setText(vocabulary.getWord());
        holder.txPhoneticF.setText(vocabulary.getPhonetic());
        holder.txTypeWordF.setText(vocabulary.getTypeWord());
//        holder.itemView.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                listener.OnItemListener(position,vocabulary);
//            }
//        });
    }

    @Override
    public int getItemCount() {
        return vocabularies.size();
    }

    class FavoriteVH extends RecyclerView.ViewHolder{
        ImageView imgWordF;
        TextView txWordF, txPhoneticF, txTypeWordF;

        public FavoriteVH(@NonNull View itemView) {
            super(itemView);
            imgWordF = itemView.findViewById(R.id.imgWordF);
            txWordF = itemView.findViewById(R.id.txWordF);
            txPhoneticF = itemView.findViewById(R.id.txPhoneticF);
            txTypeWordF = itemView.findViewById(R.id.txTypeWordF);
        }
    }

    public void AddWordToFavorite(Vocabulary vocabulary){
        vocabularies.add(vocabulary);
        notifyDataSetChanged();
    }
    public void deleteFavorite(Vocabulary vocabulary){
        vocabularies.remove(vocabulary);
        notifyDataSetChanged();
    }
//    interface Listener{
//        void OnItemListener(int pos, Vocabulary vocabulary);
//    }

}
