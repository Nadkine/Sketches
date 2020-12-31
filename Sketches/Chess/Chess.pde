
  
  Square[][] board = new Square [8][8];
  
  float w;
  float h;
  Piece piece;
  boolean isMoving = false;
  boolean isWhiteTurn = true;
  ArrayList<Piece> blackPieces = new ArrayList();
  ArrayList<Piece> whitePieces = new ArrayList();
  ArrayList<Piece> pieces = new ArrayList();
  Piece tbr;
  Piece selectedPiece;
  PImage bB;
  PImage bK;
  PImage bN;
  PImage bP;
  PImage bQ;
  PImage bR;
  PImage wB;
  PImage wK;
  PImage wN;
  PImage wP;
  PImage wQ;
  PImage wR;
  
    public void setup(){
       size(600,600);   
       w = width/8;
       h = height/8;
       
       bB = loadImage("../Chess_bB.png");
       bK = loadImage("../Chess_bK.png");
       bN = loadImage("../Chess_bN.png");
       bP = loadImage("../Chess_bP.png");
       bQ = loadImage("../Chess_bQ.png");
       bR = loadImage("../Chess_bR.png");
       wB = loadImage("../Chess_wB.png");
       wK = loadImage("../Chess_wK.png");
       wN = loadImage("../Chess_wN.png");
       wP = loadImage("../Chess_wP.png");
       wQ = loadImage("../Chess_wQ.png");
       wR = loadImage("../Chess_wR.png");
      
       for (int x = 0; x< 8; x++){
         for (int y = 0; y< 8; y++){
           board[x][y] = new Square(x,y);
         }
       }
       for (int x = 0; x< 8; x++){
           blackPieces.add(new Pawn(x,1,false,bP));
           whitePieces.add(new Pawn(x,6,true,wP)); 
          }
       blackPieces.add(new Rook(0,0,false,bR));
       blackPieces.add(new Rook(7,0,false,bR));
       blackPieces.add(new Knight(6,0,false,bN));
       blackPieces.add(new Knight(1,0,false,bN));
       blackPieces.add(new Bishop(5,0,false,bB));
       blackPieces.add(new Bishop(2,0,false,bB));
       blackPieces.add(new King(4,0,false,bK));
       blackPieces.add(new Queen(3,0,false,bQ));
       
       whitePieces.add(new Rook(0,7,true,wR));
       whitePieces.add(new Rook(7,7,true,wR));
       whitePieces.add(new Knight(6,7,true,wN));
       whitePieces.add(new Knight(1,7,true,wN));
       whitePieces.add(new Bishop(5,7,true,wB));
       whitePieces.add(new Bishop(2,7,true,wB));
       whitePieces.add(new King(4,7,true,wK));
       whitePieces.add(new Queen(3,7,true,wQ));
       pieces.addAll(blackPieces);
       pieces.addAll(whitePieces);
   }
  
    
   public void draw (){

       bB.resize(int(w-5),int(h-5));
       bK.resize(int(w-5),int(h-5));
       bN.resize(int(w-5),int(h-5));
       bP.resize(int(w-5),int(h-5));
       bQ.resize(int(w-5),int(h-5));
       bR.resize(int(w-5),int(h-5));
       wB.resize(int(w-5),int(h-5));
       wK.resize(int(w-5),int(h-5));
       wN.resize(int(w-5),int(h-5));
       wP.resize(int(w-5),int(h-5));
       wQ.resize(int(w-5),int(h-5));
       wR.resize(int(w-5),int(h-5));

      for (int x = 0; x< 8; x++){
         for (int y = 0; y< 8; y++){
           board[x][y].drawSquare();
         }
       }
       for(Piece piece: pieces){
         piece.drawPiece();
       }
       if (selectedPiece != null){
         selectedPiece.showOptions();
       }
       
   }
   
   
   public void mouseClicked(){
     int x = int(mouseX / w); 
     int y = int(mouseY / h); 
     if (!isMoving){
       for(Piece piece: pieces){
           if (piece.x == x && piece.y == y && isWhiteTurn == piece.isWhite){
             piece.selected = true;
             selectedPiece = piece;
             if(piece.isWhite){ 
               selectedPiece.checkOptions(whitePieces,blackPieces);
             }else{          
               selectedPiece.checkOptions(blackPieces,whitePieces);
             }
             isMoving = true;
           }
       }
     }else{
       for (int[] option: selectedPiece.options){
         if (option[0] == x && option[1] == y){
           selectedPiece.options.clear();
           if(selectedPiece instanceof Rook){
              if (selectedPiece.x == 7){
                for (Piece piece : pieces){
                  if (piece instanceof King && piece.y == selectedPiece.y){
                    piece.canCastleKing = false;      
                  }
                }
                 
              }
              if (selectedPiece.x == 0){
                for (Piece piece : pieces){
                  if (piece instanceof King && piece.y == selectedPiece.y){
                    piece.canCastleQueen = false;      
                  }
                }
                 
              }
           }
           if(selectedPiece instanceof King){
             selectedPiece.canCastleKing = false;
             selectedPiece.canCastleQueen = false;
             if(x - selectedPiece.x == 2){
                  for(Piece piece: pieces){
                    if (piece.x == 7 && piece.y == selectedPiece.y){
                      piece.x = 5;
                    }
                  }
             }
             if(x - selectedPiece.x == -2){
                  for(Piece piece: pieces){
                    if (piece.x == 0 && piece.y == selectedPiece.y){
                      piece.x = 3;
                    }
                  }
             }
           }
           selectedPiece.x = x;
           selectedPiece.y = y;
           
           if(isWhiteTurn){
             for(Piece piece : blackPieces){
               if (piece.x == x && piece.y == y){
                  pieces.remove(piece);
                  tbr = piece;
               }
             }
             blackPieces.remove(tbr);
           } else{
             for(Piece piece : whitePieces){
               if (piece.x == x && piece.y == y){
                  pieces.remove(piece);
                  tbr = piece;
               }
             }
             whitePieces.remove(tbr);
           }
           isWhiteTurn = !isWhiteTurn;
           break;
         }  
       }
       isMoving = false;
       selectedPiece.selected = false;
       selectedPiece = null;
     }
   }
   
   
   
   class Square{
   
   int x;
   int y;
   public Square(int x,int y){
     
     this.x = x;
     this.y = y;
   }
   
   void drawSquare(){
     if ((this.x + this.y) % 2 == 1){
       fill(92, 153, 108);
     }else{
       fill(255,240,220);
     }
     rect(this.x * w,this.y*h,100,100);
     
   }
   
 }
 
 
 
 abstract class Piece{
 
  int x; 
  int y;
  boolean selected;
  boolean isWhite;
  ArrayList<int[]> options;
  PImage icon;
  boolean canCastleQueen;
  boolean canCastleKing;
  public Piece(){
    this(0,0,true,null);
  
  }
  public Piece(int x, int y,boolean isWhite,PImage icon){
     this.x = x;
     this.y = y;
     this.selected = false;
     this.isWhite = isWhite;
     this.icon = icon;
     this.canCastleKing = true;
     this.canCastleQueen = true;
     options = new ArrayList();
  }
 
  void drawPiece(){
    
    image(this.icon,this.x*w,this.y*h);
  };
 
 abstract void checkOptions(ArrayList<Piece> ownPieces, ArrayList<Piece> otherPieces);
 
 void showOptions(){
   fill(255,0,0);
    for(int[] option: options){
      ellipse(option[0]*w+w/2,option[1]*h+h/2,w/4,h/4);
    }
 }
}
 
 
class Pawn extends Piece{
  
