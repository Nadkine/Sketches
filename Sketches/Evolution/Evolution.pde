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

/**
 *
 * @author tjeer
 */

float forceStrength = 0.8f;
int length = 700;
List<Rocket> rockets = new ArrayList();
PVector target;
int w;
int h;
int population = 200;
int count = 0;
List<Obstacle> obstacles = new ArrayList();
Obstacle obstacle;
Obstacle currentObstacle;
boolean hasAllCrashed = false;


public void setup (){
    size(700,700,P2D);
    for (int i = 0 ; i < population; i++){
        rockets.add(new Rocket());            
    }
}



public void draw (){
    hasAllCrashed = true;
    for (Rocket rocket : rockets){
        if (!(rocket.hasCrashed && rocket.hasFinished)) hasAllCrashed = false;
    }
    if (hasAllCrashed){
        count = length;
    }
    background(255);
    target = new PVector(width/2,20); 
    rectMode(CORNER);
    for (Obstacle obstacle: obstacles){
        rect(obstacle.x,obstacle.y,obstacle.w,obstacle.h);
        obstacle.checkObstacle(rockets);
    }
    for (Rocket rocket : rockets){
        //rocket.applyForce(new PVector(random(-0.8f,0.8f),random(-0.8f,0.8f)));
        rocket.update();
        pushMatrix();
            translate(rocket.location.x,rocket.location.y);
            rectMode(CENTER);
            rotate(rocket.velocity.heading());
            rect(0,0,50,5);
        popMatrix();
    }
    fill(0);
    ellipse(target.x, target.y,50,50);
    
    if (count++ == length){
        float maxFitness = 0;
        for (Rocket rocket : rockets){
            rocket.calculateFitness();
            if (rocket.fitness > maxFitness){
                maxFitness = rocket.fitness;  
            }       
        }
        for (Rocket rocket : rockets){
            rocket.fitness /= maxFitness;
        }
            //creating new pool
            List<Rocket> pool = new ArrayList();
            for (Rocket rocket: rockets){
                float k = rocket.fitness*100;
                for (int j = 0; j < k; j++){
                pool.add(rocket);
                }
            }
        
        List<Rocket> newRockets = new ArrayList();
        newRockets.clear();
        int poolsize = pool.size();
        if (poolsize == 0 ){
            for (int n = 0; n < population; n++){
                newRockets.add(new Rocket());
            }
        } else {
        for (int n = 0; n < population; n++){
            
            Rocket parent1 = pool.get((int)random(0,poolsize));
            Rocket parent2 = pool.get((int)random(0,poolsize));
            //crossover 
            DNA newDNA = parent1.dna.crossover(parent2.dna);
            for (int i = 0; i< newDNA.genes.size(); i++){
                if (random(0,100)<1){
                    newDNA.genes.set(i, new PVector(-forceStrength,forceStrength));
                    }
                }
            newRockets.add(new Rocket(newDNA));
        }

            }
            rockets = newRockets;
        count=0;
    }
}

public void mousePressed(){
    obstacle = new Obstacle(mouseX,mouseY);
    obstacles.add(obstacle);
    currentObstacle = obstacle;
}

public void mouseDragged(){
    currentObstacle.w = (int)mouseX - currentObstacle.x;
    currentObstacle.h = (int)mouseY - currentObstacle.y;
}
class DNA{
    List<PVector> genes = new ArrayList();
    
    public DNA (){
        for (int i = 0; i<= length; i++){
            genes.add(new PVector(random(-forceStrength,forceStrength),random(-forceStrength,forceStrength)));
        }
    }
    
    public DNA (List<PVector> list){
        this.genes = list;
        }
    
    public DNA crossover(DNA other){
        List<PVector> newDNA = new ArrayList();
        for (int i = 0; i < other.genes.size(); i++){
            if (i%2==0){
                newDNA.add(this.genes.get(i));
                } else {
                newDNA.add(other.genes.get(i));
                }
            }
        // System.out.println(this.genes);
        //System.out.println(newDNA);
        return new DNA(newDNA);
    }    
}

    
class Rocket{
    boolean hasFinished;
    boolean hasCrashed;
    DNA dna;
    PVector location;
    PVector velocity;
    PVector acceleration;
    float fitness;
    PVector currentForce;
    PVector ownForce;
    float speed = length;

    public Rocket(){
        this.location = new PVector(width/2, height);
        this.velocity = new PVector(0,0);
        this.acceleration = new PVector (0,0);
        this.dna = new DNA();
        this.hasFinished = false;
    }

    public Rocket(DNA dna){
        this.location = new PVector(width/2, height);
        this.velocity = new PVector (0,0);
        this.acceleration = new PVector (0,0);
        this.dna = dna;
        this.hasFinished = false;
    }

    public void update(){    
        if (!this.hasFinished && !this.hasCrashed){
        this.currentForce = this.dna.genes.get(count);
        checkCrash();
        checkHit();
        applyForce(this.currentForce);
        this.acceleration.setMag(1);
        this.velocity.add(this.acceleration);
        this.velocity.limit(5);
        this.location.add(this.velocity);
        this.acceleration.mult(0);
        }
    }

    public void applyForce(PVector force){
        this.ownForce = force;
        this.acceleration.add(this.ownForce);
    }

    public void calculateFitness(){
        float d = dist(this.location.x,this.location.y,target.x,target.y);
        if (d < 40){
            this.fitness = 50/speed;
        } else {
        this.fitness = map(d,40,400,50,1)/speed;
        }
    }

    public void checkHit(){
        if (dist(target.x,target.y,this.location.x,this.location.y)<40){
            this.location.x = target.x;
            this.location.y = target.y;
            this.hasFinished = true;
            this.speed = count;
        }
    }


    public void checkCrash(){
        if (this.location.y > 1000 || this.location.x < 0 || this.location.x>1500 || this.location.y < 0  ){
            this.hasCrashed = true;
        }
    }
}

public class Obstacle {

    int x;
    int y;
    int w;
    int h;

    public Obstacle(int x,int y){
            this.x = x;
            this.y = y;
    }

    public void checkObstacle(List<Rocket> rockets){
        for(Rocket rocket: rockets){
            if (rocket.location.x > this.x && rocket.location.x < this.x+this.w && rocket.location.y > this.y && rocket.location.y < this.y+this.h){
                    rocket.hasCrashed = true;
                }
        }
    }
}


