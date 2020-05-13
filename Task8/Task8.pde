int mode = 1;

String[] answers = {"Yes.", "No.", "It's possible.", "Nope.", "For sure.", "Statistically improbable.", "True.", 
  "Doubtful.", "Stay optimistic!", "Don't count on it.", "That is to be expected.", "False.", 
  "The logical answer is yes.", "Probably not.", "It is likely."
};
float[] p = { 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.04, 0.05 };

boolean orbMode = false;

void setup() {
  size(500, 500);
  textSize(20);
  noLoop();
}

void draw() { 
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

boolean alg1() {
  float a = random(1);
  if (a < 0.5) {
    return true;
  } else {
    return false;
  }
}

int alg2() {
  float a = random(1);
  for (int k = 0; k < answers.length; k++) {
    a -= p[k];
    if (a < 0) {
      return k;
    }
  }
  return p.length - 1;
}

void keyPressed() {
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
