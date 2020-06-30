int currentDay, count;
double currentPrice, money;
GBM gbm;

double muValue = 0, sigmaValue = 0;

void setup() {
  size(700, 600);
  background(100);
  textSize(20);
  
  gbm = new GBM(currentPrice, 0.01, muValue, sigmaValue);
}

void draw() {
  background(255);
  
  currentDay += 1;
  currentPrice = gbm.GetNextRV();
  
  text("Count: " + count, 100, 100);
  text("Money: " + money, 120, 100);
}

class GBM {
  int random = random();
  GBM(double x0, double dt, double mu, double sigma) {
    Mu = mu;
    Sigma = sigma;
    dT = dt;
   }
   double[] X;
   double[] W;

   double Mu;
   double Sigma;
   double dT;

  double GetNextRV() {
   double wt = W.last() + sqrt(dT) * NormalVR();
   double x = X.last() * exp((Mu - Sigma * Sigma / 2) * dT + Sigma * wt);
   W.add(wt);
   X.add(x);
   return x;
  }

 double NormalVR() {
  double rv = 0;
   for (int j = 0; j < 12; j++){
     rv += random();
    }
    rv -= 6;
    rv += (pow(rv, 3) - 3 * rv) / 240;

    return rv;
   }
}

public void keyPressed() {
  if (keyCode == ' ') {
    //купить
    if (money - currentPrice > 0) {
      count += 1;
      money -= currentPrice;
    } else {
      text("no money", 430, 120);
      } else if (keyCode == '\n') {
    //продать
    if (count > 0) {
      count -= 1;
      money += currentPrice;
    } else {
      text("no actions", 430, 120);
    }
      }
  }
}
