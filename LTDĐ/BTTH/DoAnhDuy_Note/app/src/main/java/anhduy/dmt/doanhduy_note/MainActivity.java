package anhduy.dmt.doanhduy_note;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity implements NoteAdapter.Listener{
    RecyclerView recyvlerView;
    ArrayList<Note> notes;
    NoteAdapter noteAdapter;
    DBHelper dbHelper;
    int position;

    ActivityResultLauncher<Intent> Mlauncher = registerForActivityResult(
            new ActivityResultContracts.StartActivityForResult(),
            new ActivityResultCallback<ActivityResult>() {
                @Override
                public void onActivityResult(ActivityResult result) {
                    if(result.getResultCode()==RESULT_OK){
                        if(result.getData().getIntExtra("flag",0)==1){
                            Note note =(Note) result.getData().getSerializableExtra("note");
                            //noteAdapter.addNote(note);
                            dbHelper.insertNote(note);
                            initData();
                        }
                        else{
                            Note note =(Note) result.getData().getSerializableExtra("note");
                            //noteAdapter.editNote(note,position);
                            dbHelper.updateNote(note);
                            initData();
                        }
                    }
                }
            }
    );
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        FloatingActionButton bntAdd;
        bntAdd = findViewById(R.id.bntAdd);
        recyvlerView =findViewById(R.id.recyvlerView);
        bntAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(MainActivity.this, AddActivity.class);
                intent.putExtra("Add", notes);
                intent.putExtra("flag", 1);
                Mlauncher.launch(intent);
            }
        });

        //notes=App.InitData();
        notes = new ArrayList<>();
        dbHelper = new DBHelper(MainActivity.this);

        noteAdapter= new NoteAdapter(notes,MainActivity.this);
        recyvlerView.setAdapter(noteAdapter);
        recyvlerView.setLayoutManager(new LinearLayoutManager(MainActivity.this, LinearLayoutManager.VERTICAL, false));
        recyvlerView.addItemDecoration(new DividerItemDecoration(MainActivity.this, LinearLayoutManager.VERTICAL));
        initData();
    }

    private void initData() {
        notes.clear();
        notes.addAll(dbHelper.getNotes());
        noteAdapter.notifyDataSetChanged();
    }
    @Override
    public void OnItemListener(int pos, Note note) {
        position=pos;
        Intent intent = new Intent(MainActivity.this, AddActivity.class);
        intent.putExtra("note", note);
        intent.putExtra("flag", 2);
        Mlauncher.launch(intent);
    }
}