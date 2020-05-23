int n = 12;
int m;
int N = 1000; 
float E_ = 0;
float D_ = 0;
float dE = 0;
float dD = 0;
float Xi = 0;
float[] c = new float[N];
int[] k;

int num = 1;

void setup() {
  size(700, 600);
  textSize(20);
  //m = int(sqrt(N)) + 1;
  m = 20;
  k = new int[m];
  noLoop();
  prepare();
}

void prepare() {
  E_ = 0;
  D_ = 0;
  Xi = 0;
  for(int i = 0; i < m; i++) {
    k[i] = 0;
  }
  
  for(int i = 0; i < N; i++) {
    c[i] = 0;
  }
}

void draw() {
  prepare();
  if(num == 1) {
    gen1();
  } else if(num == 2) {
    gen2();
  } else if(num == 3) {
    gen2();
  }
  alg();
  
  textSize(20);
  background(100);
  text("Generator  " + num, 200, 20); 
  text("N = " + N, 20, 20);  
  text("Average: " + E_, 20, 40);
  text("Variance: " + D_, 20, 60);
  text("Chi-squared: " + Xi, 20, 80);
  
  textSize(10);
  for(int i = 0; i < m; i++) {
    if(k[i] != 0) {
      text("", (i * 40) + 20, height - ((k[i] * 2) + 20));
      rect((i * 40) + 20, (height - k[i] * 2) - 10, 40, k[i] * 2 - 10);
      text(k[i], (i * 40) + 40, 595);
    }
  }
  
}

void gen1() {
  for(int j = 0; j < N; j++) {
    float sum = 0;
    for(int i = 0; i < n; i++) {
      sum += random(0, 1);
    }
    c[j] = (sum - 6) * 2;
  }
}

void gen2() {
  gen1();
  
  for(int i = 0; i < c.length; i++) {
    c[i] += (c[i] * c[i] * c[i] - 3 * c[i]) / 240;
  }
}

void gen3() {
  for(int i = 0; i < N; i++) {
    c[i] = sqrt(-2 * (log(random(0, 1) + log(exp(1)) )) ) * cos(2 * PI * random(0, 1));
  }
}

void alg() {
   c = sort(c);
  int temp1 = round(c[0]);
  int j = 0;
  for(int i = 0; i < N; i++) {
    
      int temp2 = round(c[i]);
      if(temp2 > temp1) {
        j++;
        temp1 = temp2;
      } else {
        k[j]++;
      }
  }
  
  for (int i = 0; i < k.length; i++) {
    E_ += k[i];
  }
  E_ = E_ / N;
  
  for (int i = 0; i < k.length; i++) {
    D_ +=  i * i;
  }
  D_ = D_ / N;
  D_ = D_ - E_ * E_;
  
  for (int i = 0; i < m; i++) {
    if(k[i] != 0) {
      Xi += (i * i) / k[i];
    }
  }
  Xi -= N;
}

void keyPressed() {
  if(key == '1') {
    num = 1;
  } else if(key == '2') {
    num = 2;
  } else if(key == '3') {
    num = 3;
  }
  
  redraw();
}
