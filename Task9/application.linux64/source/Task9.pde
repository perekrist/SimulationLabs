int m = 5;
int N = 10; //10, 100, 1000, 10000 
float Statistics[] = new float[m];
float Frequency[] = new float[m];

void setup() {
  size(500, 500);
  textSize(20);
  for(int i = 0; i < m; i++) {
    Statistics[i] = 0;
    Frequency[i] = 0;
  }
  prepare();
}

void draw() {
  background(100);
  text("N = " + N, 30, 20);
  textAlign(CENTER);
  textSize(9);
  
  for(int i = 0; i < m; i++) {
    if(Statistics[i] * 10 <= 440) {
      text(Frequency[i], (i * (500 / m)) + 23, height - ((Statistics[i] * 10) + 20));
      rect((i * (500 / m)) + 10, (height - Statistics[i] * 10) - 10, 45, Statistics[i] * 10 - 10);
    } else {
      text(Frequency[i], (i * (500 / m)) + 23, height - (440 + 20));
      rect((i * (500 / m)) + 10, (height - 440) - 10, 45, 430);
    }
    text(Statistics[i], (i * (500 / m)) + 23, 495);
  }
  alg();  
}

void prepare() {
  for(int i = 0; i < N; i++) {
   int k = int(random(m));
   Statistics[k]++;
  }
  
  for(int i =0; i < m; i++) {
    Frequency[i] = Statistics[i] / N;
  }
}

void alg() {
  int k = int(random(m));
  Statistics[k]++;
  for(int i =0; i < m; i++) {
    Frequency[i] = Statistics[i] / N;
  }
  N++;
}
