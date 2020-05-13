import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Task8 extends PApplet {

int mode = 1;

String[] answers = {"Yes.", "No.", "It's possible.", "Nope.", "For sure.", "Statistically improbable.", "True.", 
  "Doubtful.", "Stay optimistic!", "Don't count on it.", "That is to be expected.", "False.", 
  "The logical answer is yes.", "Probably not.", "It is likely."
};
float[] p = { 0.01f, 0.02f, 0.03f, 0.04f, 0.05f, 0.06f, 0.07f, 0.08f, 0.09f, 0.1f, 0.11f, 0.12f, 0.13f, 0.04f, 0.05f };

boolean orbMode = false;

public void setup() {
  
  textSize(20);
  noLoop();
}

public void draw() { 
  if (mode == 2) {
    background(167, 241, 255);
    if (orbMode == false) {
      fill(0);
      ellipse(250, 250, 400, 400);
      fill(255);
      ellipse(250, 110, 200, 90);
      noFill();
      strokeWeight(5);
      ellipse(250, 120, 100, 40);
      ellipse(250, 88, 75, 25);
    } else {
      int i = alg2();
      fill(0);
      ellipse(250, 250, 400, 400);
      fill(82, 20, 193);
      triangle(250, 110, 100, 310, 400, 310);
      fill(255);
      text(answers[i], 135, 300);
    }
  } else if (mode == 1) {
    background(82, 20, 193);
    text("Should I go to University today?", 100, 150); 
    boolean answer = alg1();
    text("Answer is...", 150, 200);
    if (answer) {
      text("YES!", 200, 300);
    } else {
      text("NO!", 200, 300);
    }
  }
  text("1 - «Tell me ‘yes’ or ‘no’», 2 - «Magic 8-Ball»", 20, 30);
  text("Press space button...", 20, 470);
}

public boolean alg1() {
  float a = random(1);
  if (a < 0.5f) {
    return true;
  } else {
    return false;
  }
}

public int alg2() {
  float a = random(1);
  for (int k = 0; k < answers.length; k++) {
    a -= p[k];
    if (a < 0) {
      return k;
    }
  }
  return p.length - 1;
}

public void keyPressed() {
  if (key == '1') {
    mode = 1;
  } else if (key == '2') {
    mode = 2;
  } else if (key == ' ') {
    if (mode == 2) {
      orbMode =! orbMode;
    }
  }
  redraw();
}
  public void settings() {  size(500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Task8" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
