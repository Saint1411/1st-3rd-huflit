package com.example.doanhduy;

import android.app.Application;

import java.util.ArrayList;

public class App extends Application {
    static ArrayList<Country> data;

    @Override
    public void onCreate() {
        super.onCreate();
        if(data==null) data=new ArrayList<>();
    }
    public static ArrayList<Country> InData(){
        data.add(new Country(1, "Estonia", R.drawable.estonia, 430805, "Pháp là nước lớn nhất Tây Âu và lớn thứ ba ở châu Âu và cũng là nước có lịch sử lâu đời ở châu Âu, ngoài ra, còn có vùng đặc quyền kinh tế lớn thứ hai trên thế giới. Trong hơn 500 năm qua, Pháp là 1 cường quốc có ảnh hưởng văn hóa, kinh tế, quân sự và chính trị mạnh mẽ ở châu Âu và trên toàn thế giới", 58.59527, 25.013607, "Tallinn","02/24","Euro"));
        data.add(new Country(2, "France", R.drawable.france, 430805, "WesternEurope,borderingtheBayofBiscayandEnglishChannel,betweenBelgiumandSpain,southeastoftheUK;borderingtheMediterraneanSea,betweenItalyandSpain", 58.59527, 25.013607, "Tallinn","02/24","Euro"));
        data.add(new Country(3, "Germany", R.drawable.germany, 430805, "CentralEurope,borderingtheBalticSeaandtheNorthSea,betweentheNetherlandsandPoland,southofDenmark", 58.59527, 25.013607, "Tallinn","02/24","Euro"));
        data.add(new Country(4, "Ireland", R.drawable.ireland, 430805, "WesternEurope,occupyingfive-sixthsoftheislandofIrelandintheNorthAtlanticOcean,westofGreatBritain", 58.59527, 25.013607, "Tallinn","02/24","Euro"));
        data.add(new Country(5, "Italy", R.drawable.italy, 430805, "EasternEurope,borderingtheBalticSeaandGulfofFinland,betweenLatviaandRussia", 58.59527, 25.013607, "Tallinn","02/24","Euro"));
        data.add(new Country(6, "PrincipalityofMonaco", R.drawable.monaco, 430805, "EasternEurope,borderingtheBalticSeaandGulfofFinland,betweenLatviaandRussia", 58.59527, 25.013607, "Tallinn","02/24","Euro"));
        data.add(new Country(7, "Nigeria", R.drawable.nigeria, 430805, "EasternEurope,borderingtheBalticSeaandGulfofFinland,betweenLatviaandRussia", 58.59527, 25.013607, "Tallinn","02/24","Euro"));
        data.add(new Country(8, "Poland", R.drawable.poland, 430805, "EasternEurope,borderingtheBalticSeaandGulfofFinland,betweenLatviaandRussia", 58.59527, 25.013607, "Tallinn","02/24","Euro"));
        data.add(new Country(9, "Russia", R.drawable.russia, 430805, "EasternEurope,borderingtheBalticSeaandGulfofFinland,betweenLatviaandRussia", 58.59527, 25.013607, "Tallinn","02/24","Euro"));
        return data;
    }
}
