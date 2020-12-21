
/**
 *
 * @author tjeer
 */

List<PVector> cities = new ArrayList();
List<Integer> order = new ArrayList();
List<Integer> best_order = new ArrayList();
int cities_amount = 7;
float count = 1;
float factorial_sum;
float best_sum = 10000;
Lexicographic lg = new Lexicographic();

public void setup(){
    size(700,400);
    //fullScreen();
    for (int i = 0; i < cities_amount; i++){
        order.add(i);
        cities.add(new PVector(random(width),random(height/2)));
        best_order.add(i);
    }
    factorial_sum = factorial(cities_amount);
}    
public void draw(){
    for (int j = 0; j < 1; j++){
    List<Integer> next_order = lg.nextOrder(order);
    order = next_order;
    background(51);
    stroke(251);
    drawCities(cities);
    strokeWeight(3);
    drawRoutes(cities,order,false);
    float current_sum = calculateRoutes(cities,order);
    if (current_sum < best_sum){
        best_order.clear();
        for(Integer index : next_order){
            best_order.add(index);
        }
        best_sum = current_sum;            
    }      
    strokeWeight(3);
    stroke(255,0,255);
    drawRoutes(cities,best_order,true);
        textSize(20);
    double percent = (count/factorial_sum)*100;
    String percentage = " " + percent + '%';
        text(percentage, 50, height-50);
    if (++count == factorial_sum){
        noLoop();
    }
}      
}

public void drawCities(List<PVector> cities){
    fill(201);
    line(0,height/2,width,height/2);
    for(int i = 0; i < cities.size(); i++){
        PVector city = cities.get(i);
        ellipse(city.x,city.y,16,16);
        ellipse(city.x,city.y+height/2,16,16);
        }   
}

public void drawRoutes(List<PVector> cities,List<Integer> thisOrder,boolean best){
    
    PVector previous_city = cities.get(thisOrder.get(0));
    for(int i = 0; i < cities.size(); i++){
        PVector city = cities.get(thisOrder.get(i));
        if (best){
        line(city.x,city.y+height/2,previous_city.x,previous_city.y+height/2);
        }else{
        line(city.x,city.y,previous_city.x,previous_city.y);
        }
        previous_city = city;

    }
}
public float calculateRoutes(List<PVector> cities,List<Integer> thisOrder){
        float sum = 0;
        PVector previous_city = cities.get(thisOrder.get(0));
        for(int i = 1; i < cities.size(); i++){
        PVector city = cities.get(thisOrder.get(i));
        sum += dist(city.x,city.y,previous_city.x,previous_city.y);
        previous_city = city;
    } 
        return sum;
}
public int factorial(int n){
    if (n==1){
        return 1;
    } else{ 
        return n * factorial(n-1);
    }
}


class Lexicographic{
    
    List<Integer> list = new ArrayList();
    int length = 10;
    
    public List<Integer> nextOrder(List<Integer> list){
        int greatestI = -1;
        for (int i =0 ; i < list.size()-1; i++){
            if ((list.get(i)) < list.get(i+1)){
                greatestI = i;
            }
        }
        if (greatestI == -1){       
            return null;
        }
        int greatestJ = -1;
        for (int j =0 ; j < list.size(); j++){
            if (list.get(greatestI) < list.get(j)){
                greatestJ = j;
            }
        }
        
        int temp = list.get(greatestI);
        list.set(greatestI,list.get(greatestJ));
        list.set(greatestJ,temp);
        
        
        List<Integer> listStart = new ArrayList();
        for (int n = 0; n < greatestI+1; n++){
            listStart.add(list.get(n));
        }
         List<Integer> listEnd = new ArrayList();
        for (int n = greatestI+1; n < list.size(); n++){
            listEnd.add(list.get(n));
        }
        list.clear();
        for (int n =  0; n < listStart.size(); n++){
            list.add(listStart.get(n));
         }
        for(int n = listEnd.size()-1; n >=0; n--){
            list.add(listEnd.get(n));
        } 
        return list;
    }
    
    
}




