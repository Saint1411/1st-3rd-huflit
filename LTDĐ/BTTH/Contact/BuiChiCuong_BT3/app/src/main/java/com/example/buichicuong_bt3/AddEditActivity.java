package com.example.buichicuong_bt3;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.DatePicker;

import com.google.android.material.textfield.TextInputEditText;
import com.google.android.material.textfield.TextInputLayout;

import java.util.Calendar;
import java.util.Random;

public class AddEditActivity extends AppCompatActivity {
    TextInputLayout tifName, tilName, tiEmail, tiPhone, tiBirthday;
    TextInputEditText edfName, edlName, edEmail, edPhone, edBirthday;
    int mYear, mMonth, mDay;
    int flag;
    Phone contactEdit;
    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_edit);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        tifName = findViewById(R.id.tilFname);
        tilName = findViewById(R.id.tilLname);
        tiEmail = findViewById(R.id.tilEmail);
        tiPhone = findViewById(R.id.tilPhone);
        tiBirthday = findViewById(R.id.tilBirthday);

        edfName = findViewById(R.id.edFirstName);
        edlName = findViewById(R.id.edLastName);
        edEmail = findViewById(R.id.edEmail);
        edPhone = findViewById(R.id.edPhone);
        edBirthday = findViewById(R.id.edBirthday);

        Intent intent = getIntent();
        flag = intent.getIntExtra("flag",0);
        if(flag == 1){
            getSupportActionBar().setTitle(R.string.add);
        }
        else {
            getSupportActionBar().setTitle(R.string.edit);
            contactEdit = (Phone)intent.getSerializableExtra("contact");
            edfName.setText(contactEdit.getFname());
            edlName.setText(contactEdit.getLname());
            edEmail.setText(contactEdit.getEmail());
            edPhone.setText(contactEdit.getPhoneNumber());
            edBirthday.setText(contactEdit.getBirthday());


        }
        edBirthday.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (view == edBirthday)
                {
                    final Calendar calendar = Calendar.getInstance();
                    mYear = calendar.get(Calendar.YEAR);
                    mMonth = calendar.get(Calendar.MONTH);
                    mDay = calendar.get(Calendar.DAY_OF_MONTH);
                    //show dialog
                    DatePickerDialog datePickerDialog = new DatePickerDialog(AddEditActivity.this, new DatePickerDialog.OnDateSetListener() {
                        @Override
                        public void onDateSet(DatePicker datePicker, int year, int month, int dayOfMonth) {
                            edBirthday.setText(dayOfMonth+"/"+String.format("%02d",month+1)+"/"+year);
                        }
                    },mYear, mMonth, mDay);
                    datePickerDialog.show();
                }
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater(); // khởi tạo đối tượng
        menuInflater.inflate(R.menu.save, menu); //gắn vào đối tượng menu
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (item.getItemId() == R.id.mnuSave) {
            if (edfName.getText().toString().isEmpty()
                    || edlName.getText().toString().isEmpty()
                    || edEmail.getText().toString().isEmpty()
                    || edPhone.getText().toString().isEmpty()
                    || edBirthday.getText().toString().isEmpty()) {
                tifName.setError("Not null");
                tilName.setError("Not null");
                tiEmail.setError("Not null");
                tiPhone.setError("Not null");
                tiBirthday.setError("Not null");
                return false;
            } else {
                if (flag == 1) {
                    Phone contact = new Phone(new Random().nextInt(9999),
                            0,
                            edfName.getText().toString(),
                            edlName.getText().toString(),
                            edPhone.getText().toString(),
                            edEmail.getText().toString()
                            ,edBirthday.getText().toString()
                    );
                    Log.d("ABC", contact.toString());
                    Intent intent = new Intent();
                    intent.putExtra("contact", contact);
                    intent.putExtra("flag", 1);
                    setResult(RESULT_OK, intent);
                    finish();
                } else {
                    Phone contact = new Phone(contactEdit.getStt(),
                            contactEdit.getAvatar(),
                            edfName.getText().toString(),
                            edlName.getText().toString(),
                            edPhone.getText().toString(),
                            edEmail.getText().toString(),
                            edBirthday.getText().toString()
                    );
                    Log.d("Edit",contact.toString());
                    Intent intent = new Intent();
                    intent.putExtra("contact", contact);
                    intent.putExtra("flag", 2);
                    setResult(RESULT_OK, intent);
                    finish();
                }
            }
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed();
        return super.onSupportNavigateUp();
    }
}