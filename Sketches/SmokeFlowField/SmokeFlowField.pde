/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Stream;
import static processing.core.PApplet.dist;
import static processing.core.PApplet.map;
import static processing.core.PConstants.P2D;
import processing.core.PVector;


float sensitivity = 0.02f;
float xoffset = 0;
float yoffset = 0;
float zoffset = 0;
PVector gravity;
int scl = 20;
boolean showFlowField = false;
PVector flowField [][];
ArrayList<Ball> balls = new ArrayList();
Ball ball;


public void setup (){
    size(600,600,P2D);
    balls.add(new Ball(width/2,height/2));
    flowField = new PVector[41][41];
  
    frameRate(50);
    background(255);
}
public void draw (){
    zoffset += sensitivity;
    background(190);
    stroke(1);
    fill(255);
    yoffset = 0;
    for (int i = 0; i < flowField.length; i++){
        xoffset = 0;
        for (int j = 0; j < flowField[i].length; j++){
            float theta = map(noise(xoffset,yoffset,zoffset),0,1,0-TWO_PI,TWO_PI);
            PVector vector = PVector.fromAngle(theta);
            flowField[i][j] = vector;
            pushMatrix();
            translate(i*scl,j*scl);
            rotate(vector.heading());
            if(showFlowField){
              line(0,0,10,0);
            }
            popMatrix();
            xoffset += sensitivity;
            //rect(i*scl,j*scl,scl,scl);       
        }
        yoffset += sensitivity;
    }
    fill(0);
    for (int i = balls.size()-1; i > 0; i--){
        
        Ball ball = balls.get(i);
        fill(0,ball.alpha);
        stroke(3,ball.alpha);
        if (ball.wayBack){
        ball.alpha -= 0.5f;
        } else {
        ball.alpha += 0.5f;
        }
        int xGuess = floor(ball.location.x/scl);
        int yGuess = floor(ball.location.y/scl);
        PVector force = flowField[xGuess][yGuess];
        ball.applyForce(force);
        ball.update();
        ball.render();
        pushMatrix();
        translate(ball.location.x, ball.location.y);
        rotate(ball.velocity.heading());
        ellipse(0,0,30,30);
        //line(0,0,10,0);
        popMatrix();
        if (ball.alpha > 50){
            ball.wayBack = true;
            }
        if (ball.alpha < 1 ) {
            balls.remove(ball);
        }
        
        
        }
    
    }

public void mouseDragged(){
    balls.add(new Ball(mouseX,mouseY));
}

public void keyPressed(){
    showFlowField = !showFlowField;
}
      
 class Ball{

 PVector location;
 PVector velocity;
 PVector acceleration;
 float alpha;
 boolean wayBack;
 
 
 public Ball(float x, float y){
 
     location = new PVector (x,y);
     velocity = new PVector (0,0);
     acceleration = new PVector (0,0);
     alpha = 1;
     wayBack = false;
 }
 
 public void update(){
     
     velocity.add(acceleration);;
     velocity.limit(5);
     location.add(velocity);
     acceleration.mult(0);
     checkBorder();
 }
 
 public void render(){
 }
 public void applyForce(PVector force){
     PVector ownForce = force;
     this.acceleration.add(ownForce);
 }

 public void checkNeighbours(List<Ball> balls){
     for (Ball ball: balls){
         float distance = dist(this.location.x, this.location.y, ball.location.x, ball.location.y);
         if (distance < 60 && distance > 0){
             PVector desiredVeloc = PVector.sub(this.location, ball.location);
             desiredVeloc.limit(5);
             PVector steering = PVector.sub(desiredVeloc, this.velocity);
             steering.setMag(0.5f);
             this.applyForce(steering);
         }
     }
 }
  private void checkBorder() {
      if (location.y > 800){
          location.y = 0;
      }
      if (location.y < 0 ){
          location.y = 800;
      }
      if (location.x > 800){
          location.x = 0;
          }
      if ( location.x < 0){
          location.x = 800;
      }
  }
}
  
