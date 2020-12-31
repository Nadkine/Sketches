
ArrayList<Fruit> fruitArray = new ArrayList();
ArrayList<Blob> blobArray = new ArrayList();
int blobAmount = 20;
int initialFruitAmount = 100;


public void setup(){
  size(700,800);
   for(int i = 0; i< blobAmount; i++){
       blobArray.add(new Blob(floor(random(width)),floor(random(height)), floor(random(2,100))));
   }
   //for(int i = 0; i< initialFruitAmount; i++){
      //fruitArray.add(new Fruit((int)random(width),(int)random(height)));
   //}
}

public void draw(){
    background(255);
    if (random(100) < map(blobArray.size(),1,50,100,0.1f)){
    setFood();
    }
    for(int i = blobArray.size()-1; i>0; i--){
       Blob blob = blobArray.get(i);
       blob.applyForce();
       blob.update();
       blob.show();
       if (blob.lifespan < 1){
           fruitArray.add(new Fruit((int)blob.loc.x, (int)blob.loc.y));
           blobArray.remove(i);
           
       }
   }  
    
    for(Fruit fruit: fruitArray){
        fruit.show();  
   }  
}

private void setFood() {
    fruitArray.add(new Fruit((int)random(width),(int)random(height)));
}

class Blob{
    PVector loc;
    PVector vel;
    PVector acc;
    float xOffset;
    float yOffset;
    float r;
    float lifespan;
    
    public Blob(int x, int y, float r){
        loc = new PVector(x,y);
        vel = new PVector(0,0);
        acc = new PVector(0,0);
        this.xOffset = random(0,100);
        this.yOffset = random(0,100);
        this.r = r;
        lifespan = 255;
    }
    
    public void applyForce(){
         xOffset += 0.01;
         yOffset += 0.01;
         float forceX = (noise(xOffset)-0.44f)*25;
         float forceY = (noise(yOffset)-0.44f)*25;
         this.acc.add(new PVector(forceX,forceY));
    }
    
    public void update(){
        acc.mult(1/r);
        this.vel.add(this.acc);
        this.vel.limit((1/r)*100);
        this.loc.add(this.vel);
        this.acc.mult(0);
        this.edges();
        checkFruit(fruitArray);
        if (random(100)<0.04){
            this.mutate();
        }
        lifespan -= 0.3;
        
    }
    public void show(){
        noStroke();
        fill(51,this.lifespan);
        ellipse(this.loc.x,this.loc.y,this.r,this.r);
    }
    
    public void edges(){
        if (loc.x < 0){
            loc.x = width;
        }
        if (loc.y < 0){
            loc.y = height;
        }
        if (loc.x > width){
            loc.x = 0;
        }
        if (loc.y > height){
            loc.y = 0;
        }
    }

    private void checkFruit(ArrayList<Fruit> fruitArray) {
        for (int i = fruitArray.size()-1; i > 0; i--){ 
            Fruit fruit = fruitArray.get(i);
            if (dist(fruit.x,fruit.y,this.loc.x,this.loc.y) < (fruit.r + this.r)/2){
                fruitArray.remove(i);
                this.lifespan+= 100;
                if (this.lifespan >255){
                    this.lifespan = 255;
                }
            }
        }
    }

    private void mutate() {
        int newX = (int)this.loc.x;
        int newY = (int)this.loc.y;
        int newR = (int)this.r + (int)random(-5,5);
        Blob newBlob = new Blob(newX, newY,this.r);
        newBlob.xOffset = random(0,100);
        newBlob.yOffset = random(0,100);
        blobArray.add(newBlob);
    }

}

class Fruit{
    float x;
    float y;
    float r;

    public Fruit(int x, int y){
        this.x = x;
        this.y = y;
        this.r = 5;  
    }
    
    public void show(){
        fill(255,0,0);
        ellipse(this.x,this.y,this.r,this.r);
    }

}

