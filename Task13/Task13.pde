int N = 100; //10, 100, 1000, 10000 
float p = 0.5;
float E = 0;
float D_ = 0;
float dE = 0;
float dD = 0;
float Xi = 0;
float M = 0;

float[] pr = new float[N];

String sign = " < ";
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
  text("Variance: " + D_, 20, 60);
  text("Chi-squared: " + Xi + sign + "11.070" +  " is " + TF, 20, 80);
  
  textSize(15);
  for(int i = 0; i < N; i++) {
    rect((i * 4) + 10, (height - pr[i] * 200) - 10, 4, pr[i] * 200);
  }
  
}

void prepare() {
  for(int i = 0; i < N; i++) {
    pr[i] = pow(1 - p, i - 1);

  }
}

void alg() {
  for(int i = 0; i < N; i++) {
    pr[i] = pow(1 - p, i - 1);
    println(pr[i]*100);
  }
  
  for (int i = 0; i < pr.length; i++) {
    E += (pr[i] * i);
  }
  
  for (int i = 0; i < pr.length; i++) {
    D_ += i * i * pr[i];
  }
  
  
  for (int i = 0; i < pr.length; i++) {
    Xi += (i * i )/ (N * pr[i]);
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
