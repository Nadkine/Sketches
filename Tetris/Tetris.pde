
float w;
float resolution = 10;
Shape shape;
ArrayList<Shape> shapes = new ArrayList();
ArrayList<int[]> solidBlocks = new ArrayList();
int difficulty = 6;
int score = 0;
void setup(){
  size(200,600,P2D);
  w = width/resolution;
  shape = new Shape(w,difficulty);
}

void draw(){
  background(255);
  shape.update(solidBlocks);
  shape.show();    
  fill(0);
  text(score,width/2,50,200);
  for(int i = 0; i < solidBlocks.size();i++){
    fill(solidBlocks.get(i)[2],solidBlocks.get(i)[3],solidBlocks.get(i)[4]);
    rect((solidBlocks.get(i)[0])*w,solidBlocks.get(i)[1]*w,w,w);
  }
  if(shape.fallen){
       if(shape.y < 5){
         score = 0;
         solidBlocks = new ArrayList();
       }else{
         shape.turnIntoSolid(solidBlocks);
       }
       shape = new Shape(w,difficulty);
   }
   checklines(solidBlocks);
}


void keyPressed(){
  if( keyCode == LEFT && !shape.checkLeftSideCollision(solidBlocks)){
    shape.x -= 1;
  }
  else if( keyCode == RIGHT && !shape.checkRightSideCollision(solidBlocks)){
    shape.x += 1;
  }
  else if( keyCode == DOWN && !shape.checkCollision(solidBlocks)){
    shape.y += 1;
  }
  else if( keyCode == UP){
    while(!shape.checkCollision(solidBlocks)){
     shape.y += 1;
    }
  }
  else if( keyCode == 32){
    shape.turn();
  }
}

public void checklines(ArrayList<int[]> solidBlocks){
   for(int i = 30; i > 0; i--){
     int sum=0;
       for(int n = 0; n < solidBlocks.size();n++){
         if(i == solidBlocks.get(n)[1]){
         sum += 1;
         }
      
     }
     if(sum >= resolution){
       score += 1;
       for(int k = solidBlocks.size()-1; k >= 0; k--){
         if(solidBlocks.get(k)[1] == i){
            solidBlocks.remove(k);
         }
       }
       
       for(int j = 0; j < solidBlocks.size();j++){
         if(solidBlocks.get(j)[1] < i){
           solidBlocks.get(j)[1] ++;
         }
       }
     }
   }
}
class Shape{
  
  int x;
  int y;
  float w;
  float timetofall;
  float time; 
  ArrayList<int[][]> positions  = new ArrayList();
  int[][] config;
  boolean fallen;
  boolean even;
  int[] thecolor;
  
  public Shape(float w,float time){
      this.x = int(random(3,7));
      this.y = 2;
      this.w = w;
      this.time = time;
      positions.add(new int[][]{{2,0},{1,0},{0,0},{-1,0}});
      positions.add(new int[][]{{1,0},{0,0},{0,1},{1,1}});
      positions.add(new int[][]{{0,0},{1,0},{0,1},{0,2}});
      positions.add(new int[][]{{0,0},{-1,0},{0,1},{0,2}});
      positions.add(new int[][]{{0,0},{-1,0},{1,0},{0,1}});
      positions.add(new int[][]{{0,0},{1,0},{1,1},{0,-1}});
      positions.add(new int[][]{{0,0},{-1,0},{-1,1},{0,-1}});
      //ArrayList<int[]> colors  = new ArrayList();
      ArrayList<int[]> colors = new ArrayList();
      colors.add(new int[]{255,0,0});
      colors.add(new int[]{0,0,255});
      colors.add(new int[]{0,255,0});
      colors.add(new int[]{0,255,255});
      colors.add(new int[]{255,0,255});
      colors.add(new int[]{255,255,0});
      colors.add(new int[]{50,150,220});
      int random_number = int(random(7));
      this.thecolor = colors.get(random_number);
      this.config = positions.get(random_number);
      fallen = false;
      even = false;
      
  }
  
  public void update(ArrayList<int[]> solidBlocks){
    if (timetofall-- < 0){
      
      if(!this.checkCollision(solidBlocks)){
        this.y += 1;
        timetofall = time;
      }else{
        this.fallen = true;
      }
    }
  }

  public void turn(){
    
    even = !even;
    for(int[]pos:this.config){
         int tempy = pos[1];
         pos[1] = pos[0];
         pos[0] = tempy*-1;
    }
     while(this.checkRightSideCollision(solidBlocks) || this.checkLeftSideCollision(solidBlocks) ){
        if(this.x < 4){
          this.x += 1;
        }else{
          this.x -= 1;
        }
     }
    }
  
  
  public void show(){
    fill(this.thecolor[0],this.thecolor[1],this.thecolor[2]);
    for(int[] pos: this.config){
      rect((this.x+pos[0])*w,(this.y+pos[1])*w,this.w,this.w);
    }
  }
  
  public boolean checkCollision(ArrayList<int[]> solidBlocks){
    for(int[] pos: this.config){
      if((this.y + pos[1] + 1)* w >= height){
        return true;
      }
      for(int i = 0; i < solidBlocks.size();i++){  
        if(this.y + pos[1] + 1 == solidBlocks.get(i)[1] && this.x + pos[0] == solidBlocks.get(i)[0] ){
          return true;
        }
      }    
    }
    return false;  
  }
  
  public boolean checkRightSideCollision(ArrayList<int[]> solidBlocks){
   for (int[] pos: this.config){
     if((this.x + pos[0] + 1)* w >= width){
        return true;
      }
      for(int i = 0; i < solidBlocks.size();i++){
        if(this.x + pos[0] + 1 == solidBlocks.get(i)[0] && this.y + pos[1] == solidBlocks.get(i)[1]){
          return true;
        }
      }
   }

   return false;
  }
  
  public boolean checkLeftSideCollision(ArrayList<int[]> solidBlocks){
   for (int[] pos: this.config){
      if((this.x + pos[0] - 1)* w < 0){
        return true;
      }
      for(int i = 0; i < solidBlocks.size();i++){
        if(this.x + pos[0] - 1 == solidBlocks.get(i)[0] && this.y + pos[1] == solidBlocks.get(i)[1]){
          return true;
        }
      }
   }

   return false;
  }
  
  public void turnIntoSolid(ArrayList<int[]> solidBlocks){
     for (int[] pos: this.config){
       solidBlocks.add(new int[]{this.x+pos[0],this.y+pos[1],this.thecolor[0],this.thecolor[1],this.thecolor[2]});
     }
  
  }
 
}