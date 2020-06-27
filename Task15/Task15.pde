float[][] matrix = { {-0.4, 0.3, 0.1},
                     {0.4, -0.8, 0.4},
                     {0.1, 0.4, -0.5} };
                     
int timeStamp = 0;
int totalTime = 0;

int state = 0;
float[][] distribution = {};
float[][] testDistribution = {};

float average = 0;
float testAverage = 0;
float variance = 0;
float testVariance = 0;
float averageError = 0;
float varianceError = 0;

float[][] testTime = {};

PImage imgSunny, imgPartly_Cloudy, imgCloudy;

void setup() {
  size(700, 600);
  background(100);
  textSize(20);
  
  state = getState();
  
  
  imgSunny = loadImage("sunny.svg");
  imgPartly_Cloudy = loadImage("partly-cloudy.svg");
  imgCloudy = loadImage("cloudy.svg");
  
  timeStamp = second();
}


void draw() {
  background(100);
  alg();
  if(state == 0) {
    image(imgSunny, 0, 0, width/2, height/2);
  } else if(state == 1) {
    image(imgPartly_Cloudy, 0, 0, width/2, height/2);
  } else {
    image(imgCloudy, 0, 0, width/2, height/2);
  }
  
  text("Average Error: " + averageError * 100 + "%", 300, 300);
  text("Variance Error: " + varianceError * 100 + "%", 350, 300);
}

void alg() {
  int timePassed = second() - timeStamp;
  totalTime += timePassed;
  timeStamp = second();
  
  for(int i = 0; i < testTime.length; i++) {
    for(int j = 0; j < testTime[i].length; j++) {
      testDistribution[i][j] = testTime[i][j] / totalTime;
    }
  }
  
  average = 0;
  for(int i = 0; i < distribution.length; i++) {
    for(int j = 0; j < distribution[i].length; j++) {
      average += i * distribution[i][j];
    }
  }
  
  variance = 0;
  for(int i = 0; i < distribution.length; i++) {
    for(int j = 0; j < distribution[i].length; j++) {
      variance += i * average * i * average;
    }
  }
  
  variance /= distribution.length - 1;
  
  testAverage = 0;
  for(int i = 0; i < testDistribution.length; i++) {
    for(int j = 0; j < testDistribution[i].length; j++) {
      testAverage += i * testDistribution[i][j];
    }
  }
  
  testVariance = 0;
  for(int i = 0; i < testDistribution.length; i++) {
    for(int j = 0; j < testDistribution[i].length; j++) {
      testVariance += i * testAverage * i * testAverage;
    }
  }
  
  testVariance /= distribution.length - 1;
  
  averageError = (testAverage - average) / average;
  varianceError = (testVariance - variance) / variance;
  
  changeState();
  
}

int getState() {
  float[] parametrs = {};
  float[] terms = {};
  
  for(int i = 0; i < matrix.length; i++) {
    float[] parametr;
    
    for(int j = 0; j < matrix[i].length; j++) {
      parametr.push(i);
    }
    parametrs.push(parametr);
    terms.push(0);
  }
  
  for(int i = 0; i < matrix.length; i++) {
    parametrs.push(1);
  }
  terms.push(1);
  
  distribution = lusolve(parametrs, terms);
  
  float alfa = random();
  float curProb = 0;
  
  for(int i = 0; i < distribution.length; i++) {
    for(int j = 0; j < distribution[i].length; j++) {
      curProb += distribution[i][j];
      
      if(alfa < curProb){
        return i;
      }
    }
  }
  
  return 0;
}

void changeState() {
  float[] distribution = {};
  
  for(int i = 0; i < matrix.length; i++) {
    for(int j = 0; j < matrix[i].length; j++) {
      if(i == state) {
        distribution.push(0);
      } else {
        distribution.push(-matrix[state][i] / matrix[state][state]);
      }
    }
  }
  
}
