package com.example.toeic.vocabulary;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.example.toeic.DbHelper;
import com.example.toeic.HomeFragment;
import com.example.toeic.R;

import java.util.ArrayList;


public class VocabularyFragment extends Fragment {

    String filename = "settings";
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    RecyclerView rvVocab;
    VocabularyAdapter vocabularyAdapter;
    ArrayList<Vocabulary> vocabData;
    //database
    DbHelper db;

    private String mParam1;
    private String mParam2;

    public VocabularyFragment() {
        // Required empty public constructor
    }


    public static VocabularyFragment newInstance(String param1, String param2) {
        VocabularyFragment fragment = new VocabularyFragment();
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
        
        db = new DbHelper(getContext());

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_vocabulary, container, false);
        rvVocab = view.findViewById(R.id.rvVocabulary);
        vocabData = new ArrayList<>();

        vocabularyAdapter = new VocabularyAdapter(vocabData);
        GridLayoutManager grm = new GridLayoutManager(getContext(),2);
        rvVocab.setLayoutManager(grm);
        rvVocab.setAdapter(vocabularyAdapter);

        initData();

        return view;
    }

    private void initData() {
        vocabData.clear();
        vocabData.addAll(db.getAllVocabulary());
        vocabularyAdapter.notifyDataSetChanged();
    }

//    public ArrayList<Vocabulary> InitDataForVocab(){
//        vocabData.add(new Vocabulary(R.drawable.country,"Country","9 words",1));
//        vocabData.add(new Vocabulary(R.drawable.marketing,"Marketing","4 words",2));
//        vocabData.add(new Vocabulary(R.drawable.bussiness,"Business","12 words",3));
//        vocabData.add(new Vocabulary(R.drawable.bank,"Banking","12 words",4));
//        return vocabData;
//    }

//    @Override
//    public void onItemListener(Vocabulary vocabulary) {
//        Fragment fragment = new HomeFragment();
//    }

    @Override
    public void onResume() {
        super.onResume();
        SharedPreferences sharedPreferences =this.getContext().getSharedPreferences(filename, Context.MODE_PRIVATE);
        String fontsize = sharedPreferences.getString("fontsize", null);
        if(fontsize != null){

        }
    }
}