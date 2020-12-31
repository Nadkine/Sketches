

  ArrayList<Obstacle> obstacles = new ArrayList();
  Player player1;
  int score;
  int topScore;
  float red;
  float blue;
  float green;
     
  public void setup() {
     size(700,400);
      background(255);
     // surface.setResizable(true);
      player1 = new Player(20);
      red = random(0,255);
      green = random(0,255);
      blue = random(0,255);
  }

  public void draw() {
      background(red,green,blue);
      fill(0);
      rect(0,height*0.9f,width,height*0.05f);
      textSize(50);
      stroke(0);
      text(score++,30,50);
      if (score>topScore) {
             topScore = score;
      }
      text(topScore,340,50);

      //player stuff
      PVector gravity = new PVector(0,0.3f);
      player1.applyForce(gravity);
      player1.update();
      player1.render();


      //obstacle stuff
      stroke(0);
      if (random(100)<2) {
          obstacles.add(new Obstacle(random(40,110)));
      }
      for (int i = obstacles.size()-1; i > 0; i--) {
          Obstacle obs = obstacles.get(i);
          obs.update();
          if(obs.checkHitPlayer(player1)) {
                red = random(0,255);
                green = random(0,255);
                blue = random(0,255);
                score = 0;
                obs.crumbles = true;
          };
          obs.render();
          if(obs.x < -100) {
                obstacles.remove(i);
          }
      }
  }

  public void keyPressed() {
        if (--player1.power > 0) {
        player1.applyForce(new PVector(0,-9));
        }
  }

  class Obstacle{

        float x;
        float y;
        float h;
        float angle;
        boolean crumbles;
        public Obstacle(float h) {
               this.x = width;
               this.h = h;  
               this.y = height*0.9f-this.h;
               this.crumbles = false;
               this.angle = -HALF_PI;
        }

        public void update() {
               this.x -= 4;
               this.y = height*0.9f-this.h;

        }
        public void render() {
               fill(0);
               if (this.crumbles) {
                     pushMatrix();
                     translate(this.x,this.y+this.h);
                     rotate(angle+=0.05f);
                     strokeWeight(10);
                     line(0,0,this.h,0);
                     popMatrix();
                     strokeWeight(1);
               } else {
                     rect(this.x,this.y,10,this.h);
               }
        }
        public boolean checkHitPlayer(Player player) {
               return (player.loc.x == this.x && player.loc.y+player.h > this.y);
        }
  }

  class Player{
      int power;
      PVector loc;
      PVector vel;
      PVector acc;
      float h;
      float angle;
      float yBorder;
      public Player(float h) {
          this.loc = new PVector(40,height*0.9f-10);
          this.vel = new PVector(0,0);
          this.acc = new PVector(0,0);
          this.h = h;
          yBorder = this.loc.y;
      }

      public void applyForce(PVector force) {
          this.acc.add(force);      
      }
      public void update() {
          if(this.loc.y >= height*0.9f-10) {
                 this.vel.y = 0;
                 this.loc.y = height*0.9f-10;
                 this.applyForce(new PVector(0,-0.3f));
                 this.power = 3;
          }

          this.vel.add(this.acc);
          this.loc.add(this.vel);
          this.acc.mult(0);
      }
      public void render() {
          fill(0);
          ellipse(this.loc.x,this.loc.y,this.h,this.h);
          pushMatrix();
          translate(this.loc.x,this.loc.y);
          stroke(255);
          rotate(angle+=0.2f);
          line(0,0,10,0);
          popMatrix();
      }
  }

