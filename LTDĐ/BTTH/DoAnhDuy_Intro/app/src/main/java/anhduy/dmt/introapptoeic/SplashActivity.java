package anhduy.dmt.introapptoeic;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

public class SplashActivity extends AppCompatActivity {
    private final String KEY_FIRST_INSTALL ="KEY_FIRST_INSTALL";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        SharedPreferences sharedPreferences = new SharedPreferences(this);

        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                if(sharedPreferences.getBoolenValue(KEY_FIRST_INSTALL)){
                    startActivity(MainActivity.class);
                }
                else{
                    startActivity(IntroActivity.class);
                    sharedPreferences.putBoolenValue(KEY_FIRST_INSTALL, true);
                }
            }
        },2000);
    }
    private void startActivity(Class<?> cls){
        Intent intent = new Intent(this, cls);
        startActivity(intent);
        finish();
    }
}