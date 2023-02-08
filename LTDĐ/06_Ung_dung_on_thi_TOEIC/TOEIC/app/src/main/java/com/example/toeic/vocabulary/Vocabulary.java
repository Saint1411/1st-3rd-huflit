package com.example.toeic.vocabulary;

import android.graphics.Bitmap;

public class Vocabulary {
    //int imgVocab;
    //Bitmap imgVocab;
    byte[] imgVocab;
    String topic, numberOfWords;
    int topicNumber;

//    public Vocabulary(Bitmap imgVocab, String topic, String numberOfWords,int topicNumber) {
//        this.imgVocab = imgVocab;
//        this.topic = topic;
//        this.numberOfWords = numberOfWords;
//        this.topicNumber = topicNumber;
//    }
//
//    public Bitmap getImgVocab() {
//        return imgVocab;
//    }
//
//    public void setImgVocab(Bitmap imgVocab) {
//        this.imgVocab = imgVocab;
//    }


    public Vocabulary(byte[] imgVocab, String topic, String numberOfWords, int topicNumber) {
        this.imgVocab = imgVocab;
        this.topic = topic;
        this.numberOfWords = numberOfWords;
        this.topicNumber = topicNumber;
    }

    public byte[] getImgVocab() {
        return imgVocab;
    }

    public void setImgVocab(byte[] imgVocab) {
        this.imgVocab = imgVocab;
    }

    public int getTopicNumber() {
        return topicNumber;
    }

    public void setTopicNumber(int topicNumber) {
        this.topicNumber = topicNumber;
    }



    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getNumberOfWords() {
        return numberOfWords;
    }

    public void setNumberOfWords(String numberOfWords) {
        this.numberOfWords = numberOfWords;
    }
}
