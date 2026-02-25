class Choice {
  String label;
  String next;
  float karmaMod;

  Choice(String _label, String _next, float _karmaMod) {
    label = _label;
    next = _next;
    karmaMod = _karmaMod;
  }

  void execute() {
    if (next == "Exit") {
      exit();
      return;
    } else {
      SwitchScenario(next);
    }
    
    UpdateKarma(karmaMod);
  }
}

class Scenario {
  PImage img;
  String message;
  PVector pos, size;
  boolean dragging = false;
  Choice leftChoice, rightChoice;

  Scenario(String imgPath, String message, Choice leftChoice, Choice rightChoice) {
    img = loadImage(imgPath);
    this.message = message;
    
    pos = new PVector(width/2, height/2);
    size = new PVector(width/2, width/2);
    
    this.leftChoice = leftChoice;
    this.rightChoice = rightChoice;
  }

  void drawCard() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(240, 217, 175);

    image(img, 0, 0, size.x, size.y);

    popMatrix();
  }

  void drawTexts() {
    pushMatrix();
    translate(width/2, 0);

    fill(0);

    rectMode(LEFT);
    textFont(regularFont);
    textSize(24);
    text(message, -width/4 + 50, 50, width/4 - 50, height/4 - 25);

    rectMode(CORNER);
    fill(255);
    textSize(32);

    rectMode(CENTER);

    popMatrix();
  }

  void display() {
    rectMode(CENTER);
    rect(width/2, height/2, width/2, height, 25);
    drawTexts();

    drawCard();
  }
}
