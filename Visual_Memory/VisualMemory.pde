ArrayList<Square> board;
int timeElapsed;
boolean pickPhase;
int pickCounter;
int boardSize;
int toBePicked;
int[] boardSizeArray;
int boardSizeCounter;
int score;
int lives;
float indention = 1;
int highscore;
void setup(){
  size(600,600);
  boardSizeArray = new int[]{4,4,5,5,5,5,6,6,6,6,6,6,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8};
  reset();
}

void draw(){
  if (++timeElapsed > 120){
     pickPhase = true;
   }
  for (int i = 0; i < boardSize; i++){
    for (int j = 0; j < boardSize; j++){
      Square square = board.get(j+i*boardSize);    
      if(!pickPhase && !square.toBePicked){
        square.displayObservePhase();
      }else if(pickPhase && !square.isPicked){
        square.displayPickPhase();
      }
    }
  }  
  
  for (int i = 0; i < boardSize; i++){
    for (int j = 0; j < boardSize; j++){
      Square square = board.get(j+i*boardSize);    
      if(!pickPhase && square.toBePicked){
        square.displayObservePhase();
      }else if(pickPhase && square.isPicked){
        square.displayPickPhase();
      }
    }
  }
  
    textSize(50);
    fill(255,0,0);
    text(score,50, 50);
    if(lives > 0){
      text('X',width-125,50);
    }
    if(lives > 1){
      text('X',width-75,50);
    }
}

void nextLevel(){
  score++;
  boardSizeCounter++;
  boardSize = boardSizeArray[boardSizeCounter];
  board = new ArrayList();
  for (int i = 0; i < boardSize; i++){
    for (int j = 0; j < boardSize; j++){
      board.add(new Square(i,j,width/boardSize));
    }
  }
  toBePicked++;
  pickCounter = 0;
  setToBePicked(toBePicked);
  timeElapsed = 0;
  pickPhase = false;
}

void reset(){
  lives = 0;
  score = 3;
  boardSizeCounter = 0;
  boardSize = boardSizeArray[boardSizeCounter];
  board = new ArrayList();
  for (int i = 0; i < boardSize; i++){
    for (int j = 0; j < boardSize; j++){
      board.add(new Square(i,j,width/boardSize));
    }
  }
  toBePicked = 3;
  pickCounter = 0;
  setToBePicked(toBePicked);
  timeElapsed = 0;
  pickPhase = false;
}

void mousePressed(){
  timeElapsed = 200;
  int i = int(mouseX / (width / boardSize));
  int j = int(mouseY / (height / boardSize));
  if (!board.get(j+i*boardSize).isPicked){
    if(!board.get(j+i*boardSize).toBePicked){
      lives++;
      if (lives > 2){
        reset();
      }
    }else{
      board.get(j+i*boardSize).isPicked = true;
      pickCounter++;
      if (pickCounter == toBePicked){
        nextLevel();
      }
    }
  }
}

void setToBePicked(int amount){
  ArrayList<Square> board_copy = (ArrayList<Square>)board.clone();
  for (int i = 0; i < amount; i++){
    Square square = board_copy.remove((int)random(board_copy.size()));
    square.toBePicked = true;
  }
}


class Square{

  
  int x;
  int y; 
  int w; 
  boolean toBePicked;
  boolean isPicked;
  
  Square(int x, int y, int w){
    this.x = x;
    this.y = y;
    this.w = w;
    this.toBePicked = false;
    this.isPicked = false;
  }

  void displayObservePhase(){
    strokeWeight(2);
    stroke(128);
    if(this.toBePicked){
      fill(125);
      rect(this.x * this.w, this.y * this.w,this.w,this.w);
      fill(255);
      rect(this.x * this.w + indention, this.y * this.w-indention,this.w+indention ,this.w);
      
    }
    else{
      fill(0);
      rect(this.x * this.w, this.y * this.w,this.w,this.w);
    }
  }
  
  void displayPickPhase(){
    strokeWeight(2);
    stroke(128);
    if(this.isPicked){   
      fill(125);
      rect(this.x * this.w, this.y * this.w,this.w,this.w);
      fill(255);
      rect(this.x * this.w + indention, this.y * this.w-indention,this.w+indention ,this.w);
    }
    else{
      fill(0);
      rect(this.x * this.w, this.y * this.w,this.w,this.w);
    }
  }
  
}
