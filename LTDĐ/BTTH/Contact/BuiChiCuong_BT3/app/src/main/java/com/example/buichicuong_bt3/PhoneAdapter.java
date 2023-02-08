package com.example.buichicuong_bt3;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import de.hdodenhof.circleimageview.CircleImageView;

public class PhoneAdapter extends RecyclerView.Adapter<PhoneAdapter.PhoneVH> implements Filterable {
    ArrayList<Phone> contactsFilter;
    ArrayList<Phone> contacts;
    Listener listener;
    public PhoneAdapter(ArrayList<Phone> contacts, Listener listener) {
        this.contacts = contacts;
        this.listener = listener;
        this.contactsFilter = contacts;
    }

    @NonNull
    @Override
    public PhoneVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.layout_row,parent, false);
        return new PhoneVH(view);
    }

    @Override
    public void onBindViewHolder(@NonNull PhoneVH holder, int position) {
        Phone phone = contactsFilter.get(position);
        holder.imgAvatar.setImageResource(phone.getAvatar());
        holder.tvName.setText(phone.getFname() +" " + phone.getLname());
        holder.tvPhoneNumber.setText(phone.getPhoneNumber());
        holder.tvEmail.setText(phone.getEmail());
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                listener.onItemListener(phone, position);
            }
        });
    }

    @Override
    public int getItemCount() {
        return contactsFilter.size();
    }

    public void addContact(Phone contact) {
        contactsFilter.add(contact);
        notifyDataSetChanged();
    }

    public void editContact(Phone contact, int position) {
        contactsFilter.set(position,contact);
        notifyDataSetChanged();
    }
    public void deleteContact(Phone contact) {
        contactsFilter.remove(contact);
        notifyDataSetChanged();
    }

    @Override
    public Filter getFilter() {
        return new ContactFilter();
    }

    class PhoneVH extends RecyclerView.ViewHolder{
      CircleImageView imgAvatar;
      TextView tvName, tvPhoneNumber, tvEmail;
      public PhoneVH(@NonNull View itemView) {
          super(itemView);
          imgAvatar = itemView.findViewById(R.id.imgAvatar);
          tvName = itemView.findViewById(R.id.tvName);
          tvPhoneNumber = itemView.findViewById(R.id.tvPhone);
          tvEmail = itemView.findViewById(R.id.tvEmail);
      }
    }
    interface Listener{
     void onItemListener(Phone phone, int position);
    }
    class ContactFilter extends Filter{

        @Override
        protected FilterResults performFiltering(CharSequence charSequence) {
            String charString = charSequence.toString();
            if (charString.isEmpty()){
                contactsFilter = contacts;
            } else {
                List<Phone> filteredList = new ArrayList<>();
                for (Phone row : contacts){
                    if (row.getFname().toLowerCase().contains(charString.toLowerCase()) ||
                            row.getLname().contains(charSequence)||
                            row.getPhoneNumber().contains(charSequence)){
                        filteredList.add(row);
                    }
                }
                contactsFilter = (ArrayList<Phone>) filteredList;
            }

            FilterResults filterResults = new FilterResults();
            filterResults.values = contactsFilter;
            return filterResults;
        }

        @Override
        protected void publishResults(CharSequence charSequence, FilterResults filterResults) {
            contactsFilter = (ArrayList<Phone>) filterResults.values;
            notifyDataSetChanged();
        }
    }
}
