void UpdateKarma(float karmaMod) {
  karma += karmaMod;
  circle.setKarma(karma);
}

class KarmaCircle {
  PVector pos;

  float karma;
  float targetSize;
  float currentSize;
  float speed = 0.05;
  float maxSize = 200;
  
  boolean initialized = false;

  KarmaCircle(float _posx, float _posy, float _karma) {
    pos = new PVector(_posx, _posy);

    setKarma(_karma);
    currentSize = targetSize;
  }

  void setKarma(float _karma) {
    if (karma == _karma) {
      return;
    }
    
    karma = _karma;
    targetSize = (karma / 100) * maxSize;
  }

  float getKarma() {
    return targetSize;
  }

  void update() {
    float diff = abs(currentSize - targetSize);
    
    if (diff == 0) {
      return;
    }
    
    currentSize = lerp(currentSize, targetSize, speed);
  }

  void display() {
    ellipse(pos.x, pos.y, currentSize, currentSize);
  }
}
