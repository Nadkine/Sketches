Cell currentCell, nextCell;
Cell[][] board;
ArrayList<Cell> stackTrace = new ArrayList();
int resolution = 20;
int cols,rows;
boolean start = true;

public void setup() {
    size(600,600,P2D);
    cols = width/resolution;
    rows = height/resolution;
    board = new Cell[cols][rows];
    initiateBoard();
    calculateAllNeighbours();
    currentCell = board[0][0];
    currentCellStuff(board[0][0]);
    frameRate(100);
  }

private void currentCellStuff(Cell cell) {
    currentCell.isCurrent = false;                      
    currentCell = cell;
    currentCell.isVisited = true;
    currentCell.isCurrent = true;        
}

private void calculateAllNeighbours() {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            board[i][j].calculateNeigbours(board);
        }
    }             
}

private void initiateBoard() {
    for (int i = 0; i < rows; i ++) {
        for (int j = 0; j < cols; j++) {
            board[i][j] = new Cell(i,j,resolution);
        }
    }
}

public void removeWalls(Cell cell1, Cell cell2) {
    if (cell1.x - cell2.x == -1) {
        cell1.rightWall = false;
        cell2.leftWall = false;
    } else if (cell1.x - cell2.x == 1) {
        cell1.leftWall = false;
        cell2.rightWall = false;
    } else if (cell1.y - cell2.y == 1) {
        cell1.topWall = false;
        cell2.botWall = false;
    } else if (cell1.y - cell2.y == -1) {
        cell1.botWall = false;
        cell2.topWall = false;                                   
    }
}

public void draw() {
    background(0);
    //1: get unvisited neighbours currentCell
    ArrayList<Cell> neighbours = currentCell.neighbours;
    ArrayList<Cell> goodneighbours = new ArrayList();
    for (Cell cell: neighbours) {
        if (!cell.isVisited) {
                       goodneighbours.add(cell);
        }
    }

    //2: if none, go 1 back in stacktrace 
    if (stackTrace.size() == 0 && !start){
      noLoop();
    }
    else if (goodneighbours.size() == 0) {
        nextCell = stackTrace.get(stackTrace.size() - 1);
        stackTrace.remove(stackTrace.size() - 1);
    //4: else make neighbour nextcurrent cell
    } else {                 
      nextCell = goodneighbours.get((int)random(goodneighbours.size()));                        
      stackTrace.add(nextCell);
      removeWalls(currentCell, nextCell);
    }
    start = false;
    currentCellStuff(nextCell);

    //3: remove walls between current and neighbour

    //5 add currentCell to stackTrace


    //6 draw cells
    fill(212);
    for (int i = 0; i < rows; i ++) {
        for (int j = 0; j < cols; j++) {
                       board[i][j].show();
        }
    }
}

class Cell{
    boolean leftWall = true;
    boolean topWall = true;
    boolean rightWall = true;
    boolean botWall = true;
    ArrayList<Cell> neighbours;
    int x;
    int y;
    float w;
    boolean isCurrent = false;
    boolean isVisited = false;

    public Cell(int x, int y, float w) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.neighbours = new ArrayList();

    }

    public void calculateNeigbours(Cell[][] board) {
      if (x>0) {
         this.neighbours.add(board[this.x-1][this.y]);
      }
      if (x<board.length-1) {
         this.neighbours.add(board[this.x+1][this.y]);
      }
      if (y>0) {
         this.neighbours.add(board[this.x][this.y-1]);
      }
      if (y<board[0].length-1) {
         this.neighbours.add(board[this.x][this.y+1]);
      }
    }

    public void show() {
      if (isCurrent) {
                     fill(255,125,0);
      } else if (isVisited){
                     fill(0,125,225);
      } else {
                     fill(212);
      }
      noStroke();
      rect(this.x*this.w,this.y*this.w,this.w,this.w);
      stroke(1);
      if (leftWall) {
                     line(this.x*this.w,this.y*this.w,this.x*this.w,(this.y+1)*this.w);
      }
      if (topWall) {
                     line(this.x*this.w,this.y*this.w,(this.x+1)*this.w,(this.y)*this.w);
      }
      if (rightWall) {
                     line((this.x+1)*this.w,this.y*this.w,(this.x+1)*this.w,(this.y+1)*this.w);
      }
      if (botWall) {
                     line((this.x)*this.w,(this.y+1)*this.w,(this.x+1)*this.w,(this.y+1)*this.w);
      }
    }

}

