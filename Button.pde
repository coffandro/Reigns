class Button {
  PVector pos, size;
  ColorCombo defaultC, hoverC, downC;
  float bevel;
  boolean lastState = false;
  String text;
  float fontSize = 16;
  
  Button(float x, float y, float w, float h, String text) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    this.text = text;
    defaultC = new ColorCombo(color(255, 0, 0), color(255));
    hoverC = new ColorCombo(color(150, 0, 0), color(255));
    downC = new ColorCombo(color(100, 0, 0), color(255));
    bevel = 10;
  }
  
  boolean isHovered() {
    return mouseX > pos.x && mouseX < pos.x + size.x &&
    mouseY > pos.y && mouseY < pos.y + size.y;
  }
  
  boolean isPressed() {
    boolean retVar = false;
    
    ColorCombo currentColor = null;
    if (isHovered()) {
      if (mousePressed) {
        retVar = true;
        currentColor = downC;
      } else {
        currentColor = hoverC;
      }
    } else {
      currentColor = defaultC;
    }
    
    fill(currentColor.bg);
    rect(pos.x, pos.y, size.x, size.y, bevel);
    
    fill(currentColor.fg);
    textSize(fontSize);
    textAlign(CENTER);
    text(text,
      pos.x + (size.x/2),
      pos.y + (size.y/2) + (fontSize/2)
     );
    
    if (lastState == false && retVar == true) {
      lastState = retVar;
      return true;
    }
    
    lastState = retVar;
    return false;  
  }
}
