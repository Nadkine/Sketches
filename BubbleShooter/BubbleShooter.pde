ArrayList<Bubble> bubbles;
ArrayList<Bubble> checked_bubbles;
ArrayList<Bubble> tbr_bubbles;
Bubble mainBubble;
float w = 50;
int counter = 0;
int counter1 = 0;
int AMOUNT_OF_COLORS = 6;
int AMOUNT_OF_TURNS = 6;

void initBubbles(){
   counter = 0;
   counter1 = 0;
   bubbles = new ArrayList();
   for(int i = 0; i < 5; i++){
      if(i%2==0){
       for(int j = 1; j < 12; j++){
            bubbles.add(new Bubble(j*w*1.1 - 0.55*w,  i*w*1.1+0.5*w,  w, true));
          }
      }else{
        for(int j = 1; j < 11; j++){ 
            bubbles.add(new Bubble(j*w*1.1,  i*w*1.1+0.5*w,  w,true));
          }   
      } 
     mainBubble = new Bubble(width/2,height-50,w,false);
   }
}

void setup(){
  size(600,600);
  initBubbles();
  checked_bubbles = new ArrayList();
  tbr_bubbles = new ArrayList();
}

void draw(){
  background(255);
  for(Bubble bubble: bubbles){
    bubble.display();
  }
  if(mainBubble.checkBubbleCollision(bubbles)){
       counter++;
       mainBubble.stopped = true;
       bubbles.add(mainBubble);
       check_death(mainBubble);
       mainBubble.setLoc();
       int bubble_sum = checkBubbles(mainBubble) + 1;
       checked_bubbles = new ArrayList();
       if (bubble_sum > 2){
         removeBubbles(mainBubble); 
         for(int n = 0; n <= tbr_bubbles.size()-1; n++){
            bubbles.remove(tbr_bubbles.get(n));
         }
         tbr_bubbles = new ArrayList();
         checkLooseBubbles();
         for(int n = 0; n <= tbr_bubbles.size()-1; n++){
            bubbles.remove(tbr_bubbles.get(n));
         }
       }
       tbr_bubbles = new ArrayList();
       checked_bubbles = new ArrayList();
       mainBubble = new Bubble(width/2,height-50,w,false);
       add_new_row();
    }else{
      mainBubble.update();
      mainBubble.display();
      if (mainBubble.loc_y > height+50){
         mainBubble = new Bubble(width/2,height-50,w,false);
         counter++;
      }
      if (!mainBubble.started){
         strokeWeight(2);
         line(mainBubble.loc_x,mainBubble.loc_y,mouseX,mouseY);
      }   
    }
}

void checkLooseBubbles(){
  for (Bubble bubble: bubbles){
     boolean tbr = true;
     for (Bubble oth_bubble: bubbles){
        if (bubble != oth_bubble){
          if (dist(bubble.loc_x,bubble.loc_y,oth_bubble.loc_x,oth_bubble.loc_y) < 1.5* bubble.w ){
            tbr= false;
          }
        }
      }
    if (tbr){
      tbr_bubbles.add(bubble);
    }
  }
}

void check_death(Bubble bubble){
  if (bubble.loc_y + 1.65 *  bubble.w > height){
      initBubbles();
   }
}
void add_new_row(){
  if (counter == AMOUNT_OF_TURNS){
      counter1++;
      for (Bubble the_bubble: bubbles){
        the_bubble.loc_y += 1.1*the_bubble.w;
        check_death(the_bubble);
      }
      if(counter1%2==0){
        for(int j = 1; j < 12; j++){
          bubbles.add(new Bubble(j*w*1.1 - 0.55*w,  0.5*w,  w, true));
        }
      }else{
      for(int j = 1; j < 11; j++){ 
          bubbles.add(new Bubble(j*w*1.1,  0.5*w,  w,true));
        }  
      }
      counter = 0;  
   }  
}

