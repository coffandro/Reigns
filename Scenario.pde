class Choice {
  String label;
  String next;
  float karmaMod;

  Choice(String _label, String _next) {
    label = _label;
    next = _next;
    karmaMod = 0;
  }

  Choice(String _label, String _next, float _karmaMod) {
    label = _label;
    next = _next;
    karmaMod = _karmaMod;
  }

  void execute() {
    if (next == "Exit") {
      exit();
      return;
    } else {
      SwitchScenario(next);
    }

    UpdateKarma(karmaMod);
  }
}

class Scenario {
  PImage img;
  String message;
  PVector pos, size;
  boolean dragging = false;
  Choice leftChoice, rightChoice;

  Scenario(String imgPath, String message, Choice leftChoice, Choice rightChoice) {
    img = loadImage(imgPath);
    this.message = message;

    pos = new PVector(width/2, height/2);
    size = new PVector(width/2, width/2);

    this.leftChoice = leftChoice;
    this.rightChoice = rightChoice;
  }

  void drawTexts() {
    pushMatrix();
    translate(width/2, 0);

    fill(0);

    rectMode(LEFT);
    textFont(regularFont);
    textSize(24);
    text(message, -width/4 + 50, 50, width/4 - 50, height/4 + height/6);

    rectMode(CORNER);
    fill(255);
    textSize(32);

    rectMode(CENTER);

    popMatrix();
  }

  void display() {
    rectMode(CENTER);
    rect(width/2, height/2, width/2, height, 25);
    
    image(img, pos.x, pos.y, size.x, size.y);
    
    drawTexts();
  }
}

ArrayList<String> storyFlags = new ArrayList<String>();

boolean IsChoiceValid(Choice choice, String[] keys) {
  for(int i = 0; i < keys.length; i++) {
    if (choice.next == keys[i]) {
      return true;
    }
  }
  
  return false;
}

void AnalyseScenarios(HashMap<String, Scenario> scenarios) {
  String[] keys = new String[scenarios.size()];
  
  int i = 0;
  for (String k : scenarios.keySet()) {
    keys[i] = k;
    i++;
  }
  
  boolean has_error = false;
  ArrayList<String> invalid_choices = new ArrayList<String>();
  for (Map.Entry<String, Scenario> entry : scenarios.entrySet()) {
    Scenario scenario = entry.getValue();
    
    if (!IsChoiceValid(scenario.leftChoice, keys)) {
      has_error = true;
      invalid_choices.add("Invalid leftChoice at " + entry.getKey());
    }
    
    if (!IsChoiceValid(scenario.rightChoice, keys)) {
      has_error = true;
      invalid_choices.add("Invalid rightChoice at " + entry.getKey());
    }
  }
  
  if (has_error) {
    for(i = 0; i < invalid_choices.size(); i++) {
      println(invalid_choices.get(i));
    }
  }
}

void SwitchScenario(String _newScenario) {

  String newScenario = _newScenario;
  String requiredFlag = null;

  // Split incoming scenario if it contains a flag
  if (_newScenario.contains(":")) {
    String[] splitString = split(_newScenario, ":");
    newScenario = splitString[0];
    requiredFlag = splitString[1];

    if (!storyFlags.contains(requiredFlag)) {
      storyFlags.add(requiredFlag);
    }
  }

  // Try exact flagged match
  for (String key : scenarios.keySet()) {
    if (key.contains(":")) {
      String[] splitKey = split(key, ":");
      String base = splitKey[0];
      String flag = splitKey[1];

      if (base.equals(newScenario) && storyFlags.contains(flag)) {
        currentScenario = scenarios.get(key);
        UpdateChoices();
        return;
      }
    }
  }

  // Fall back to exact base match
  if (scenarios.containsKey(newScenario)) {
    currentScenario = scenarios.get(newScenario);
    UpdateChoices();
  }
}

void UpdateChoices() {
  leftButton.text = currentScenario.leftChoice.label;
  rightButton.text = currentScenario.rightChoice.label;
}
