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
  float lastPress = 0;
  float debounce = 100;
  boolean prev_pressed = false;

  MouseState mouseState = MouseState.NONE;

  color col = color(255);
  color hovCol = color(150);
  color downCol = color(100);

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
        if (!prev_pressed) {
          prev_pressed = true;
          return MouseState.CLICKED;
        }
      } else {
        if (prev_pressed) {
          prev_pressed = false;
        }
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
    } else if (mouseState == MouseState.CLICKED) {
      fill(downCol);
    } else {
      fill(col);
    }

    rectMode(CORNER);
    rect(pos.x, pos.y, size.x, size.y, borderRadius);

    textAlign(CENTER);
    fill(0);
    text(text, pos.x + 10, pos.y + 50, size.x - 10 * 2, height);
  }
}
