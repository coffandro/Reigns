enum MouseState {
  NONE,
    HOVERED,
    CLICKED
}

class Button {
  PVector pos;
  PVector size;
  String text = "";
  float borderRadius = 25;

  MouseState mouseState = MouseState.NONE;

  color col = color(255);
  color hovCol = color(150);
  
  Button(float _posX, float _posY, float _sizeX, float _sizeY) {
    pos = new PVector(_posX, _posY);
    size = new PVector(_sizeX, _sizeY);
  }

  Button(float _posX, float _posY, float _sizeX, float _sizeY, String _text) {
    pos = new PVector(_posX, _posY);
    size = new PVector(_sizeX, _sizeY);
    text = _text;
  }

  MouseState GetMouseState() {
    if (isHovered(pos, size)) {
      if (mousePressed) {
        return MouseState.CLICKED;
      }

      return MouseState.HOVERED;
    }

    return MouseState.NONE;
  }
  
  boolean IsClicked() {
    return mouseState == MouseState.CLICKED;
  }

  void update() {
    mouseState = GetMouseState();
  }

  void display() {
    if (mouseState == MouseState.HOVERED) {
      fill(hovCol);
    } else {
      fill(col);
    }

    rectMode(CORNER);
    rect(pos.x, pos.y, size.x, size.y, borderRadius);
    
    textAlign(CENTER);
    fill(0);
    text(text, pos.x, pos.y, size.x, size.y);
  }
}