  public Pawn(int x, int y, boolean isWhite,PImage icon){
    super(x,y,isWhite,icon);
  
  }
  
  public void checkOptions(ArrayList<Piece> ownPieces, ArrayList<Piece> otherPieces){
     ArrayList<Piece> allPieces = new ArrayList();
     allPieces.addAll(ownPieces);
     allPieces.addAll(otherPieces);
     boolean one_space = true;
     boolean two_space = true;
     if (this.isWhite){
        for (Piece piece: allPieces){
         if (piece.y == this.y - 1 && piece.x == this.x - 1 && piece.isWhite != this.isWhite){
           options.add(new int[]{this.x-1,this.y -1});
         }
         if (piece.y == this.y - 1 && piece.x == this.x + 1 && piece.isWhite != this.isWhite){
           options.add(new int[]{this.x+1,this.y -1});
         }
         if (piece.y == this.y - 1 && piece.x == this.x){
           one_space = false;
           two_space = false;
         }
         if (piece.y == this.y - 2 && piece.x == this.x){
           two_space = false;
         }
       }
       if (one_space){
         options.add(new int[]{this.x,this.y -1 });
       }
       if (two_space && this.y == 6){
         options.add(new int[]{this.x,this.y -2});
       }
       
     }else{
       for (Piece piece: allPieces){
         if (piece.y == this.y + 1 && piece.x == this.x - 1 && piece.isWhite != this.isWhite){
           options.add(new int[]{this.x-1,this.y +1});
         }
         if (piece.y == this.y + 1 && piece.x == this.x + 1 && piece.isWhite != this.isWhite){
           options.add(new int[]{this.x+1,this.y +1});
         }
         if (piece.y == this.y + 1 && piece.x == this.x){
           one_space = false;
           two_space = false;
         }
         if (piece.y == this.y + 2 && piece.x == this.x){
           two_space = false;
         }
       }
       if (one_space){
         options.add(new int[]{this.x,this.y +1});
       }
       if (two_space && this.y == 1){
         options.add(new int[]{this.x,this.y +2});
       }
     }
  }
  
}
 
 
 
 
 
 class King extends Piece{
  
  public King(int x, int y, boolean isWhite,PImage icon){
    super(x,y,isWhite,icon);
  
  }
  
  public void checkOptions(ArrayList<Piece> ownPieces, ArrayList<Piece> otherPieces){
     ArrayList<Piece> allPieces = new ArrayList();
     allPieces.addAll(ownPieces);
     allPieces.addAll(otherPieces);
     int[][]pos = {{1,1},{1,0},{1,-1},{0,-1},{-1,-1},{-1,0},{-1,1},{0,1}};
     for(int[] p:pos){
       int posx = p[0] + this.x;
       int posy = p[1] + this.y;
       boolean possible = true;
       for (Piece piece: ownPieces){  
          if(piece.x == posx && piece.y == posy){
            possible = false;
          }
       }
       if(possible){
          this.options.add(new int[]{posx,posy});
       }
     }
     
     //Castling
     if (this.canCastleQueen || this.canCastleKing){
       boolean oneright = true;
       boolean tworight = true;
       boolean oneleft = true;
       boolean twoleft = true;
       boolean threeleft = true;
       for (Piece piece: allPieces){
           if (this.y == piece.y && this.x + 1 == piece.x){
             oneright = false;
           }
           if (this.y == piece.y && this.x + 2 == piece.x){
             tworight = false;
           }
           if (this.y == piece.y && this.x - 1 == piece.x){
             oneleft = false;
           }
           if (this.y == piece.y && this.x - 2== piece.x){
             twoleft = false;
           }
           if (this.y == piece.y && this.x - 3 == piece.x){
             threeleft = false;
           }
         }
      if(oneright && tworight && this.canCastleKing){
         this.options.add(new int[]{this.x+2,this.y});
      }
      if(oneleft && twoleft && threeleft && this.canCastleQueen){
         this.options.add(new int[]{this.x-2,this.y});
      }
     }
  }
     
 
}

