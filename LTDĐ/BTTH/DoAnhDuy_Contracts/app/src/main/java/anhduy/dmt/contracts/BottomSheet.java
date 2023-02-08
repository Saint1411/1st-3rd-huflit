package anhduy.dmt.contracts;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.annotation.NonNull;

import com.google.android.material.bottomsheet.BottomSheetDialog;

import anhduy.dmt.contracts.Favorite.FavoriteActivity;

public class BottomSheet extends BottomSheetDialog {

    TextView tvTitle, tvWordIn4, tvPhoneticIn4, tvTypeIn4, tvDescription;
    ImageView imgIn4, imgClose, imgHeart;
    Vocabulary vocabulary;
    ActivityResultLauncher mlaucher;
    VocabularyAdapter vocabularyAdapter;

    public BottomSheet(@NonNull Context context, Vocabulary vocabulary, ActivityResultLauncher mlaucher, VocabularyAdapter vocabularyAdapter) {
        super(context);
        this.vocabulary =vocabulary;
        this.mlaucher=mlaucher;
        this.vocabularyAdapter=vocabularyAdapter;
    }

    public void FindView(){
        View view=getLayoutInflater().inflate(R.layout.infor_word, null);
        tvTitle=view.findViewById(R.id.tvTitle);
        tvWordIn4 = view.findViewById(R.id.tvWordIn4);
        tvPhoneticIn4 =view.findViewById(R.id.tvPhoneticIn4);
        tvTypeIn4 = view.findViewById(R.id.tvTypeIn4);
        tvDescription=view.findViewById(R.id.tvDescription);

        imgIn4= view.findViewById(R.id.imgIn4);
        imgClose=view.findViewById(R.id.imgClose);
        imgClose.setOnClickListener(v -> {
            this.dismiss();
        });
        imgHeart=view.findViewById(R.id.imgHeart);
        imgHeart.setOnClickListener( v -> {

//            vocabularyAdapter.deleteFavorite(vocabulary);
//            dismiss();
            Intent intent = new Intent(getContext(), FavoriteActivity.class);
            intent.putExtra("Favorite", vocabulary);
            mlaucher.launch(intent);
            dismiss();
        });

        tvTitle.setText(vocabulary.getWord());
        imgIn4.setImageResource(vocabulary.getImgWord());
        tvWordIn4.setText(vocabulary.getWord());
        tvPhoneticIn4.setText(vocabulary.getPhonetic());
        tvTypeIn4.setText(vocabulary.getTypeWord());
        tvDescription.setText(vocabulary.getDescription());
        setContentView(view);
    }

}
