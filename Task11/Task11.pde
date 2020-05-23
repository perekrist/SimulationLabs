int m = 5;
float N = 20; //10, 100, 1000, 10000 
float n[] = new float[m];
float p_[] = new float[m];
float fr[] = new float[m];
float p[] = {0.1, 0.3, 0.1, 0.2, 0.3};
float E = 0;
float Var = 0;
float E_ = 0;
float D_ = 0;
float dE = 0;
float dD = 0;
float Xi = 0;

String sign = "";
String TF = "true";

void setup() {
  size(500, 500);
  textSize(20);
  alg();
}

void draw() {
  textSize(20);
  background(100);
  text("N = " + N, 20, 20);  
  text("Average: " + E, 20, 40);
  text("Variance: " + Var, 20, 60);
  text("Chi-squared: " + Xi + sign + "11.070" +  " is " + TF, 20, 80);
  
  textSize(15);
  for(int i = 0; i < m; i++) {
    if(n[i] * 10 <= 440) {
      text(fr[i], (i * (500 / m)) + 23, height - ((n[i] * 10) + 20));
      rect((i * (500 / m)) + 10, (height - n[i] * 10) - 10, 45, n[i] * 10 - 10);
    } else {
      text(fr[i], (i * (500 / m)) + 23, height - (440 + 20));
      rect((i * (500 / m)) + 10, (height - 440) - 10, 45, 430);
    }
    text(n[i], (i * (500 / m)) + 23, 495);
  }
  
}

void alg() {
  for(int i = 0; i < N; i++) {
   int k = int(random(m));
   n[k]++;
  }
  
  for(int i =0; i < m; i++) {
    fr[i] = n[i] / N;
  }
  
  for (int i = 0; i < p.length; i++) {
    E += (p[i] * i);
  }
  
  for (int i = 0; i < p.length; i++) {
    Var += (p[i] * i * i);
  }
  Var -= E * E;
  
  for (int i = 0; i < p_.length; i++) {
    p_[i] = n[i] / N;
  }
  
  for (int i = 0; i < p_.length; i++) {
    E_ += (p_[i] * i);
  }
  
  for (int i = 0; i < p_.length; i++) {
    D_ += (p_[i] * i * i);
  }
  D_ -= E_ * E_;
  
  dE = (E_ - E) / E;
  dD = (D_ - Var) / Var;
  
  for (int i = 0; i < p.length; i++) {
    Xi += (n[i] * n[i] )/ (N * p[i]);
  }
  Xi -= N;
  
  if (Xi > 11.070) {
   sign = " > ";
   TF = "false";
  } else {
   sign = " <= ";
   TF = "true";
  }
}