class Rook extends Piece{
  
  public Rook(int x, int y, boolean isWhite,PImage icon){
    super(x,y,isWhite,icon);
  
  }
  
  public void checkOptions(ArrayList<Piece> ownPieces, ArrayList<Piece> otherPieces){
    ArrayList<Piece> allPieces = new ArrayList();
    allPieces.addAll(ownPieces);
    allPieces.addAll(otherPieces);
    int x = 0;
    int y = 0;
    boolean cond1 = true;
    boolean cond2 = true;
    boolean cond3 = true;
    boolean cond4 = true;
    boolean add1 = false;
    boolean add2 = false;
    boolean add3 = false;
    boolean add4 = false;
    while (cond1 || cond2 || cond3 || cond4){
       x++;
       y++;
       for(Piece piece: allPieces){
         if((this.x + x == piece.x && this.y == piece.y && cond1) || this.x + x>= 8){
           cond1 = false;
           if(otherPieces.contains(piece)){
             add1 = true;
           }
         }
         if((this.x - x == piece.x  && this.y == piece.y && cond2) || this.x - x< 0){
           cond2 = false;
           if(otherPieces.contains(piece)){
             add2 = true;
           }
         }
         if((this.x == piece.x && this.y + y == piece.y && cond3) || this.y + y >= 8){
           cond3 = false;
           if(otherPieces.contains(piece)){
             add3 = true;
           }
         }
         if((this.x == piece.x && this.y - y == piece.y && cond4) || this.y - y < 0){
           cond4 = false;
           if(otherPieces.contains(piece)){
             add4 = true;
           }
         }
       }
       if(cond1 || add1) {
         this.options.add(new int[]{this.x+x, this.y});
         add1 = false;
       }
       if(cond2 || add2) {
         this.options.add(new int[]{this.x-x, this.y});
         add2 = false;
       }
       if(cond3 || add3) {
         this.options.add(new int[]{this.x, this.y+y});
         add3 = false;
       }
       if(cond4 || add4) {
         this.options.add(new int[]{this.x, this.y-y});
         add4 = false;
       }
    }
  }
  
}




