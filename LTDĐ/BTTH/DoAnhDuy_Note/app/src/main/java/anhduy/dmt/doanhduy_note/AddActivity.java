package anhduy.dmt.doanhduy_note;

import androidx.activity.result.ActivityResultLauncher;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;

public class AddActivity extends AppCompatActivity {
    EditText titleInput, contentInput;
    TextView tvTimeInput;
    Button btnSave;
    Note noteEdit;
    int flag;
    int mYear, mMonth, mDay;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add);
        titleInput = findViewById(R.id.titleInput);
        contentInput=findViewById(R.id.contentInput);
        btnSave=findViewById(R.id.btSave);
        tvTimeInput=findViewById(R.id.tvTimeInput);
        tvTimeInput.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(view==tvTimeInput){
                    final Calendar calendar = Calendar.getInstance();
                    mYear = calendar.get(Calendar.YEAR);
                    mMonth = calendar.get(Calendar.MONTH);
                    mDay = calendar.get(Calendar.DAY_OF_MONTH);
                    //show dialog
                    DatePickerDialog datePickerDialog = new DatePickerDialog(AddActivity.this, new DatePickerDialog.OnDateSetListener() {
                        @Override
                        public void onDateSet(DatePicker datePicker, int year, int month, int dayOfMonth) {
                            tvTimeInput.setText(dayOfMonth+"/"+String.format("%02d",month+1)+"/"+year);
                        }
                    },mYear, mMonth, mDay);
                    datePickerDialog.show();
                }
            }
        });
        btnSave.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(titleInput.getText().toString().isEmpty() || contentInput.getText().toString().isEmpty())
                    return;
                else{
                    if(flag==1){
                        Note note = new Note(new Random().nextInt(9999),
                                titleInput.getText().toString(),
                                contentInput.getText().toString(),
                                tvTimeInput.getText().toString());
                        Intent intent = new Intent();
                        intent.putExtra("note", note);
                        intent.putExtra("flag", 1);
                        setResult(RESULT_OK, intent);
                        finish();
                    }
                    else {
                        Note note = new Note(noteEdit.getId(),
                                titleInput.getText().toString(),
                                contentInput.getText().toString(),
                                tvTimeInput.getText().toString());

                        Intent intent = new Intent();
                        intent.putExtra("note", note);
                        intent.putExtra("flag", 2);
                        setResult(RESULT_OK, intent);
                        finish();

                    }
                }
                Toast.makeText(getApplicationContext(),"Saved Note Successfully", Toast.LENGTH_LONG).show();
                finish();
            }
        });

        Intent intent = getIntent();
        flag = intent.getIntExtra("flag", 0);
        if (flag == 1) {
            getSupportActionBar().setTitle("New Note");
        } else {
            getSupportActionBar().setTitle("Edit Note");
            noteEdit = (Note) intent.getSerializableExtra("note");
            titleInput.setText(noteEdit.getTilte());
            contentInput.setText(noteEdit.getContent());
            tvTimeInput.setText(noteEdit.getTime());
        }
    }

}