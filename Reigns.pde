Button leftBTN, rightBTN;
Scenario currentScenario;
HashMap<String, Scenario> scenarios;

void SwitchScenario(String newScenario) {
  currentScenario = scenarios.get(newScenario);
  leftBTN.text = currentScenario.leftChoice.label;
  rightBTN.text = currentScenario.rightChoice.label;
}

void setup() {
  size(640, 480);
  
  leftBTN = new Button(width/4 + 10, height - 70, 100, 50, "Left");
  rightBTN = new Button(width/4 + width/2 - 110, height - 70, 100, 50, "Right");
  scenarios = GetScenarioTree();
  SwitchScenario("Intro");
}

void draw() {
  background(0);
  fill(255);
  
  currentScenario.display();
  
  if (leftBTN.isPressed()) {
    currentScenario.leftChoice.execute();
  }
  
  if (rightBTN.isPressed()) {
    currentScenario.rightChoice.execute();
  }
}
