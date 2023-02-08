package anhduy.dmt.contracts;

import android.content.Intent;

import androidx.activity.result.ActivityResultLauncher;

import java.io.Serializable;

public class Vocabulary implements Serializable {
    int id;
    int imgWord;
    String word;
    String phonetic;
    String typeWord;
    String description;


    public Vocabulary(int id, int img, String word, String phonetic, String typeWord, String description) {
        this.id = id;
        this.imgWord = img;
        this.word = word;
        this.phonetic = phonetic;
        this.typeWord = typeWord;
        this.description=description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getImgWord() {
        return imgWord;
    }

    public void setImgWord(int imgWord) {
        this.imgWord = imgWord;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
