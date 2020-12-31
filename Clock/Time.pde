float clocksize;
float quarterTurn = (float) Math.PI * 1.5f;


public void setup(){
  size(200,200,P2D);
}
public void draw() {
  clocksize = width / 2;
  background(0);
  noFill();
  strokeWeight(5);
  stroke(255,100,100);
  //seconden
  makeCircle(second(),60,1.5f);
  //minuten
  stroke(100,255,100);
  makeCircle(minute(),60,1);
  //uren
  stroke(100,255,255);
  makeCircle(hour()%12,12,0.5f);
}

public void makeCircle(int aantal, int max_aantal, float magnifier) {
  float length = ((float)(aantal)/(max_aantal))*(float)Math.PI*2;
  arc(clocksize,clocksize,magnifier*clocksize,magnifier*clocksize,quarterTurn, length + quarterTurn);
  
} 