class Bishop extends Piece{
  
  public Bishop(int x, int y, boolean isWhite,PImage icon){
    super(x,y,isWhite,icon);
  
  }
  
  public void checkOptions(ArrayList<Piece> ownPieces, ArrayList<Piece> otherPieces){
    ArrayList<Piece> allPieces = new ArrayList();
    allPieces.addAll(ownPieces);
    allPieces.addAll(otherPieces);
    int x = 0;
    int y = 0;
    boolean cond1 = true;
    boolean cond2 = true;
    boolean cond3 = true;
    boolean cond4 = true;
    boolean add1 = false;
    boolean add2 = false;
    boolean add3 = false;
    boolean add4 = false;
    while (cond1 || cond2 || cond3 || cond4){
       x++;
       y++;
       for(Piece piece: allPieces){
         if((this.x + x == piece.x && this.y - y == piece.y && cond1) || this.x + x>= 8){
           cond1 = false;
           if(otherPieces.contains(piece)){
             add1 = true;
           }
         }
         if((this.x - x == piece.x  && this.y + y == piece.y && cond2) || this.x - x< 0){
           cond2 = false;
           if(otherPieces.contains(piece)){
             add2 = true;
           }
         }
         if((this.x + x == piece.x && this.y + y == piece.y && cond3) || this.y + y >= 8){
           cond3 = false;
           if(otherPieces.contains(piece)){
             add3 = true;
           }
         }
         if((this.x - x == piece.x && this.y - y == piece.y && cond4) || this.y - y < 0){
           cond4 = false;
           if(otherPieces.contains(piece)){
             add4 = true;
           }
         }
       }
       if(cond1 || add1) {
         this.options.add(new int[]{this.x+x, this.y - y});
         add1 = false;
       }
       if(cond2 || add2) {
         this.options.add(new int[]{this.x-x, this.y + y});
         add2 = false;
       }
       if(cond3 || add3) {
         this.options.add(new int[]{this.x + x, this.y+y});
         add3 = false;
       }
       if(cond4 || add4) {
         this.options.add(new int[]{this.x - x, this.y-y});
         add4 = false;
       }
    }
  }
}


class Queen extends Piece{
  
  public Queen(int x, int y, boolean isWhite,PImage icon){
    super(x,y,isWhite,icon);
  
  }
  
