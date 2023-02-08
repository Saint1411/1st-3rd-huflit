package anhduy.dmt.doanhduy_note;

import android.annotation.SuppressLint;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.text.DateFormat;
import java.util.ArrayList;

public class NoteAdapter extends RecyclerView.Adapter<NoteAdapter.NoteVH> {
    ArrayList<Note> notes;
    Listener listener;
    public NoteAdapter(ArrayList<Note> notes, Listener listener) {
        this.notes = notes;
        this.listener = listener;
    }

    @NonNull
    @Override
    public NoteAdapter.NoteVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.note_row, parent,false);
        return new NoteVH(view);
    }

    @Override
    public void onBindViewHolder(@NonNull NoteVH holder,int position) {
        Note note = notes.get(position);
        holder.titleOutput.setText(note.getTilte());
        holder.contentOutput.setText(note.getContent());
        holder.timeOutput.setText(note.getTime());
//        String formatDate = DateFormat.getDateTimeInstance().format(note.time);
//        holder.timeOutput.setText(formatDate);

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                listener.OnItemListener(position,note);
            }
        });
    }

    @Override
    public int getItemCount() {
        return notes.size();
    }

    public class NoteVH extends RecyclerView.ViewHolder{
        TextView titleOutput, contentOutput, timeOutput;

        public NoteVH(@NonNull View itemView) {
            super(itemView);
            titleOutput=itemView.findViewById(R.id.titleOuput);
            contentOutput=itemView.findViewById(R.id.contentOuput);
            timeOutput=itemView.findViewById(R.id.timeOuput);
        }
    }

    public void addNote(Note note){
        notes.add(note);
        notifyDataSetChanged();
    }
    public void editNote(Note note, int pos){
        notes.set(pos, note);
        notifyDataSetChanged();
    }
    interface Listener{
        void OnItemListener(int pos, Note note);
    }
}
