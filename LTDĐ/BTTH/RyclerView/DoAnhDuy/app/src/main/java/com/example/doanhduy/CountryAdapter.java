package com.example.doanhduy;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;

import de.hdodenhof.circleimageview.CircleImageView;

public class CountryAdapter extends RecyclerView.Adapter<CountryAdapter.CountryVH> {

    ArrayList<Country> countries;
    Listener listener;

    public CountryAdapter(ArrayList<Country> countries, Listener listener) {
        this.countries = countries;
        this.listener = listener;
    }

    @NonNull
    @Override
    public CountryAdapter.CountryVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.country_row, parent,false);
        return new CountryVH(view);
    }

    @Override
    public void onBindViewHolder(@NonNull CountryAdapter.CountryVH holder, int position) {
        Country country = countries.get(position);
        holder.imgFlag.setImageResource(country.getImage());
        holder.txName.setText(country.getName());
        holder.txCapital.setText("Capital: ".concat(country.getCapital()));

        NumberFormat numberFormatter = NumberFormat.getInstance(Locale.US);
        numberFormatter.setMinimumFractionDigits(2);
        holder.txPopulation.setText("Population: ".concat(numberFormatter.format(country.getPopulation())));
        holder.txLatLong.setText("Lat: ".concat(numberFormatter.format(country.getLatitude())).concat(" \nLong: ".concat(numberFormatter.format(country.getLongitude()))));
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                listener.onItemListener(country);
            }
        });
    }

    @Override
    public int getItemCount() {
        return countries.size();
    }
    class CountryVH extends RecyclerView.ViewHolder{
        CircleImageView imgFlag;
        TextView txName, txCapital, txPopulation, txLatLong;

        public CountryVH(@NonNull View itemView) {
            super(itemView);
            imgFlag = itemView.findViewById(R.id.imgFlag);
            txName = itemView.findViewById(R.id.txName);
            txCapital = itemView.findViewById(R.id.txCapital);
            txPopulation = itemView.findViewById(R.id.txPopulation);
            txLatLong = itemView.findViewById(R.id.txLatLong);

        }
    }
    interface Listener{
        void onItemListener(Country country);
    }

}
