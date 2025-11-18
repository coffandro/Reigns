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
  
  Scenario(String imgPath, String title, String message, Choice leftChoice, Choice rightChoice) {
    img = loadImage(imgPath);
    this.title = title;
    this.message = message;
    this.leftChoice = leftChoice;
    this.rightChoice = rightChoice;
  }
  
  void display() {
    fill(240, 217, 175);
    rect(width/4, 10, width/2, height - 20, 25);
    
    image(img, width/4 + 75, 50, width/4, width/4);
    
    fill(0);
    textSize(32);
    textAlign(CENTER);
    text(title, width/2, 40);
    
    textSize(16);
    text(message, width/2, height/2 - 10);
  }
}
