package anhduy.dmt.doanhduy_bt03;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.DialogInterface;
import android.os.Bundle;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity implements ContactsAdapter.Listener{

    RecyclerView rvContacts;
    ArrayList<Contacts> contacts;
    ContactsAdapter contactsAdapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        rvContacts=findViewById(R.id.rvContacts);
        contacts=Apps.initDataForContacts();
        contactsAdapter = new ContactsAdapter(contacts,MainActivity.this);
        rvContacts.setAdapter(contactsAdapter);

        rvContacts.setLayoutManager(new LinearLayoutManager(MainActivity.this, LinearLayoutManager.VERTICAL, false));
        rvContacts.addItemDecoration(new DividerItemDecoration(MainActivity.this, LinearLayoutManager.VERTICAL));

    }

    @Override
    public void onItemListener(Contacts contact) {
        AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
        builder.setTitle("Contacts");
        builder.setIcon(getDrawable(contact.getImg()));
        builder.setMessage(contact.getFname()+ ' '+contact.getLname()+ '\n'+ contact.getPhone());
        builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
            }
        });
        AlertDialog alertDialog = builder.create();
        alertDialog.show();

    }
}