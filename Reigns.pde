Scenario currentScenario;
HashMap<String, Scenario> scenarios;
PVector mousePos;
PFont regularFont, boldFont, italicFont;

void SwitchScenario(String newScenario) {
  currentScenario = scenarios.get(newScenario);
}

void setup() {
  size(1000, 1000);
  rectMode(CENTER);
  imageMode(CENTER);
  
  mousePos = new PVector();
  
  scenarios = GetScenarioTree();
  SwitchScenario("Intro");
  regularFont = createFont("RobotoCondensed-Regular.ttf", 64);
  boldFont = createFont("RobotoMono-Medium.ttf", 64);
  italicFont = createFont("RobotoCondensed-Italic.ttf", 64);
}

void draw() {
  mousePos.set(mouseX, mouseY);
  
  background(0);
  fill(255);
  
  if (isHovered(currentScenario.pos, currentScenario.size) && mousePressed) {
    currentScenario.dragging = true;
  }
  
  currentScenario.display();
}

void mouseReleased() {
  if (currentScenario.dragging) {
    if (mouseX < width/4) {
      currentScenario.leftChoice.execute();
    } else if (mouseX > width/2 + width/4) {
      currentScenario.rightChoice.execute();
    } else {
      currentScenario.dragging = false;
    }
  }
}
