
  Button blueButton;
  Button redButton;
  Button greenButton;
  Button yellowButton;
  Button purpleButton;
  ArrayList<Button> reeks;
  int currentReeks = -1;
  ArrayList<Button> guess;
  int currentGuess = -1;
  ArrayList<Button> buttons;
  boolean showState = true;
  int frameCounter = 0;
  boolean pause1 = true;
  boolean pause2 = false;

  public void setup() {
      size(400,400);
      blueButton = new Button(100,100,200,200,150,225,225,150,255,255);
      redButton = new Button(0,0,200,200,225,100,100,255,150,150);
      greenButton = new Button(200,0,200,200,100,225,100,150,255,150);
      yellowButton = new Button(0,200,200,200,225,225,100,255,255,150);
      purpleButton = new Button(200,200,200,200,225,100,225,255,150,255);
      reeks = new ArrayList();
      guess = new ArrayList();
      buttons = new ArrayList();
      buttons.add(blueButton);
      buttons.add(redButton);
      buttons.add(greenButton);
      buttons.add(yellowButton);
      buttons.add(purpleButton);
      for (int n = 0; n < 1; n++) {
          reeks.add(buttons.get((int)random(buttons.size())));
      }
  }

  public void draw() {
  renderButtons();
  if (frameCounter-- < 0) {
      if (pause1) {
              pause1 = false;
              pause2 = true;
              waitSome(60);
              depressButtons();
      } else if (pause2){
              waitSome(40);
              pause2 = false;
      } else {
          renderButtons();
          if (showState) {
              depressButtons();
              if (++currentReeks == reeks.size()){
                  showState = false;    

              } else {
                  reeks.get(currentReeks).isPressed = true;    
              }
              renderButtons();
              waitSome(30);
              } 
          }  
      }
  }
  public void mousePressed() {
      if (!showState) {
          depressButtons();
          if (mouseX > 100 && mouseX < 300 && mouseY < 300 && mouseY > 100) {
                  blueButton.pressButton();
          }
          else if (mouseX > 0 && mouseX < 200 && mouseY < 200 && mouseY > 0) {
                  redButton.pressButton();
          }
          else if (mouseX > 200 && mouseX < 400 && mouseY < 200 && mouseY > 0) {
                  greenButton.pressButton();
          }
          else if (mouseX > 0 && mouseX < 200 && mouseY < 400 && mouseY > 200) {
                  yellowButton.pressButton();
          }
          else if (mouseX > 200 && mouseX < 400 && mouseY < 400 && mouseY > 200) {
                  purpleButton.pressButton();
          }
          for (Button button : buttons) {
              if (button.isPressed) {
                  if (reeks.get(++currentGuess) != button) {
                          reeks.clear();
                  }
              }    
          }

          if (currentGuess >= reeks.size()-1) {
              currentReeks = -1;
              currentGuess = -1;
              reeks.add(buttons.get((int)random(buttons.size())));
              showState = true;
              pause1 = true;
          }
      }
  }

  public void showScore() {
      fill(0);
      textSize(20);
      text(reeks.size(), width/2, height/2);
  }
  public void waitSome(int someTime) {
      frameCounter = someTime;
  }
  public void depressButtons(){
      for (int j = 0; j < buttons.size(); j++) {
          buttons.get(j).isPressed = false;
      }
  }

  public void renderButtons() {
      strokeWeight(3);  
      redButton.render();
      greenButton.render();
      yellowButton.render();
      purpleButton.render();
      blueButton.render();
      showScore();
  }

  public class Button {    
      float x;
      float y;
      float w;
      float h; 
      int red;
      int green;
      int blue;
      int redpressed;
      int greenpressed;
      int bluepressed;
      boolean isPressed;
      public Button (float x, float y, float w, float h, int red, int green, int blue, int redpressed, int greenpressed, int bluepressed) {
          this.x = x;
          this.y = y;
          this.w = w;
          this.h = h;
          this.red = red;
          this.green = green;
          this.blue = blue;
          this.redpressed = redpressed;
          this.greenpressed =greenpressed;
          this.bluepressed = bluepressed;
          this.isPressed = false;
      }

      public void render() {
          if (this.isPressed) {
              fill(this.redpressed, this.greenpressed, this.bluepressed);
          } else {
              fill(this.red, this.green, this.blue);
          }
          rect(this.x,this.y, this.w,this.h);
      }

      public void pressButton(){
          this.isPressed = true;
      }
  }
