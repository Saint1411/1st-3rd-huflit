package com.example.buichicuong_bt3;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;

import com.google.android.material.bottomsheet.BottomSheetDialog;

public class InfoDialogBottomSheet extends BottomSheetDialog {
    TextView txFullName, txPhone, txEmail, txBirthday;
    ImageView imImage;
    ImageButton btnClose, btnEdit, btnDelete;
    ActivityResultLauncher mLauncher;
    PhoneAdapter contactAdapter;
    Phone contact;
    public InfoDialogBottomSheet(@NonNull Context context, Phone contact, ActivityResultLauncher mLauncher, PhoneAdapter contactAdapter) {
        super(context);
        this.contact = contact;
        this.mLauncher = mLauncher;
        this.contactAdapter = contactAdapter;
    }
    public void findView(){
        View view = getLayoutInflater().inflate(R.layout.details_layout, null);
        txFullName = view.findViewById(R.id.fullName);
        txPhone = view.findViewById(R.id.txPhone);
        txEmail = view.findViewById(R.id.txEmail);
        txBirthday = view.findViewById(R.id.txBirthday);
        imImage = view.findViewById(R.id.userImage);
        btnClose = view.findViewById(R.id.cancelBtn);
        btnClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dismiss();
            }
        });
        btnEdit = view.findViewById(R.id.editBtn);
        btnDelete = view.findViewById(R.id.deleteBtn);
        btnEdit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getContext(),AddEditActivity.class);
                intent.putExtra("contact",contact);
                intent.putExtra("flag",2);
                mLauncher.launch(intent);
                dismiss();
            }
        });
        btnDelete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
                builder.setTitle("Contacts");
                builder.setMessage("Delete ".concat(contact.getFullName()).concat(" ?"));
                builder.setNegativeButton("No", (dialogInterface, i) -> {
                    dialogInterface.cancel();

                });
                builder.setPositiveButton("Yes", (dialogInterface, i) -> {
                    contactAdapter.deleteContact(contact);
                    dialogInterface.dismiss();
                    dismiss();
                });
                AlertDialog alertDialog = builder.create();
                alertDialog.show();


            }
        });

        txFullName.setText(contact.getFullName());
        txEmail.setText(contact.getEmail());
        txPhone.setText(contact.getPhoneNumber());
        imImage.setImageResource(contact.getAvatar());
        txBirthday.setText(contact.getBirthday());
        setContentView(view);
    }
}
