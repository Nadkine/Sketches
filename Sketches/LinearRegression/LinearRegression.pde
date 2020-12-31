import java.util.ArrayList;
import java.util.List;
import java.util.stream.DoubleStream;
import java.util.Collections;
import processing.core.PApplet;
import processing.core.PVector;

/**
 *
 * @author tjeer
 */
double bl;
double al;
double ag;
double bg;
double learning_rate = 0.05;
List<PVector> data = new ArrayList();

public void setup(){
    size(600,600);
}
public void draw(){
    background(50);
    if (data.size()>1){
    linearRegression(data);
    gradientDescent(data);
    fill(255);
    stroke(255);
    float x1 = 0;
    float y1 = map((float)al,0,1,height,0);
    float x2 = width;
    float y2 = map((float)(al+bl),0,1,height,0);
    line(x1,y1,x2,y2);
    stroke(255,0,255);
    float xg1 = 0;
    float yg1 = map((float)ag,0,1,height,0);
    float xg2 = width;
    float yg2 = map((float)(ag+bg),0,1,height,0);
    line(xg1,yg1,xg2,yg2);
    }
    noStroke();
     for (PVector point: data){
        float drawX = map(point.x,0,1,0,width);            
        float drawY = map(point.y,0,1,height,0);
        ellipse(drawX,drawY,8,8);
    }
}

public void mousePressed(){
    float x = map(mouseX,0,width,0,1);
    float y = map(mouseY,0,height,1,0);
    data.add(new PVector(x,y));
}

private void linearRegression(List<PVector> data) {
    double num =0;
    double den = 0;
    double sumX =0;
    double sumY =0;
    for(PVector point: data){
      sumX += point.x;
      sumY += point.y;
    } 
    double xMean = sumX / data.size();
    double yMean = sumY / data.size();
    
    for (PVector point : data){
        num += (point.x - xMean)*(point.y - yMean);
        den += (point.x - xMean)*(point.x - xMean);
    }
    bl = num/den;
    al= yMean - bl*xMean;
}

private void gradientDescent(List<PVector> data) {
    for (PVector point : data){
       double guess = ag + bg * point.x;
       double error = point.y - guess;
       bg = bg + (error*point.x) * learning_rate;
       ag = ag + (error) * learning_rate;
    }
}


