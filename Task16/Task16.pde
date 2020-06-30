float k = 0.05f;
float price = 20;
float rnd;
float step;
float padding = 30;
ArrayList<Float> data = new ArrayList<Float>();
int tic = 50;
int t = 0;
float money = 1000;
int count = 0;


void setup() {
  size(700, 600);
  background(100);
  textSize(20);
}

void draw() {
  background(255);
  if (t < tic) {
    t += 1;
  } else {
    t = 0;
    step = (600 - padding) / data.size();
    rnd = random(0, 1);
    price = price * (1 + k * (rnd - 0.5f));
    data.add(price);
  }
  textSize(16);
  fill(0);
  text("price: " + price, 50, 60);
  text("money: " + money, 400, 60);
  text("count: " + count, 400, 90);
  for (int i = 1; i < data.size(); i++) {
      line(step * (i - 1) + 10, 500 - data.get(i - 1) * 10, step * i + 10, 500 - data.get(i) * 10);
  }
}

float[][] getProjection(float mu, float sigma, int years, int initialValue, int monthlyValue, float[] breaks) {
  float periodizedMu = mu / 12;
  float periodizedSigma = sigma / Math.sqrt(12);
  int periods = years * 12;
 
  float[][] result = {};
 
  for (int i = 0; i < periods; i++) {
     float value = initialValue + (monthlyValue * i);
     NormalDistribution normalDistribution = new NormalDistribution(periodizedMu * (i + 1), periodizedSigma * sqrt(i + 1));
     float bounds[] = new float[breaks.length];
     for (int j = 0; j < breaks.length; j++) {
        float normInv = normalDistribution.inverseCumulativeProbability(breaks[j]);
        bounds[j] = value * exp(normInv);
     }
     result.add(bounds);
  }
  return result;
}

public void keyPressed() {
  if (keyCode == ' ') {
    //купить
    if (money - price > 0) {
      count += 1;
      money -= price;
    } else {
      text("no money", 430, 120);
    }
  } else if (keyCode == '\n') {
    //продать
    if (count > 0) {
      count -= 1;
      money += price;
    } else {
      text("no actions", 430, 120);
    }
  }
}
