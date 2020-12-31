
public int amount = 1000;
public ArrayList<RainDrop> rainArray = new ArrayList();
public float xoffset = 0.0f; 
public float xVelocity = 0;
    
public void setup(){
  size(600,600,P2D);
    for (int i = 0; i< amount; i++){
        rainArray.add(new RainDrop());
    }
}

public void draw(){
    background(200);
    xoffset += 0.01f;
    xVelocity = map(noise(xoffset),0,1,-10,10);
    fill(50,50,220);
    noStroke();
    for (int i = 0; i< amount; i++){
        
        rainArray.get(i).update();
        rainArray.get(i).checkReset();
        rotate((float)(Math.PI));//RainDrop.xVelocity);
        console.log(rainArray.get(i))
        //ellipseMode(CENTER);
         ellipse((float)(rainArray.get(i).x),(rainArray.get(i).y),(float)(this.rainArray.get(i).yVelocity*1.5),(float)(this.rainArray.get(i).yVelocity*3));
         //rotate((float)(Math.PI)*RainDrop.xVelocity);
         
        
   }
}



public class RainDrop {

 
    public float size = 15;
    public float x;
    public float y;
    public float yVelocity; 
    
    public RainDrop(){
       this.x = (float)(Math.random())*width;
       //this.x = 50;
       this.y = -50;
       this.yVelocity = (float)Math.random()*3+2;
    }
    
    void resetY(){
        this.y = -50;
    }
    
    void resetX(){
        this.x = 0; 
    }
    
    void render(){

      
    }
    
    void update(){
    this.y += yVelocity;
    this.x += xVelocity;
    }

    void checkReset() {
        if (this.x > 800){
            this.x=0;
        }
        if (this.x < 0){
            this.x=800;
        }
        if (this.y > 800){
            this.y=0;
        }
    }
}
