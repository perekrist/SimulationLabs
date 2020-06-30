int numberOfStaff;
int numberOfActiveStaff;
agentEmployee[] staff;
float averageHandleSpeed;
agentCustomer[] queue;
float queueIntensity;
float staffIntensity;
float distributionSize;
float[] distribution;
float testInterval;
float testAmount;
float[] testDistribution;
float average;
float variance;
float averageError;
float varianceError;

void setup() {
  size(700, 600);
  background(100);
  textSize(20);
  
  numberOfStaff = 20;
  numberOfActiveStaff = 0;
  staff = new Array(numberOfStaff);
  averageHandleSpeed = 0;
  queue = new Array();
  queueIntensity = 0.0007;
  staffIntensity = 0.000075;
  distributionSize = 50;
  distribution = new Array(distributionSize);
  testInterval = 1000;
  testAmount = 0;
  testDistribution = new Array(distributionSize).fill(0);
  average = 0;
  variance = 0;
}

void draw() {
  background(255);
  alg();
  
  text("Average Error: " + averageError * 100 + "%", 300, 300);
  text("Variance Error: " + varianceError * 100 + "%", 350, 300);
  
}


void alg() {
  for (const [index] of  staff.entries()) {
     staff[index] = {
      handleSpeed = random() / 2 + 0.5,
      customer = new agentCustomer,
      timePassed = 0,
      getTime(context) {
        if (customer) {
         if (customer.isScandalous) {
            return -log(random()) / context.staffIntensity * (handleSpeed + customer.requestSize) * 5 - timePassed;
          }

          return -log(random()) / context.staffIntensity * (handleSpeed + customer.requestSize) - timePassed;
        }
        return 0;
      }
    };

    averageHandleSpeed += staff[index].handleSpeed;
  }
    
  averageHandleSpeed /= numberOfStaff;

  float intensityRatio = queueIntensity / (staffIntensity / ((averageHandleSpeed + 1) * 1.2));
  float probabilityBase = 0;

  for (int i = 0; i <=  numberOfStaff; i++) {
    probabilityBase += Math.pow(intensityRatio, i) / factorial(i);
  }

  probabilityBase = pow(probabilityBase + pow(intensityRatio, numberOfStaff + 1) / (factorial(numberOfStaff) * (numberOfStaff - intensityRatio)), -1);

  for (const [index] of distribution.entries()) {
    distribution[index] = index < numberOfStaff
      ? pow(intensityRatio, index) * probabilityBase / factorial(index)
      : pow(intensityRatio, index) * probabilityBase / (factorial(numberOfStaff) * pow(numberOfStaff, index - numberOfStaff));
  }

  distribution[distributionSize - 1] += 1 - distribution.reduce((a, b) => a + b);

  for (const [index, value] of distribution.entries()) {
    average += index * value;
  }

  for (const [index] of distribution.entries()) {
   variance += pow(index * average, 2);
  }

  variance /= distributionSize - 1;

  fillQueue();
  getNextEvent();
    
  testDistribution[min(distributionSize - 1, numberOfActiveStaff + queue.length)]++;
      testAmount++;

      float testAverage = 0;

      for (const [index, value] of testDistribution.entries()) {
        testAverage += index * (value / testAmount);
      }

      float testVariance = 0;

      for (const [index] of testDistribution.entries()) {
        testVariance += pow(index * testAverage, 2);
      }

      testVariance /= distributionSize - 1;

      averageError = abs(testAverage - average) / abs(average);
      varianceError = abs(testVariance - variance) / abs(variance);
}

void fillQueue() {
   queue.push({
     requestSize: Math.random() + 0.5,
     isScandalous: Math.random() < 0.05
   });
}

void getNextEvent() {
  int minTime = 0;
  int nextAgent = 0;

  for (const [index, value] of staff.entries()) {
    float curTime = value.getTime(this);

    if (curTime < minTime) {
      minTime = curTime;
      nextAgent = index;
     }
  }

  for (const [index, value] of staff.entries()) {
    if (value.customer) {
      staff[index].timePassed += minTime;
    }
  }
      if (queue.length > 0) {
        if (!staff[nextAgent].customer) {
          numberOfActiveStaff++;
        }

        staff[nextAgent].timePassed = 0;
        staff[nextAgent].customer =  queue[0];
        queue.shift();
      } else {
        if (staff[nextAgent].customer) {
          numberOfActiveStaff--;
        }

        staff[nextAgent].customer = undefined;
      }

      getNextEvent();
}

interface context {
  float staffIntensity
}

interface agentCustomer {
  float requestSize,
  boolean isScandalous 
}

interface agentEmployee {
  float handleSpeed,
  agentCustomer customer,
  float timePassed,
  float getTime(context: context)
}
