ArrayList<Integer> array = new ArrayList();
float w;
int total = 50;
int currentI = 1;
int highestI = 1;

void setup(){
   size(600,600);
   w = width/total;
    for (int i = 0; i < total; i++){
      array.add(i);
    }
    ArrayList<Integer> new_array = new ArrayList();
    while(array.size()>0){
        int i = floor(random(0,array.size()));
        int number = array.remove(i);
        new_array.add(number);
    }
    array=new_array;
}

void draw(){ 
  background(255);

  if(array.get(currentI -1) > array.get(currentI)){
    int high = array.get(currentI-1);
    int low = array.get(currentI);
    array.set(currentI-1,low);
    array.set(currentI,high);
  }else{
    highestI++;
    currentI = highestI;
    if(highestI == array.size()+1){
      noLoop();
    }
  }
  if(currentI == 1){
    highestI++;
    currentI = highestI;
  }
  currentI--;
  
  for(int i = 0; i < array.size(); i++){
    if (i == currentI || i == highestI){
      fill(255,0,0);
    }else{
      fill(0);
    }
    float h = map(array.get(i),0,total,20,height);
    rect(i*w,height-h,w,h);
  } 
  noFill();
  stroke(130);
  strokeWeight(10);
  rect(0,0,width,height);
  noStroke();
}
