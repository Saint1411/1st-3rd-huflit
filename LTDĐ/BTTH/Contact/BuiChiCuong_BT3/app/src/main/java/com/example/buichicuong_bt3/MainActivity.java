package com.example.buichicuong_bt3;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;


import androidx.appcompat.widget.SearchView;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.app.SearchManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;


import com.google.android.material.bottomsheet.BottomSheetDialog;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

public class MainActivity extends AppCompatActivity implements PhoneAdapter.Listener{
    RecyclerView rvPhone;
    ArrayList<Phone> listPhone;// = new ArrayList<>();
    PhoneAdapter phoneAdapter;
    FloatingActionButton floatingActionButton;
    int position;
    ActivityResultLauncher<Intent> mLauncher = registerForActivityResult(
            new ActivityResultContracts.StartActivityForResult(),
            new ActivityResultCallback<ActivityResult>() {
                @Override
                public void onActivityResult(ActivityResult result) {
                    if(result.getResultCode() == RESULT_OK){
                        if(result.getData().getIntExtra("flag",0) == 1){
                            Phone contact = (Phone)result.getData().getSerializableExtra("contact");
                            phoneAdapter.addContact(contact);

                        } else {
                            Phone contact = (Phone)result.getData().getSerializableExtra("contact");
                            phoneAdapter.editContact(contact,position);
                        }
                    }
                }
            }
    );
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        rvPhone = findViewById(R.id.rvPhone);
        listPhone = App.data;
        phoneAdapter = new PhoneAdapter(listPhone, MainActivity.this);
        rvPhone.setAdapter(phoneAdapter);
        rvPhone.setLayoutManager(new LinearLayoutManager(MainActivity.this,LinearLayoutManager.VERTICAL,false));
        rvPhone.addItemDecoration(new DividerItemDecoration(MainActivity.this,LinearLayoutManager.VERTICAL));
        //floating button
        floatingActionButton = findViewById(R.id.fl_btnAdd);
        floatingActionButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(MainActivity.this,AddEditActivity.class);
                intent.putExtra("flag",1);
                mLauncher.launch(intent);
            }
        });
    }

    @Override
    public void onItemListener(Phone phone,int pos) {
        /*AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
        builder.setTitle("Contacts");
        builder.setMessage(phone.getFname()+" " +phone.getLname() +"\n" + phone.getPhoneNumber() );
        builder.setIcon(getDrawable(phone.getAvatar()));
        builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
            }
        });
        builder.show(); */
        position = pos;
        InfoDialogBottomSheet bottomSheetDialog = new InfoDialogBottomSheet(MainActivity.this,phone,mLauncher,phoneAdapter);
        bottomSheetDialog.findView();
        bottomSheetDialog.show();
    }
    //option menu
    //tạo ra giao diện
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater(); // khởi tạo đối tượng
        menuInflater.inflate(R.menu.option_menu, menu); //gắn vào đối tượng menu
        SearchManager searchManager = (SearchManager) getSystemService(Context.SEARCH_SERVICE);
        SearchView searchView = (SearchView) menu.findItem(R.id.mnu_Search).getActionView();
        searchView.setSearchableInfo(searchManager.getSearchableInfo(getComponentName()));
        searchView.setMaxWidth(Integer.MAX_VALUE);
        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                phoneAdapter.getFilter().filter(query);
                return false;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                phoneAdapter.getFilter().filter(newText);

                if(newText.isEmpty()){
                    floatingActionButton.setVisibility(View.VISIBLE);
                }else {
                    floatingActionButton.setVisibility(View.INVISIBLE);
                }
                return false;

            }
        });
        return true;
    }

    //xử lý giao diện ( nhấn lên menu )
    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (item.getItemId() == R.id.mnu_Search){
//            Intent intent = new Intent(MainActivity.this, SearchActivity.class);
//            startActivity(intent);
        }
        else if (item.getItemId() == R.id.mnu2){
            Collections.sort(listPhone);
            phoneAdapter.notifyDataSetChanged();
        }
        return super.onOptionsItemSelected(item);
    }

}