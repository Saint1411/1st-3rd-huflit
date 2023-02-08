package com.example.toeic.favorite;

public class Favorite {
    int id;
    int imgWord;
    String word;
    String phonetic;
    String typeWord;

    public Favorite(int id, int imgWord, String word, String phonetic, String typeWord) {
        this.id = id;
        this.imgWord = imgWord;
        this.word = word;
        this.phonetic = phonetic;
        this.typeWord = typeWord;
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
}
