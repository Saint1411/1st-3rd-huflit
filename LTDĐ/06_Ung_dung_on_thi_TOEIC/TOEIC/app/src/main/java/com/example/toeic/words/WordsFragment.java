package com.example.toeic.words;

import android.app.SearchManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.appcompat.widget.SearchView;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.example.toeic.BottomSheet;
import com.example.toeic.DbHelper;
import com.example.toeic.MainActivity;
import com.example.toeic.R;
import com.example.toeic.favorite.FavoriteActivity;
import com.example.toeic.infoword.InfoActivity;
import com.example.toeic.vocabulary.Vocabulary;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link WordsFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class WordsFragment extends Fragment implements Serializable,WordsAdapter.Listener{
    ArrayList<Words> dataWords;
    int topicNumber;
    ImageView imgWord;
    TextView txWord, txPhonetic, txTypeWord;
    //
    int position;
    RecyclerView rvWords;
    WordsAdapter wordsAdapter;
    //database
    DbHelper db;


    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public WordsFragment() {
        // Required empty public constructor
    }
    public WordsFragment(int topicNumber)
    {
        this.topicNumber = topicNumber;
    }


    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment WordsFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static WordsFragment newInstance(String param1, String param2) {
        WordsFragment fragment = new WordsFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
        if(dataWords == null){
            dataWords = new ArrayList<>();
        }
        db = new DbHelper(getContext());
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_words, container, false);
        imgWord = view.findViewById(R.id.imgWord);
        txWord = view.findViewById(R.id.txWord);
        txPhonetic = view.findViewById(R.id.txPhonetic);
        txTypeWord = view.findViewById(R.id.txTypeWord);

        rvWords= view.findViewById(R.id.rvWords);
        wordsAdapter = new WordsAdapter(dataWords,WordsFragment.this);
        //wordsAdapter = new WordsAdapter(wordsByTopic,WordsFragment.this);
        rvWords.setAdapter(wordsAdapter);
        rvWords.setLayoutManager(new LinearLayoutManager(getContext(), LinearLayoutManager.VERTICAL, false));
        rvWords.addItemDecoration(new DividerItemDecoration(getContext(), LinearLayoutManager.VERTICAL));
        initData(topicNumber);
        return view;
    }
    void initData(int topicNumber){
        dataWords.addAll(db.getAllWords(topicNumber));
        wordsAdapter.notifyDataSetChanged();
    }
    @Override
    public void onItemListener(Words words, int pos) {
        position=pos;
        db.Addhistory(words);
        Intent intent = new Intent(getActivity(), InfoActivity.class);
        intent.putExtra("Info", words);
        startActivity(intent);
    }


}