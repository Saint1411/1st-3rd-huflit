package com.example.doanhduy;

public class Country {
    int id;
    String name;
    int image;
    long population;
    String description;
    double latitude;
    double longitude;
    String capital;
    String independence;
    String currency;

    public Country(int id, String name, int image, long population, String description, double latitude, double longitude, String capital, String independence, String currency) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.population = population;
        this.description = description;
        this.latitude = latitude;
        this.longitude = longitude;
        this.capital = capital;
        this.independence = independence;
        this.currency = currency;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getImage() {
        return image;
    }

    public void setImage(int image) {
        this.image = image;
    }

    public long getPopulation() {
        return population;
    }

    public void setPopulation(long population) {
        this.population = population;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getCapital() {
        return capital;
    }

    public void setCapital(String capital) {
        this.capital = capital;
    }

    public String getIndependence() {
        return independence;
    }

    public void setIndependence(String independence) {
        this.independence = independence;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }
}
