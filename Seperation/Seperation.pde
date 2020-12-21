    PVector gravity;
    ArrayList<Ball> balls = new ArrayList();
    
    public void setup (){
       size(700,700,P2D);
    }
    public void draw (){
        background(255);
        for (int i = 0; i < balls.size(); i++){
            Ball ball = balls.get(i);
            PVector wind = new PVector(-0.1f,0);
            gravity = new PVector (0,0.01f);
         //  ball.applyForce(wind);
           //ball.applyForce(gravity);
           ball.checkNeighbours(balls);
            ball.update();
            fill(0);
            ellipse(ball.location.x,ball.location.y,25,25);
        }
     }
   
    public void mouseDragged() {
        balls.add(new Ball(mouseX,mouseY));
    }
    public void keyPressed(){     

       
    }

    private class Ball {

   PVector location;
   PVector velocity;
   PVector acceleration;

   
 
   public Ball(float x, float y){
   
       location = new PVector (x,y);
       velocity = new PVector (0,0);
       acceleration = new PVector (0,0);
   }
   
   public void update(){
       
       velocity.add(acceleration);
       velocity.mult(0.97f);
       velocity.limit(10);
     
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

   public void checkNeighbours(ArrayList<Ball> balls){
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
    


