package anhduy.dmt.contracts.In4Word;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.Random;

import anhduy.dmt.contracts.Favorite.FavoriteActivity;
import anhduy.dmt.contracts.R;
import anhduy.dmt.contracts.Vocabulary;

public class InfoActivity extends AppCompatActivity {
    ImageView imgWord4, imgHeart4;
    TextView tvWord4;
    TextView tvPhonetic4;
    TextView tvType4;
    TextView tvDes4;
    Vocabulary vocabulary;
    ActivityResultLauncher mlaucher;
//    ActivityResultLauncher<Intent> Mlauncher = registerForActivityResult(
//            new ActivityResultContracts.StartActivityForResult(),
//            new ActivityResultCallback<ActivityResult>() {
//                @Override
//                public void onActivityResult(ActivityResult result) {
//                    if(result.getResultCode()==RESULT_OK){
//                        Intent intent = result.getData();
//                        assert intent != null;
//                        Vocabulary vocabulary =(Vocabulary) intent.getSerializableExtra("Info");
//                        tvWord4.setText(vocabulary.getWord());
//                        tvPhonetic4.setText(vocabulary.getPhonetic());
//                        tvType4.setText(vocabulary.getTypeWord());
//                        tvDes4.setText(vocabulary.getDescription());
//
//                    }
//                }
//            }
//    );



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_info);
        tvWord4=findViewById(R.id.tvWord4);
        tvPhonetic4=findViewById(R.id.tvPhonetic4);
        tvType4=findViewById(R.id.tvType4);
        tvDes4=findViewById(R.id.tvDes4);
        imgWord4 = findViewById(R.id.imgWord4);
        imgHeart4=findViewById(R.id.imgHeart4);
        Intent intent=getIntent();
        Bundle bundle=intent.getBundleExtra("Info");
        imgWord4.setImageResource(bundle.getInt("Img"));
        tvWord4.setText(bundle.getString("Word"));
        tvPhonetic4.setText(bundle.getString("Phonestic"));
        tvType4.setText(bundle.getString("Type"));
        tvDes4.setText(bundle.getString("Des"));

        imgHeart4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Vocabulary vocabularyF = new Vocabulary(vocabulary.getId(),
                        vocabulary.getImgWord(),
                        vocabulary.getWord(),
                        vocabulary.getPhonetic(),
                        vocabulary.getTypeWord(),
                        vocabulary.getDescription());
                //Intent intent1= new Intent(InfoActivity.this,FavoriteActivity.class);
//                Intent intent1 = new Intent();
//                intent1.putExtra("Favorite",vocabularyF);
//                setResult(RESULT_OK, intent1);


//                Bundle bundle1 = new Bundle();
//                bundle1.putSerializable("Favorite",vocabularyF);
//                intent1.putExtras(bundle1);
//                startActivity(intent1);


            }
        });
    }
}