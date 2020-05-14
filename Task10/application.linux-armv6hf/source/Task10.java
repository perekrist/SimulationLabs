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

public class Task10 extends PApplet {

float[] p = { 0.1f, 0.2f, 0.1f, 0.3f, 0.1f, 0.2f};

public void setup() {
  
  textSize(20);
  noLoop();
}

public void draw() { 
  textAlign(CENTER);
  textSize(15);
  background(82, 20, 193);
  text("Dice answer is...", 100, 150); 
  int answer = alg();
  text(answer, 180, 150);
  
  for(int i = 0; i < p.length; i++) {
    text(i, i * 80 + 30, 80);
    text(p[i], i * 80 + 30, 100);
  }
}

public int alg() {
  float a = random(1);
  for(int k = 0; k < p.length; k++) {
    a -= p[k];
    if(a <= 0) {
      return k;
    }
  }
  return 0;
}

public void keyPressed() {
  redraw();
}
  public void settings() {  size(500, 200); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Task10" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
