ArrayList<Integer> array = new ArrayList();
float w;
int total = 200;
int lowestI = 0;
int currentI = 1;
int n = 0;
ArrayList<Integer> partitions = new ArrayList();
int partitionI;
int number;
int temp; 
int prevLow;
int prevHigh;
int precision = 5;

int highestI = total;
boolean insertionSortStarted = false;

void setup(){
   size(600,600);
   w = width/total;
    for (int i = 0; i <= total; i++){
      array.add(i);
    }
    ArrayList<Integer> new_array = new ArrayList();
    while(array.size()>0){
      int i = floor(random(0,array.size()));
      int number = array.remove(i);
      new_array.add(number);
    }
    array=new_array;
    fill(0);
    prevLow = 0;
    prevHigh = total;
    partitions.add(lowestI);
    partitions.add(highestI);
    partitionI = floor((partitions.get(0) + partitions.get(1))/ 2);
    number = array.get(partitionI);
    
}

void draw(){
  background(255);
  if (!insertionSortStarted){
    partitionSort();
    if (highestI - lowestI == 0){
      partitions.remove(0);
      partitions.remove(0);
      if (lowestI - prevLow > precision){
          partitions.add(prevLow);
          partitions.add(lowestI-1);
      }
      if (prevHigh - highestI > precision){
          partitions.add(highestI+1);
          partitions.add(prevHigh);
       }
    
      if (partitions.size()>0){
          lowestI = partitions.get(0);
          prevLow = lowestI;
          highestI = partitions.get(1);
          prevHigh = highestI;
          partitionI = floor((lowestI + highestI)/ 2);
          number = array.get(partitionI);
          n = lowestI;
      }else{
          insertionSortStarted = true;
          highestI = 1;
      }
     }
  }else{
    insertionSort();
  }
  
  for(int i = 0; i < array.size(); i++){
    if (i == lowestI || i == highestI){
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

void partitionSort(){
  temp = array.get(n);
  if (array.get(n) > number){
     array.set(highestI,temp);
     highestI--;
     n = highestI;
  }else{
    array.set(lowestI,temp);
    lowestI++;
    n = lowestI;
  }
}

void insertionSort(){
  lowestI = currentI;
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
}
