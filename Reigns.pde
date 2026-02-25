Scenario currentScenario;
HashMap<String, Scenario> scenarios;
PFont regularFont, boldFont, italicFont;
Button leftButton, rightButton;
KarmaCircle circle;
float karma;

void setup() {
  size(1000, 1000);

  rectMode(CENTER);
  imageMode(CENTER);
  
  karma = 50;
  circle = new KarmaCircle(width/2, width/2 + width/4 + width/8, karma);

  leftButton = new Button(25, height/8, width/4-25*2, height-(height/8)*2);
  rightButton = new Button(width/2 + width/4 + 25, height/8, width/4-25*2, height-(height/8)*2);

  scenarios = GetScenarioTree();
  SwitchScenario(introScenario);

  regularFont = createFont("data/font/RobotoCondensed-Regular.ttf", 64);
  boldFont = createFont("data/font/RobotoMono-Medium.ttf", 64);
  italicFont = createFont("data/font/RobotoCondensed-Italic.ttf", 64);
}

void draw() {
  leftButton.update();
  rightButton.update();
  circle.update();

  if (leftButton.IsClicked()) {
    currentScenario.leftChoice.execute();
  }

  if (rightButton.IsClicked()) {
    currentScenario.rightChoice.execute();
  }

  background(0);
  fill(255);

  currentScenario.display();
  leftButton.display();
  rightButton.display();
  circle.display();
}
