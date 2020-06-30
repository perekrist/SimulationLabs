float lamda1 = 0;
float lamda2 = 0;

int T = 0;
int n = 0;

Simulator simulator;


void setup() {
  size(700, 600);
  background(100);
  textSize(20);
  
  simulator = new Simulator(T, n, lamda1, lamda2);
  simulator.Start();
}

void draw() {
  background(255);
  
  text("Average: " + simulator.Average + " (error = " + simulator.AverageError * 100 + "%)", 100, 100);
  text("Variance: " + simulator.Variance + " (error = " + simulator.VarianceError * 100 + "%)", 120 ,100);
  text("ChiSquared: " + simulator.ChiSquare + " <= " + simulator.CriticalValue + " is " + simulator.ChiSquareTest, 140, 100);
}

void alg(float lamda) {
  p = (pow((lamda * T), n) / fact(n)) * pow(exp(1), -lamda * T); 
}

static final int fact(int num) {
  return num == 1? 1 : fact(num - 1)*num;
}

class Simulator {
  int random = random();

  public Simulator(double time, int n, double lambda1, double lambda2) {
    Time = time;
    N = n;
    ALambda = lambda1 + lambda2;

    AStream = new AggregatedStream(lambda1, lambda2);
  }

 double Time;
 int N;
 double ALambda;
 AggregatedStream AStream;

 double Average;
 double AverageError;
 double Variance;
 double VarianceError;

 double ChiSquare;
 boolean ChiSquareTest;
 double CriticalValue;

 double[] Probabilities;
 double[] TProbs;

 class Stream {
   public Stream(double lambda) {
     Lambda = lambda;

     Frequency = {};
   }

   double Lambda;
   int[] Frequency;

   int Process(double time) {
     double a = 0;
     int n = 0;

     while(true) {
       a += -random() / Lambda;

       if (a > time) break;

       n++;
    }

   Frequency[n]++;

   return n;
   }
  }

class AggregatedStream {
   public AggregatedStream(double lambda1, double lambda2) {
      Stream1 = new Stream(lambda1);
      Stream2 = new Stream(lambda2);

      Frequency = {};
    }

   Stream Stream1;
   Stream Stream2;
   int[] Frequency;

   void Process(double time) {
     int n1 = Stream1.Process(time);
     int n2 = Stream2.Process(time);

     Frequency[n1 + n2]++;
   }

   double[] GetFrequency() {
    double[] res = new double[Frequency[Frequency.length -1]+1];
    for (int i = 0; i < res.length; i++) {
      res[i] = Frequency.contains(i) ? Frequency[i] : 0;
    }

    return res;
    }
  }

  void Start() {
    for (int i = 0; i < N; i++) {
       AStream.Process(Time);
    }

    double[] frequency = AStream.GetFrequency();
    Probabilities = EmpiricalProbs(frequency, N);
    TProbs = TheoreticalProbs(ALambda, Time, Probabilities.length);

    Average = 0;
    double E = 0;
    for (int i = 0; i < Probabilities.length; i++) {
      Average += Probabilities[i] * i;
       E += TProbs[i] * i;
     }
     AverageError = abs((Average - E) / E);

     Variance = 0;
     double D = 0;
     for (int i = 0; i < Probabilities.length; i++) {
      Variance += Probabilities[i] * i * i;
      D += TProbs[i] * i * i;
     }
     Variance -= Average * Average;
     D -= E * E;
     VarianceError = abs((Variance - D) / D);

     ChiSquare = 0;
     for (int i = 0; i < Probabilities.length; i++) {
       ChiSquare += (frequency[i] - N * TProbs[i]) * (frequency[i] - N * TProbs[i]) / (N * TProbs[i]);
      }

      if (Probabilities.length > 1) {
        CriticalValue = ChiSquared.InvCDF(Probabilities.length - 1, 1 - 0.05);
         if (ChiSquare <= CriticalValue) ChiSquareTest = true;
         else ChiSquareTest = false;
      }
    }

    double[] EmpiricalProbs(double[] frequency, int N) {
      double[] probs = new double[frequency.length];
      for (int i = 0; i < probs.length; i++) {
         probs[i] = frequency[i] / N;
      }

      return probs;
    }

    double[] TheoreticalProbs(double lambda, double T, int n) {
      double[] probs = new double[n];
      for (int i = 0; i < n; i++) {
         probs[i] = pow(lambda * T, i) / Factorial(i) * exp(-lambda*T);
      }

     return probs;
    }

    int Factorial(int n) {
     return (n == 1 || n == 0) ? 1 : n * Factorial(n - 1);
    }
 }
