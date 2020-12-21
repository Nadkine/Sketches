
   int resolution = 5;
   ArrayList<Ball> balls = new ArrayList();
   PImage foto;
   boolean flag;
   float grootte = 3;
    public void setup(){
        fill(0);
       size(600,600);
        foto = loadImage("../Tjeerd.jpg");
      
   }
  
    
   public void draw (){
       if(balls.size() < 10){
            console.log("STUCK");
            foto.resize(600,600);
            foto.filter(THRESHOLD, 0.7); 
            foto.loadPixels();
            for(int x = 0; x < width; x+= resolution){
                for(int y = 0; y < height; y+= resolution){
                    if(foto.pixels[x+y*width] < -1){
                        balls.add(new Ball(x,y));
                
                    }
                }
            }
        }
        background(255);
        for (Ball ball : balls){
           float d = dist(mouseX,mouseY,ball.location.x, ball.location.y);
           float force;
           if (d<100){
               force = map(d, 0,100,1,0);
           }
           if(flag){ball.applyDesired();}     
           PVector friction = ball.velocity.get();
           friction.mult(-0.005f);
           ball.applyForce(friction);
           ball.update();
           ellipse(ball.location.x,ball.location.y,grootte,grootte);
          }
        }
   
   
    public void mouseClicked() {
            flag = !flag;
    }
    public void keyPressed(){     
          for (Ball ball : balls){
           //PVector force = new PVector(map((ball.location.x - 400),0,100,-1.5f,1.5f),map((ball.location.y - 300),0,100,-1.5f,1.5f));
           PVector randomeForce = new PVector(random(-3,3),random(-3,3));
           //ball.applyForce(force);
           ball.applyForce(randomeForce);
           ball.update();           
        }
       
    }

class Ball {

   PVector location;
   PVector velocity;
   PVector acceleration;
   PVector wanted;
   
 
   public Ball(float x, float y){
   
       location = new PVector (x,y);
       velocity = new PVector (0,0);
       acceleration = new PVector (0,0);
       wanted = new PVector(x,y);
   }
   
   public void update(){
       
       velocity.add(acceleration);
       location.add(velocity);
       acceleration.mult(0);
       checkBorder();
   }
   
   public void applyForce(PVector force){
       PVector ownForce = force;
       this.acceleration.add(ownForce);
       
   
   }

   public void applyDesired(){
       PVector desiredVeloc = PVector.sub(wanted,location);
       float d= desiredVeloc.mag();
       if (d<100){
            desiredVeloc.setMag(map(d,0,100,0,5));
       }else{
       desiredVeloc.setMag(5);
       }
       PVector steering = PVector.sub(desiredVeloc,velocity);
       steering.limit(3);
       
       this.applyForce(steering);
       
   }
    private void checkBorder() {
        if (location.y > 800){
            location.y = 800;
            velocity.y *= -1;
        }
        if (location.y < 0 ){
            location.y = 0;
            velocity.y *= -1;
        }
        if (location.x > 800){
            location.x = 800;
             velocity.x *= -1;
            }
        if ( location.x < 0){
            location.x = 0;
            velocity.x *= -1;
        }
    }
}
    