int checkBubbles(Bubble bubble){
   int bubble_sum = 0;
   checked_bubbles.add(bubble);
   for(Bubble oth_bubble: bubbles){
     if (!checked_bubbles.contains(oth_bubble)){
       if (dist(bubble.loc_x,bubble.loc_y,oth_bubble.loc_x,oth_bubble.loc_y) < 1.5* bubble.w ){
         if(bubble.group == oth_bubble.group){
           bubble_sum += 1;
           checked_bubbles.add(oth_bubble);
           bubble_sum += checkBubbles(oth_bubble);
         }
       }
     }
   }
   return bubble_sum;
}

void removeBubbles(Bubble bubble){
   checked_bubbles.add(bubble);
   tbr_bubbles.add(bubble);
   for(int n = bubbles.size()-1; n >= 0; n--){
     if (!checked_bubbles.contains(bubbles.get(n))){
       if (dist(bubble.loc_x,bubble.loc_y,bubbles.get(n).loc_x,bubbles.get(n).loc_y) < bubble.w * 1.5 ){
         if(bubble.group == bubbles.get(n).group){
           checked_bubbles.add(bubbles.get(n));
           removeBubbles(bubbles.get(n));
         }
       }
     }
   }
}

void mousePressed(){
  if (!mainBubble.started){
    mainBubble.start(mouseX,mouseY);
    mainBubble.started = true;
  }
}
class Bubble{
  
  float loc_x;
  float loc_y;
  float vel_x;
  float vel_y;
  float w;
  int group;
  int[] c; 
  boolean started;
  boolean stopped;
  
  Bubble(float x, float y, float w, boolean stopped){
     this.loc_x = x;
     this.loc_y = y;
     this.w = w;
     this.group = int(random(AMOUNT_OF_COLORS));
     ArrayList<int[]> colors = new ArrayList();
      colors.add(new int[]{255,0,0});
      colors.add(new int[]{0,0,255});
      colors.add(new int[]{0,255,0});
      colors.add(new int[]{0,255,255});
      colors.add(new int[]{255,0,255});
      colors.add(new int[]{255,255,0});
      colors.add(new int[]{50,150,220});
      this.c = colors.get(this.group);
      this.started = false;
      this.stopped = stopped;
  }
  
  void display(){
    ellipseMode(CENTER);
    strokeWeight(1);
    fill(this.c[0],this.c[1],this.c[2]);
    ellipse(this.loc_x,this.loc_y,this.w,this.w);
  }
  
  void update(){
    this.checkSide();
    if(!this.stopped){
      this.loc_x += this.vel_x;
      this.loc_y += this.vel_y;
    }
  }
  
  void checkSide(){
    if(this.loc_x + this.w/2>width){
      this.vel_x *= -1;
    }
    if(this.loc_x - this.w/2<0){
      this.vel_x *= -1;
    }
  }
  
  boolean checkBubbleCollision(ArrayList<Bubble> bubbles){
      for(Bubble bubble: bubbles){
        if (dist(this.loc_x,this.loc_y,bubble.loc_x,bubble.loc_y) < this.w){
          return true;
        }
      }
     return false;
  }
  void start(float x, float y){
     this.vel_x = x - this.loc_x;
     this.vel_y = y - this.loc_y;
     float temp = (this.vel_x / sqrt((sq(this.vel_x) + sq(this.vel_y)))) * 7;
     this.vel_y = (this.vel_y / sqrt((sq(this.vel_x) + sq(this.vel_y)))) * 7;
     this.vel_x = temp;
  }

  void setLoc(){
    for(int i = 0; i < 10; i++){
      for(int j = 1; j < 12; j++){
        if((i+counter1)%2==0){
            if(dist(this.loc_x,this.loc_y,j*w*1.1 - 0.55*w,i*w*1.1+0.5*w)<w*0.9){
              this.loc_x = j*w*1.1 - 0.55*w;
              this.loc_y = i*w*1.1+0.55*w;
            }
        }else{
          if(dist(this.loc_x,this.loc_y,j*w*1.1,i*w*1.1+0.5*w)<w*0.9){
              this.loc_x = j*w*1.1;
              this.loc_y = i*w*1.1+0.55*w;
           }
        }
      }     
    } 
  }
}