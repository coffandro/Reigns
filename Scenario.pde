class Choice {
  String label;
  String next;
  
  Choice(String label, String next) {
    this.label = label;
    this.next = next;
  }
  
  void execute() {
    if (next == "Exit") {
      exit();
    } else {
      SwitchScenario(next);
    }
  }
}

class Scenario {
  PImage img;
  String title, message;
  Choice leftChoice, rightChoice;
  PVector pos, size;
  boolean dragging = false;
  
  Scenario(String imgPath, String title, String message, Choice leftChoice, Choice rightChoice) {
    img = loadImage(imgPath);
    this.title = title;
    this.message = message;
    this.leftChoice = leftChoice;
    this.rightChoice = rightChoice;
    pos = new PVector(width/2, height/2);
    size = new PVector(width/2, width/2);
  }
  
  void drawCard() {
    pushMatrix();
    
    if (dragging) {
      float drag = max(min(float(mouseX), width), 0);
      translate(width/4 + pos.x * drag/float(width), pos.y);
      rotate(drag/float(width)*PI/4-PI/8);
    } else {
      translate(pos.x, pos.y);
    }
    
    fill(240, 217, 175);
    rect(0, 0, size.x, size.y, 25);
    
    image(img, 0, 0, width/4, width/4);
    
    popMatrix();
  }
  
  void drawTexts() {
    pushMatrix();
    translate(width/2, 0);
    
    fill(0);
    textSize(32);
    textFont(boldFont);
    textAlign(CENTER);
    text(title, 0, height-150);
   
    rectMode(LEFT);
    textAlign(LEFT);
    textFont(regularFont);
    textSize(24);
    text(message, -width/4 + 50, 50, width/4 - 50, height/4 - 25);
    rectMode(CENTER);
    
    fill(255);
    textAlign(LEFT);
    text(leftChoice.label, -width/2 + 50, height/4);
    
    textAlign(RIGHT);
    text(rightChoice.label, width/2 - 50, height/4);
    
    //textAlign(CENTER);    
    popMatrix();
  }
  
  void display() {
    rect(width/2, height/2, width/2, height, 25);
    drawTexts();
    drawCard();
  }
}
