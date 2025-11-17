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
    text(text, pos.x/2 + size.x/2, pos.y/2 + size.y - fontSize);
    
    if (lastState == false && retVar == true) {
      lastState = retVar;
      return true;
    }
    
    lastState = retVar;
    return false;  
  }
}
