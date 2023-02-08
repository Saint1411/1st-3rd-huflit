package com.example.toeic.introduce;

import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentStatePagerAdapter;
import androidx.viewpager.widget.ViewPager;

import com.example.toeic.R;

import me.relex.circleindicator.CircleIndicator;

public class IntroActivity extends AppCompatActivity {
    TextView tvSkip;
    ViewPager viewPager;
    RelativeLayout layoutBottom;
    CircleIndicator indicator;
    LinearLayout layoutNext;
    ViewPageAdapter viewPageAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_intro);

        initUI();

        viewPageAdapter=new ViewPageAdapter(getSupportFragmentManager(), FragmentStatePagerAdapter.BEHAVIOR_RESUME_ONLY_CURRENT_FRAGMENT);
        viewPager.setAdapter(viewPageAdapter);
        indicator.setViewPager(viewPager);

        //tạo sự kiện lướt
        viewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                if(position==2){
                    tvSkip.setVisibility(View.GONE);
                    layoutBottom.setVisibility(View.GONE);
                }
                else{
                    tvSkip.setVisibility(View.VISIBLE);
                    layoutBottom.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
    }

    private void initUI(){
        tvSkip= findViewById(R.id.tvSkip);
        viewPager=findViewById(R.id.viewPage);
        layoutBottom=findViewById(R.id.layoutBottom);
        indicator=findViewById(R.id.indicator);
        layoutNext=findViewById(R.id.layout_next);

        //Đến fragment cuối cùng (2)
        tvSkip.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                viewPager.setCurrentItem(2);
            }
        });
        layoutNext.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(viewPager.getCurrentItem() <2){
                    viewPager.setCurrentItem(viewPager.getCurrentItem() +1);
                }
            }
        });
    }
}