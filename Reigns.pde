Button btn;
int counter = 0;

void setup() {
  size(640, 480);
  
  btn = new Button(10, 10, 100, 50, "Press me!");
  btn.defaultC = new ColorCombo(color(255, 0, 0), color(255));
  btn.hoverC = new ColorCombo(color(150, 0, 0), color(255));
  btn.downC = new ColorCombo(color(100, 0, 0), color(255));
}

void draw() {
  background(0);
  fill(255);
  
  if (btn.isPressed()) {
    counter++;
    btn.text = str(counter);
    print("pressed!");
  }
}
