package anhduy.dmt.contracts;

import android.annotation.SuppressLint;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;

//import de.hdodenhof.circleimageview.CircleImageView;
// Thêm implement Filterable
public class VocabularyAdapter extends RecyclerView.Adapter<VocabularyAdapter.VocabularyVH> implements Filterable {
    ArrayList<Vocabulary> vocabularies;
    ArrayList<Vocabulary> vocabulariesOld;
    Listener listener;

    public VocabularyAdapter(ArrayList<Vocabulary> vocabularies,  Listener listener) {
        //tạo mới 1 danh sách trong search
        this.listener=listener;
        this.vocabularies = vocabularies;
        this.vocabulariesOld=vocabularies;
    }

    @NonNull
    @Override
    public VocabularyAdapter.VocabularyVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.vocabulary_row, parent,false);
        return new VocabularyVH(view);

    }

    @Override
    public void onBindViewHolder(@NonNull VocabularyAdapter.VocabularyVH holder, @SuppressLint("RecyclerView") int position) {
        Vocabulary vocabulary = vocabularies.get(position);
        holder.imgWord.setImageResource(vocabulary.getImgWord());
        holder.txWord.setText(vocabulary.getWord());
        holder.txPhonetic.setText(vocabulary.getPhonetic());
        holder.txTypeWord.setText(vocabulary.getTypeWord());
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                listener.OnItemListener(position,vocabulary);
            }
        });
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
            imgWord = itemView.findViewById(R.id.imgWordF);
            txWord = itemView.findViewById(R.id.txWordF);
            txPhonetic = itemView.findViewById(R.id.txPhoneticF);
            txTypeWord = itemView.findViewById(R.id.txTypeWordF);
        }
    }
    ///Update thêm chức năng tìm kiếm
    @Override
    public Filter getFilter() {
        return new Filter() {
            @Override
            protected FilterResults performFiltering(CharSequence charSequence) {
                String Strsearch = charSequence.toString();
                if(Strsearch.isEmpty()) vocabularies=vocabulariesOld;
                else {
                    List<Vocabulary> filteredList = new ArrayList<>();
                    for (Vocabulary vocabulary : vocabularies) {
                        if(vocabulary.getWord().toLowerCase().contains(Strsearch.toLowerCase())){
                            filteredList.add(vocabulary);
                        }
                    }
                    vocabularies = (ArrayList<Vocabulary>) filteredList;
                }
                FilterResults filterResults = new FilterResults();
                filterResults.values = vocabularies;
                return filterResults;
            }

            @Override
            protected void publishResults(CharSequence charSequence, FilterResults filterResults) {
                vocabularies= (ArrayList<Vocabulary>) filterResults.values;
                notifyDataSetChanged();

            }
        };
    }
    public void AddWordToFavorite(Vocabulary vocabulary){
        vocabularies.add(vocabulary);
        notifyDataSetChanged();
    }
    public void deleteFavorite(Vocabulary vocabulary){
        vocabularies.remove(vocabulary);
        notifyDataSetChanged();
    }
    interface Listener{
        void OnItemListener(int pos, Vocabulary vocabulary);
    }
}
