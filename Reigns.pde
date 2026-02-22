Scenario currentScenario;
HashMap<String, Scenario> scenarios;
PFont regularFont, boldFont, italicFont;
Button leftButton, rightButton;

void setup() {
  size(1000, 1000);

  rectMode(CENTER);
  imageMode(CENTER);

  leftButton = new Button(25, height/8, width/4-25*2, height-(height/8)*2);
  rightButton = new Button(width/2 + width/4 + 25, height/8, width/4-25*2, height-(height/8)*2);

  scenarios = GetScenarioTree();
  SwitchScenario(introScenario);

  regularFont = createFont("data/font/RobotoCondensed-Regular.ttf", 64);
  boldFont = createFont("data/font/RobotoMono-Medium.ttf", 64);
  italicFont = createFont("data/font/RobotoCondensed-Italic.ttf", 64);
}

void draw() {
  currentScenario.update();
  leftButton.update();
  rightButton.update();

  if (leftButton.IsClicked()) {
    currentScenario.leftChoice.execute();
  }

  if (rightButton.IsClicked()) {
    currentScenario.rightChoice.execute();
  }

  background(0, 128);
  fill(255);

  currentScenario.display();
  leftButton.display();
  rightButton.display();
}