  public void checkOptions(ArrayList<Piece> ownPieces, ArrayList<Piece> otherPieces){
    ArrayList<Piece> allPieces = new ArrayList();
    allPieces.addAll(ownPieces);
    allPieces.addAll(otherPieces);
    int x = 0;
    int y = 0;
    boolean cond1 = true;
    boolean cond2 = true;
    boolean cond3 = true;
    boolean cond4 = true;
    boolean cond5 = true;
    boolean cond6 = true;
    boolean cond7 = true;
    boolean cond8 = true;
    boolean add1 = false;
    boolean add2 = false;
    boolean add3 = false;
    boolean add4 = false;
    boolean add5 = false;
    boolean add6 = false;
    boolean add7 = false;
    boolean add8 = false;
    while (cond1 || cond2 || cond3 || cond4 || cond5 || cond6 || cond7 || cond8){
       x++;
       y++;
       for(Piece piece: allPieces){
         if((this.x + x == piece.x && this.y - y == piece.y && cond1) || this.x + x>= 8){
           cond1 = false;
           if(otherPieces.contains(piece)){
             add1 = true;
           }
         }
         if((this.x - x == piece.x  && this.y + y == piece.y && cond2) || this.x - x< 0){
           cond2 = false;
           if(otherPieces.contains(piece)){
             add2 = true;
           }
         }
         if((this.x + x == piece.x && this.y + y == piece.y && cond3) || this.y + y >= 8){
           cond3 = false;
           if(otherPieces.contains(piece)){
             add3 = true;
           }
         }
         if((this.x - x == piece.x && this.y - y == piece.y && cond4) || this.y - y < 0){
           cond4 = false;
           if(otherPieces.contains(piece)){
             add4 = true;
           }
         }
         if((this.x + x == piece.x && this.y == piece.y && cond5) || this.x + x>= 8){
           cond5 = false;
           if(otherPieces.contains(piece)){
             add5 = true;
           }
         }
         if((this.x - x == piece.x  && this.y == piece.y && cond6) || this.x - x< 0){
           cond6 = false;
           if(otherPieces.contains(piece)){
             add6 = true;
           }
         }
         if((this.x == piece.x && this.y + y == piece.y && cond7) || this.y + y >= 8){
           cond7 = false;
           if(otherPieces.contains(piece)){
             add7 = true;
           }
         }
         if((this.x == piece.x && this.y - y == piece.y && cond8) || this.y - y < 0){
           cond8 = false;
           if(otherPieces.contains(piece)){
             add8 = true;
           }
         }  
       }
       if(cond1 || add1) {
         this.options.add(new int[]{this.x+x, this.y - y});
         add1 = false;
       }
       if(cond2 || add2) {
         this.options.add(new int[]{this.x-x, this.y + y});
         add2 = false;
       }
       if(cond3 || add3) {
         this.options.add(new int[]{this.x + x, this.y+y});
         add3 = false;
       }
       if(cond4 || add4) {
         this.options.add(new int[]{this.x - x, this.y-y});
         add4 = false;
       }
       if(cond5 || add5) {
         this.options.add(new int[]{this.x+x, this.y});
         add5 = false;
       }
       if(cond6 || add6) {
         this.options.add(new int[]{this.x-x, this.y});
         add6 = false;
       }
       if(cond7 || add7) {
         this.options.add(new int[]{this.x, this.y+y});
         add7 = false;
       }
       if(cond8 || add8) {
         this.options.add(new int[]{this.x, this.y-y});
         add8 = false;
       }
    }
  }
}



class Knight extends Piece{
  
  public Knight(int x, int y, boolean isWhite,PImage icon){
    super(x,y,isWhite,icon);
  
  }
  
  public void checkOptions(ArrayList<Piece> ownPieces, ArrayList<Piece> otherPieces){
    ArrayList<Piece> allPieces = new ArrayList();
    allPieces.addAll(ownPieces);
    allPieces.addAll(otherPieces);
    int[][]pos = {{2,1},{1,2},{-1,-2},{-2,-1},{1,-2},{-1,2},{-2,1},{2,-1}};
     for(int[] p:pos){
       int posx = p[0] + this.x;
       int posy = p[1] + this.y;
       boolean possible = true;
       for (Piece piece: ownPieces){  
          if(piece.x == posx && piece.y == posy){
            possible = false;
          }
       }
       if(possible){
          this.options.add(new int[]{posx,posy});
       }
     }
  }
  
}
 
 
 
 