/**
 *
 * @author tjeer
 */

  float[][] bufferNew = new float[800][800];
  float[][] bufferOld = new float[800][800];
  float demping = 0.95f;
  

  public void setup(){
     size(500,500,P2D);
       for (int i = 0; i < width; i++){
           for (int j = 0; j < height; j++){  
                bufferOld[i][j] = 0;
                bufferNew[i][j] = 0;           
             }
      }
}
  
  
  public void draw(){

      loadPixels();
      
      for (int i = 1; i < width-1; i++){
           for (int j = 1; j < height-1; j++){                   
                bufferNew[i][j] = (bufferOld[i-1][j] + bufferOld[(i+1)][j] + bufferOld[i][(j+1)] + bufferOld[i][(j-1)]) / 2 - bufferNew[i][j];          
                 bufferNew[i][j] = bufferNew[i][j] *demping; 
                  pixels[i+j*width] = color(bufferNew[i][j]*255);
             }
      }
      float[][]temp = bufferNew;
      bufferNew = bufferOld;
      bufferOld = temp;
      updatePixels();
      
  }

  public void mouseClicked() {
      bufferNew[mouseX][mouseY] = 255;
  }
  
