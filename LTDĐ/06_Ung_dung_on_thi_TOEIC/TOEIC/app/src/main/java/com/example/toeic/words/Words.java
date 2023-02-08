package com.example.toeic.words;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

public class Words implements Serializable {
    public int id;
    public int topicNumber;
    public String word;
    public String phonetic;
    public String typeWord;
    public int favorite;
    public int history;
    //public transient Bitmap imgWord;
    public byte[] imgWord;
    public String description;


    public Words(int id, int topicNumber, String word, String phonetic, String typeWord, int favorite, int history, byte[] imgWord,String description) {
        this.id = id;
        this.topicNumber = topicNumber;
        this.word = word;
        this.phonetic = phonetic;
        this.typeWord = typeWord;
        this.favorite = favorite;
        this.history = history;
        this.imgWord = imgWord;
        this.description = description;
    }

    public byte[] getImgWord() {
        return imgWord;
    }

    public void setImgWord(byte[] imgWord) {
        this.imgWord = imgWord;
    }


    public int getHistory() {
        return history;
    }

    public void setHistory(int history) {
        this.history = history;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getFavorite() {
        return favorite;
    }

    public void setFavorite(int favorite) {
        this.favorite = favorite;
    }
    public int getTopicNumber() {
        return topicNumber;
    }

    public void setTopicNumber(int topicNumber) {
        this.topicNumber = topicNumber;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public String getPhonetic() {
        return phonetic;
    }

    public void setPhonetic(String phonetic) {
        this.phonetic = phonetic;
    }

    public String getTypeWord() {
        return typeWord;
    }

    public void setTypeWord(String typeWord) {
        this.typeWord = typeWord;
    }
}
