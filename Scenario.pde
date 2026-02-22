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
  PVector pos, size;
  boolean dragging = false;
  Choice leftChoice, rightChoice;

  Scenario(String imgPath, String title, String message, Choice leftChoice, Choice rightChoice) {
    img = loadImage(imgPath);
    this.title = title;
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
    textSize(32);
    textFont(boldFont);
    textAlign(CENTER);
    text(title, 0, height-150);

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
