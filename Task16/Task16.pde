NormalDistribution NB;

void setup() {
  size(700, 600);
  background(100);
  textSize(20);
  
  NB = new NormalDistribution();
}

void draw() {
  background(255);
  for (int i = 0; i < 3; i++) {
    var method = probsMethods[i];
    text(" (error = " + method.AverageError * 100 + "%)", 100, 100);
    text(method.Average + aError, 120, 100);
    text(method.Variance + " (error = " + method.VarianceError * 100 + "%)", 140, 100);
    text(method.Time.Ticks / (TimeSpan.TicksPerMillisecond / 1000) + "mcs", 160, 100);
  
    text(method.ChiSquare + " <= " + method.CriticalValue, 180, 100);
  }
}

class NormalDistribution {
    public abstract class Method {
      int random = random();

      public Method(float mean, float variance, int N) {
        var start = now();
        Generate(mean, variance, N);
        var end = now();
        Time = end - start;

        CountProbs(mean, variance, N);
        CountParameters( mean, variance, N);
        TheoreticalProbs(mean, variance, N);
      }

      TimeSpan Time;

      float Average;
      float AverageError;
      float Variance;
      float VarianceError;

      float ChiSquare;
      boolean ChiSquareTest;
      float CriticalValue;

      float[] Probabilities;
      float[] TProbabilities;
      float[] Randvariables;
      float[] Frequency;
      float Interval;
      void Generate(float mean, float variance, int N);

      void CountProbs(float mean, float variance, int N) {
        Randvariables.sort();

        Frequency = {};

        int m = (int)log(N) + 1;
        float min = Randvariables.first();
        float max = Randvariables.last();
        Interval = (max - min) / m;
        int k = 0;
        for (float i = min; i <= max; i += Interval) {
          var x = i;
          Frequency[x] = 0;
          while (k < Randvariables.length && Randvariables[k] <= i + Interval / 2) {
            Frequency[x] += 1;
            k++;
          }
        }

        Probabilities = {};
        for (float i = min; i <= max; i += Interval) {
          Probabilities[i] = (float)Frequency[i] / N;
        }
      }

      void CountParameters(float mean, float variance, int N) {
        Average = 0;
        foreach (var x in Randvariables) {
          Average += x;
        }
        Average /= N;
        if (mean > 0)
          AverageError = abs((Average - mean) / mean);

        Variance = 0;
        foreach (var x in Randvariables) {
          Variance += x * x;
        }
        Variance /= N;
        Variance -= Average * Average;
        VarianceError = abs((Variance - variance) / variance);

        ChiSquare = 0;

        foreach (var f in Frequency) {
          var p = Interval / (float)(sqrt((double)variance) * sqrt(2 * PI))
            * (float)exp((double)(-(f.Key - mean) * (f.Key - mean) / (2 * variance)));
          ChiSquare += (f.Value - N * p) * (f.Value - N * p) / (N * p);
        }

        CriticalValue = (float)ChiSquared.InvCDF(Probabilities.Count - 1, 1 - 0.05);
        if (ChiSquare <= CriticalValue) ChiSquareTest = true;
        else ChiSquareTest = false;
      }

      void TheoreticalProbs(float mean, float variance, int N) {
        var sigma = sqrt((double)variance);

        float min = Randvariables.First();
        float max = Randvariables.Last();
        TProbabilities = {};
        for (float i = min; i <= max; i += 0.1M) {
          var y = 1 / (float)(sigma * sqrt(2 * PI)) * (float)exp((double)(-(i - mean) * (i - mean) / (2 * variance)));
          TProbabilities.Add(i, y);
        }
      }
    }

    class SummationMethod : Method {
      SummationMethod(float mean, float variance, int N) : base(mean, variance, N) { }
      void Generate(float mean, float variance, int N) {
        float sigma = (float)sqrt((double)variance);

        Randvariables = new float[N];

        var start = now();
        for (int i = 0; i < N; i++) {
          for (int j = 0; j < 12; j++) {
            Randvariables[i] += (float)random();
          }
          Randvariables[i] -= 6;

          Randvariables[i] = sigma * Randvariables[i] + mean;
        }
      }
    }

    class MoreAccurateSummation : Method {
      public MoreAccurateSummation(float mean, float variance, int N) : base(mean, variance, N) { }
      void Generate(float mean, float variance, int N){
        float sigma = (float)sqrt((double)variance);

        Randvariables = new float[N];
        for (int i = 0; i < N; i++) {
          for (int j = 0; j < 12; j++) {
            Randvariables[i] += (float)random();
          }
          Randvariables[i] -= 6;
          Randvariables[i] = Randvariables[i] + ((float)pow((double)Randvariables[i], 3) - 3 * Randvariables[i]) / 240;

          Randvariables[i] = sigma * Randvariables[i] + mean;
        }
      }
    }

    class BoxMullerMethod : Method {
      BoxMullerMethod(float mean, float variance, int N) : base(mean, variance, N) { }
      void Generate(float mean, float variance, int N) {
        float sigma = (float)Math.Sqrt((double)variance);

        Randvariables = new float[N];
        for (int i = 0; i < N; i++) {
          float a1 = random();
          float a2 = random();
          Randvariables[i] = (float)(sqrt(-2 * log(a1)) * cos(2 * PI * a2));
          var z1 = sqrt(-2 * log(a1)) * sin(2 * PI * a2);

          Randvariables[i] = sigma * Randvariables[i] + mean;
        }
      }
    }
  }
}
