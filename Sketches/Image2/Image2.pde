

float xOffset = 10f;
float yOffset = 0f;
int x;
int y;
PImage img;
PImage bimg;
int length = 500;
int grootte = 20;
int scl = 12;
int xLoc =400;
int yLoc = 400;
int count = 1;
//ArrayList<Ball> balls = new ArrayList();
int i; 
int j;
float xoffset = 0;
float yoffset = 10f;

public void preload() {
    
}

public void setup(){
    size(600,600);
    img = loadImage("../Tjeerd.jpg");
    i = (int)(Math.random()*width);
    j = (int)(Math.random()*height);
    background(255);
    noStroke();
    img.loadPixels();
    frameRate(400);
    //image(img, 600, 0)
}

public void  draw(){
    
    img.resize(600,600);
    for (int x = 0; x < 20; x++){
      xoffset += 0.001f;
      yoffset += 0.002f;
      i = (int)(noise(xoffset)*1500-380);
      j = (int)(noise(yoffset)*1500-380);
      if (i < 1){ i = width-1;} 
      if (i > width-1){ i = 1;}
      if (j < 1){ j = height-1;}
      if (j > height-1){ j = 1;}
      fill(color((float)red(img.pixels[i+j*width]),(float)green(img.pixels[i+j*width]),(float)blue(img.pixels[i+j*width])),10f);
      ellipse(i,j,grootte,grootte);      
    }
}


