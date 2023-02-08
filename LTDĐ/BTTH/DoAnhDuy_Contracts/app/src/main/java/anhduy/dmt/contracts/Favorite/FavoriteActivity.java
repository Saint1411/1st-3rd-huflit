package anhduy.dmt.contracts.Favorite;

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
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import anhduy.dmt.contracts.BottomSheet;
import anhduy.dmt.contracts.R;
import anhduy.dmt.contracts.Vocabulary;
import anhduy.dmt.contracts.VocabularyAdapter;

public class FavoriteActivity extends AppCompatActivity {
    RecyclerView rvVocabulary;
    ArrayList<Vocabulary> vocabularies;
    FavoriteAdapter favoriteAdapter;
    //Update
    //private SearchView searchView;
    //ActivityResultLauncher Mlauncher;




//    ActivityResultLauncher<Intent> Mlauncher = registerForActivityResult(
//            new ActivityResultContracts.StartActivityForResult(),
//            new ActivityResultCallback<ActivityResult>() {
//                @Override
//                public void onActivityResult(ActivityResult result) {
//                    if(result.getResultCode()==RESULT_OK){
//                        assert result.getData() != null;
//                        Vocabulary vocabularyFavorite =(Vocabulary) result.getData().getSerializableExtra("Favorite");
//                        favoriteAdapter.AddWordToFavorite(vocabularyFavorite);
//                    }
//                }
//            }
//    );
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_favorite);
        getSupportActionBar().setTitle("Favorite");
        rvVocabulary = findViewById(R.id.rvVocabulary);
        vocabularies = new ArrayList<>();
        vocabularies = initDataForVocabulary();
        favoriteAdapter = new FavoriteAdapter(vocabularies);
        rvVocabulary.setAdapter(favoriteAdapter);
        rvVocabulary.setLayoutManager(new LinearLayoutManager(FavoriteActivity.this, LinearLayoutManager.VERTICAL, false));
        rvVocabulary.addItemDecoration(new DividerItemDecoration(FavoriteActivity.this, LinearLayoutManager.VERTICAL));

//        Vocabulary vocabulary = (Vocabulary) getIntent().getExtras().get("Favorite");
//        favoriteAdapter.AddWordToFavorite(vocabulary);


    }
    public ArrayList<Vocabulary> initDataForVocabulary(){
        //vocabularies.add(new Vocabulary(2,R.drawable.estonia,"Estonia", "/ɛsˈtəʊnɪə/","noun","Since I have known you, I have never felt sorry for anything I have done for you. "));
        return vocabularies;
    }


    ///Update đổi menu tắt thoogn báo thành Search
//    @Override
//    public boolean onCreateOptionsMenu(Menu menu) {
//        MenuInflater menuInflater = getMenuInflater();
//        menuInflater.inflate(R.menu.main_menu, menu);
//
//        SearchManager searchManager = (SearchManager) getSystemService(Context.SEARCH_SERVICE);
//        searchView = (SearchView) menu.findItem(R.id.action_search).getActionView();
//        searchView.setSearchableInfo(searchManager.getSearchableInfo(getComponentName()));
//        searchView.setMaxWidth(Integer.MAX_VALUE);
//        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
//            @Override
//            public boolean onQueryTextSubmit(String query) {
//                favoriteAdapter.getFilter().filter(query);
//                return false;
//            }
//
//            @Override
//            public boolean onQueryTextChange(String newText) {
//                favoriteAdapter.getFilter().filter(newText);
//                return false;
//            }
//        });
//        return true;
//    }

//    @Override
//    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
//        if(item.getItemId() == R.id.action_sort){
////            Collections.sort(vocabularies);
////            vocabularyAdapter.notifyDataSetChanged();
//            SortWord(vocabularies);
//            vocabularyAdapter.notifyDataSetChanged();
//        }
//
//        return super.onOptionsItemSelected(item);
//    }



//    @Override
//    public void onBackPressed() {
//        if(!searchView.isIconified()){
//            searchView.setIconified(true);
//            return;
//        }
//        super.onBackPressed();
//    }
    //Sắp xếp từ A-Z
//    public void SortWord(ArrayList<Vocabulary> vocabularies){
//        Collections.sort(vocabularies, new Comparator<Vocabulary>() {
//            @Override
//            public int compare(Vocabulary t1, Vocabulary t2) {
//                String word1=t1.getWord();
//                String word2=t2.getWord();
//                int compareWord=word1.compareTo(word2);
//
//                return compareWord;
//            }
//        });
//    }

//    @Override
//    public void OnItemListener(int pos, Vocabulary vocabulary) {
//        BottomSheet dialog= new BottomSheet(this,vocabulary,Mlauncher ,favoriteAdapter);
//
//        dialog.FindView();
//        dialog.show();
//    }
}