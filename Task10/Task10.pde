float[] p = { 0.1, 0.2, 0.1, 0.3, 0.1, 0.2};

void setup() {
  size(500, 200);
  textSize(20);
  noLoop();
}

void draw() { 
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

int alg() {
  float a = random(1);
  for(int k = 0; k < p.length; k++) {
    a -= p[k];
    if(a <= 0) {
      return k;
    }
  }
  return 0;
}

void keyPressed() {
  redraw();
}
