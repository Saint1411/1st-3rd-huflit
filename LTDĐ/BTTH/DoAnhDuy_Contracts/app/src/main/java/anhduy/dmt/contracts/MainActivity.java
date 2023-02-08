package anhduy.dmt.contracts;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.SearchView;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.app.SearchManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import anhduy.dmt.contracts.In4Word.InfoActivity;

public class MainActivity extends AppCompatActivity implements VocabularyAdapter.Listener {
    RecyclerView rvVocabulary;
    ArrayList<Vocabulary> vocabularies;
    VocabularyAdapter vocabularyAdapter;
    //Update
    private SearchView searchView;
    int position;
    //ImageView imgFavorite;


//    ActivityResultLauncher<Intent> Mlauncher = registerForActivityResult(
//            new ActivityResultContracts.StartActivityForResult(),
//            new ActivityResultCallback<ActivityResult>() {
//                @Override
//                public void onActivityResult(ActivityResult result) {
//                    if(result.getResultCode()==RESULT_OK){
//                        Vocabulary vocabulary =(Vocabulary) result.getData().getSerializableExtra("Vocabulary");
//                        vocabularyAdapter.AddWordToFavorite(vocabulary);
//                    }
//                }
//            }
//    );
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //getSupportActionBar().setTitle("Main");
        rvVocabulary = findViewById(R.id.rvVocabulary);
        vocabularies = App.initDataForVocabulary();
        vocabularyAdapter = new VocabularyAdapter(vocabularies,MainActivity.this);
        rvVocabulary.setAdapter(vocabularyAdapter);
        rvVocabulary.setLayoutManager(new LinearLayoutManager(MainActivity.this, LinearLayoutManager.VERTICAL, false));
        rvVocabulary.addItemDecoration(new DividerItemDecoration(MainActivity.this, LinearLayoutManager.VERTICAL));

    }

    ///Update đổi menu tắt thoogn báo thành Search
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.main_menu, menu);

        SearchManager searchManager = (SearchManager) getSystemService(Context.SEARCH_SERVICE);
        searchView = (SearchView) menu.findItem(R.id.action_search).getActionView();
        searchView.setSearchableInfo(searchManager.getSearchableInfo(getComponentName()));
        searchView.setMaxWidth(Integer.MAX_VALUE);
        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                vocabularyAdapter.getFilter().filter(query);
                return false;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                vocabularyAdapter.getFilter().filter(newText);
                return false;
            }
        });
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if(item.getItemId() == R.id.action_sort){
//            Collections.sort(vocabularies);
//            vocabularyAdapter.notifyDataSetChanged();
            SortWord(vocabularies);
            vocabularyAdapter.notifyDataSetChanged();
        }
        return super.onOptionsItemSelected(item);
    }



    @Override
    public void onBackPressed() {
        if(!searchView.isIconified()){
            searchView.setIconified(true);
            return;
        }
        super.onBackPressed();
    }
    //Sắp xếp từ A-Z
    public void SortWord(ArrayList<Vocabulary> vocabularies){
        Collections.sort(vocabularies, new Comparator<Vocabulary>() {
            @Override
            public int compare(Vocabulary t1, Vocabulary t2) {
                String word1=t1.getWord();
                String word2=t2.getWord();
                int compareWord=word1.compareTo(word2);

                return compareWord;
            }
        });

    }



    @Override
    public void OnItemListener(int pos, Vocabulary vocabulary) {
        Intent intent = new Intent(this, InfoActivity.class);
        Bundle bundle=new Bundle();
        bundle.putInt("Img",vocabulary.getImgWord());
        bundle.putString("Word", vocabulary.getWord());
        bundle.putString("Phonestic", vocabulary.getPhonetic());
        bundle.putString("Type", vocabulary.getTypeWord());
        bundle.putString("Des",vocabulary.getDescription());
        intent.putExtra("Info", bundle);

        //intent.putExtra("Info", vocabulary);
        //setResult(RESULT_OK, intent);
        startActivity(intent);
    }



}