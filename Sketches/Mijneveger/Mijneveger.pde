

  int rows;
  int cols;
  int resolution = 50;
  Cell[][]grid;

  
  public void setup(){
      size(700,700);
      background(201);

      cols = width/resolution;
      rows = height/resolution;
      grid = new Cell[rows][cols];
      for (int i = 0; i < rows; i++){
          for (int j = 0; j < cols; j++){
              grid[i][j] = new Cell(i, j,resolution);
              if (random(10)<1){
                  grid[i][j].bomb = true;
              }
          }
      }
      for (int i = 0; i < cols; i++){
          for (int j = 0; j < rows; j++){
              grid[i][j].calcNeightbours(grid);
          }
      }
  }
  
  public void draw(){
      for (int i = 0; i < cols; i++){
          for (int j = 0; j < rows; j++){
              grid[i][j].drawCell();
          }
      }
  }
  
  public void keyPressed(){
      int x = mouseX;
      x /= resolution;
      x = (int)Math.floor(x);
      int y = mouseY;
      y /= resolution;
      y = (int)Math.floor(y);
      grid[x][y].guessed = !grid[x][y].guessed ;
  }
  public void mousePressed(){
    
      int x = mouseX;
      x /= resolution;
      x = (int)Math.floor(x);
      int y = mouseY;
      y /= resolution;
      y = (int)Math.floor(y);
      grid[x][y].hidden= false;
      if (grid[x][y].bomb){
          grid[x][y].drawCell();
          for (int i = 0; i < rows; i++){
          for (int j = 0; j < cols; j++){
              if ( grid[i][j].bomb){
                  grid[i][j].done = true;
                  grid[i][j].hidden = false;
                  grid[i][j].drawCell();
              }
          }
      }
          textSize(80);
          text("YOU FAILED!!", 20,250);
          noLoop();
      }
      if (grid[x][y].neighbours == 0 && !grid[x][y].bomb){
          emptySpace(x,y);
      }
  
  }
  public void emptySpace(int x, int y){
     Cell cgc= grid[x][y];
     cgc.hidden = false;
    
     if (cgc.neighbours == 0 && !cgc.bomb){
         if (cgc.x> 0 && !grid[cgc.x-1][cgc.y].bomb && grid[cgc.x-1][cgc.y].neighbours == 0 && grid[cgc.x-1][cgc.y].hidden==true ){              
             emptySpace(cgc.x-1,cgc.y);
         }
         if (cgc.y >0 && !grid[cgc.x][cgc.y-1].bomb && grid[cgc.x][cgc.y-1].neighbours == 0 && grid[cgc.x][cgc.y-1].hidden==true){
             emptySpace(cgc.x,cgc.y-1);
         }
         if (cgc.x < grid[0].length-1 && !grid[cgc.x+1][cgc.y].bomb && grid[cgc.x+1][cgc.y].neighbours == 0 && grid[cgc.x+1][cgc.y].hidden==true) {
             emptySpace(cgc.x+1,cgc.y);
         }
         if (cgc.y < grid.length-1 && !grid[cgc.x][cgc.y+1].bomb && grid[cgc.x][cgc.y+1].neighbours == 0 && grid[cgc.x][cgc.y+1].hidden==true){
             emptySpace(cgc.x,cgc.y+1);
         }
     }     
     if (x > 0){
     grid[cgc.x-1][cgc.y].hidden = false;
     } if (y > 0){
     grid[cgc.x][cgc.y-1].hidden = false;
     } if (x < grid[0].length-1){
     grid[cgc.x+1][cgc.y].hidden = false;
     } if (y < grid[0].length-1){
     grid[cgc.x][cgc.y+1].hidden = false;
     }
  
  }
      

 class Cell {
      private boolean done = false;
      private int x;
      private int y;
      private int w;
      private boolean bomb = false;
      private boolean hidden = true;
      private int neighbours;
      boolean guessed = false;
      
      
      public Cell(int x, int y, int w){
          this.x = x;
          this.y = y;
          this.w = w;
      }

      public void drawCell(){
          
          strokeWeight(1);
          stroke(0);
          if (!hidden){          
              fill(221);
              if (this.done){ fill(255,0,255);}
              rect(this.x*this.w,this.y*this.w,this.w,this.w);
              if (this.bomb){
                  fill(51);
                  ellipse(x*this.w+this.w/2,y*this.w+this.w/2,this.w/2,this.w/2);
              } else { 
                  if (this.neighbours != 0){
                      fill(0);
                      textSize(15);
                      text(this.neighbours,this.x*this.w+this.w/2,this.y*this.w+this.w/2);
                  }
              }
          } else {
              if (this.guessed){
             fill(255,0,0);
              } else {
              fill(131);
              }
             rect(this.x*this.w,this.y*this.w,this.w,this.w);
             fill(0);
          }
      }
      
      public void calcNeightbours(Cell[][] grid){         
         int sum = 0;
        //orthogonaal
         if (this.x> 0 && grid[this.x-1][this.y].bomb){
             sum++;
         }
         if (this.y >0 && grid[this.x][this.y-1].bomb){
             sum++;
         }
         if (this.x < grid.length-1 && grid[this.x+1][this.y].bomb){
             sum++;
         }
         if (this.y < grid[0].length-1 && grid[this.x][this.y+1].bomb){
             sum++;
         }
         //diagonals
         if (this.x> 0 && this.y> 0 && grid[this.x-1][this.y-1].bomb){
             sum++;
         }
         if (this.x >0 && this.y < grid[0].length-1 && grid[this.x-1][this.y+1].bomb){
             sum++;
         }
         if (this.x < grid.length-1 && this.y> 0 && grid[this.x+1][this.y-1].bomb){
             sum++;
         }
         if (this.x < grid.length-1 &&  this.y < grid[0].length-1 && grid[this.x+1][this.y+1].bomb){
             sum++;
         }
         this.neighbours = sum;
      }
  }


