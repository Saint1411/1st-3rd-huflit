package anhduy.dmt.doanhduy_bt03;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;


import java.util.ArrayList;


import de.hdodenhof.circleimageview.CircleImageView;

public class ContactsAdapter extends RecyclerView.Adapter<ContactsAdapter.ContactVH> {
    ArrayList<Contacts> contacts;
    Listener listener;

    public ContactsAdapter(ArrayList<Contacts> contacts, Listener listener) {
        this.contacts = contacts;
        this.listener = listener;
    }

    @NonNull
    @Override
    public ContactsAdapter.ContactVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.contact_row, parent,false);
        return new ContactVH(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ContactsAdapter.ContactVH holder, int position) {
        Contacts contact = contacts.get(position);
        holder.imgFlag.setImageResource(contact.getImg());
        holder.txFname.setText(contact.getFname());
        holder.txLname.setText(contact.getLname());
        holder.txPhone.setText(contact.getPhone());
        holder.txEmail.setText(contact.getEmail());
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                listener.onItemListener(contact);
            }
        });
    }

    @Override
    public int getItemCount() {
        return contacts.size();
    }

    class ContactVH extends RecyclerView.ViewHolder{
        CircleImageView imgFlag;
        TextView txFname, txLname, txPhone, txEmail;


        public ContactVH(@NonNull View itemView) {
            super(itemView);
            imgFlag = itemView.findViewById(R.id.imgFlag);
            txFname = itemView.findViewById(R.id.txFname);
            txLname = itemView.findViewById(R.id.txLname);
            txPhone = itemView.findViewById(R.id.txPhone);
            txEmail = itemView.findViewById(R.id.txEmail);
        }
    }
    interface Listener{
        void onItemListener(Contacts contact);
    }

}
