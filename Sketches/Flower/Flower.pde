import java.util.List;
import javax.swing.text.NumberFormatter;
import processing.core.*;

double realDistance = 2;
int distance = 2;
int x = 1;
double growthSpeed = 0.1;
int sizeflower = 2;
double formule = ((2*Math.PI)/((1+Math.sqrt(5))/2));

public void setup() { 
    size(700,700,P2D);
    background(180);
    translate(width/2, height/2);
    fill(0,0,0);
    ellipse(0, 0, sizeflower,sizeflower);
}
public void draw(){
    x++;
    translate(width/2, height/2);
    rotate((float)formule*x);

    for (int i= 0; i<1; i++){
        realDistance += growthSpeed;
        distance = (int)realDistance;
        ellipse(distance,distance, sizeflower,sizeflower);
    }
}

