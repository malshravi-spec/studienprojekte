//by Mohammed Alshravi
package com.example.taschenrechner;
//Hilfsquelle: Verfasser : Practical Coding; auf Youtube; Jahr : 2020; URL: https://www.youtube.com/watch?v=KFEtd7imXaI&list=WL&index=2
import androidx.appcompat.app.AppCompatActivity;
import org.mariuszgromada.math.mxparser.*;

import android.os.Bundle;
import android.text.SpannableStringBuilder;
import android.view.View;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {


    private EditText display;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        display = findViewById(R.id.textView2);
        display.setShowSoftInputOnFocus(false);

    }
//Zeichen im Textview ausgeben lassen
    private void updateText(String add){
        String old = display.getText().toString();
        int cursor = display.getSelectionStart();
        String left = old.substring(0, cursor);
        String right = old.substring(cursor);

        display.setText(String.format("%s%s%s", left, add, right));
        display.setSelection(cursor + 1 );
    }

    public void zero(View view){
        updateText("0");

    }
    public void one(View view){
        updateText("1");

    }
    public void two(View view){
        updateText("2");
    }
    public void three(View view){
        updateText("3");
    }
    public void four(View view){
        updateText("4");
    }
    public void five(View view){
        updateText("5");
    }
    public void six(View view){
        updateText("6");
    }
    public void seven(View view){
        updateText("7");
    }
    public void eight(View view){
        updateText("8");
    }
    public void nine(View view){
        updateText("9");
    }
    public void plus(View view){
        updateText("+");
    }
    public void minus(View view){
        updateText("-");
    }
    public void multiplikation(View view){
        updateText("*");
    }
    public void division(View view){
        updateText("/");
    }

//berechnen des Ergebnisses mithilfe der Bibliothek Mathparser
    public void ergebniss(View view){
        String userExp = display.getText().toString();
        Expression exp = new Expression(userExp);
        String result = String.valueOf(exp.calculate());

        display.setText(result);
        display.setSelection(result.length());
    }
	//Knopf C ersetzt das Display mit ""
    public void clear(View view){
        display.setText("");

    }
	//Knopf CE als backspace
    public void delete(View view){
        int cursor = display.getSelectionStart();
        int textlen = display.getText().length();

        if(cursor != 0 && textlen != 0){
            SpannableStringBuilder selection = (SpannableStringBuilder) display.getText();
            selection.replace(cursor - 1, cursor, "");
            display.setText(selection);
            display.setSelection(cursor -1);
        }
    }







}