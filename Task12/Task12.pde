Team[] teams = {  new Team(1), 
                  new Team(2),
                  new Team(3),
                  new Team(4),
                  new Team(5),
                  new Team(6),
                  new Team(7),
                  new Team(8)
                }; 
                
Team[] teams_semi = {}; 
Team[] teams_final = {};
Team firstPlace;


void setup() {
  size(500, 500);
  textSize(20);
  for(int i = 0; i < teams.length; i++) {
    alg(teams[i]);
  }
  
  for(int i = 0; i < teams.length; i += 2) {
    play(teams[i], teams[i+1]);
  }
  
  //semi_final
  for(int i = 0; i < teams_semi.length; i++) {
    alg(teams_semi[i]);
  }
  
  for(int i = 0; i < teams_semi.length; i += 2) {
    play_semi(teams_semi[i], teams_semi[i+1]);
  }
  
  //final
  for(int i = 0; i < teams_final.length; i++) {
    alg(teams_final[i]);
  }
  
   play_final(teams_final[0], teams_final[1]);
  
}

void draw() {
  textSize(20);
  background(100);
  text("Winner team is " + firstPlace.num, 20, 20);  
  
  
}

void alg(Team team) {
  int m = 0;
  float S = 0;
  float e = exp(1);
  while(true) {
   float k = random(0.5);
   S += log(k) + log(e);
   if(S < -team.goals) {
     team.m = m;
     break;
   } else {
     m += 1;
   }
  }
}

void play(Team first, Team second) {
  if(first.m > second.m) {
    println(first.num + " won with score " + first.m + " - "+ second.m);
    append(teams_semi, first);
  } else {
    println(second.num + " won with score " + second.m + " - "+ first.m);
    append(teams_semi, second);
  }
}

void play_semi(Team first, Team second) {
  if(first.m > second.m) {
    println(first.num + " won semi with score " + first.m + " - "+ second.m);
    append(teams_final, first);
  } else {
    println(second.num + " won semi with score " + second.m + " - "+ first.m);
    append(teams_final, second);
  }
}

void play_final(Team first, Team second) {
  if(first.m > second.m) {
    println(first.num + " won final with score " + first.m + " - "+ second.m);
    firstPlace = first;
  } else {
    println(second.num + " won final with score " + second.m + " - "+ first.m);
    firstPlace = second;
  }
}
