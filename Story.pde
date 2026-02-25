ArrayList<String> storyFlags = new ArrayList<String>();
String introScenario = "M1.0 Awaken";

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

HashMap<String, Scenario> GetScenarioTree() {
  // Set up Dictionary
  HashMap<String, Scenario> retScenarios = new HashMap<String, Scenario>();

  //////////////////////////////////////////////////
  //                     1.0                      //
  //////////////////////////////////////////////////
  retScenarios.put("M1.0 Awaken",
    new Scenario("data/Mom.png",
    "You wake up, regretfully having to go to work.\n\nBefore you stands your dog, begging to go to work with you.",
    new Choice("Take the dog to work", "L1.1 Arrival", 15),
    new Choice("Go to work alone", "R1.1 Arrival", -15)
    ));

  //////////////////////////////////////////////////
  //                     L1.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("L1.1 Arrival",
    new Scenario("data/doorguard.png",
    "After having brought your dog, you get stopped by the front door guard.\n\nHe tells you that you need to fill out several forms before you're allowed in with the dog.",
    new Choice("You begin filling out forms", "L1.1 ArrivalForm:FilledDogForm", 0),
    new Choice("\"But he's so cuuute!!\"", "L1.1 ArrivalCuteness:SkippedDogForm", -15)
    ));

  retScenarios.put("L1.1 ArrivalForm",
    new Scenario("data/dogform.png",
    "You spend an hour filling out forms, after forgetting your name several time you finally get let into the building.",
    new Choice("...", "L1.1 CoworkerInit", 0),
    new Choice("...", "L1.1 CoworkerInit", 0)
    ));

  retScenarios.put("L1.1 ArrivalCuteness",
    new Scenario("data/Mom.png",
    "\"Awww okay yeah, he's a real cutie pie, I'll let him in\" he said, then let you inside the building",
    new Choice("...", "L1.1 CoworkerInit", 0),
    new Choice("...", "L1.1 CoworkerInit", 0)
    ));

  retScenarios.put("L1.1 CoworkerInit",
    new Scenario("data/karen.png",
    "After finally being allowed in you get to your floor where you get stopped by your coworker Karen.",
    new Choice("...", "L1.1 CoworkerLovesDoggie", 0),
    new Choice("...", "L1.1 CoworkerLovesDoggie", 0)
    ));

  retScenarios.put("L1.1 CoworkerLovesDoggie",
    new Scenario("data/karen.png",
    "\"Your dog is so adorable, I've got a cookie for him\" She says as she extends a cookie towards your dog.",
    new Choice("You stop her and ask what's in the cookie", "L1.1 CoworkerCookieExplain", 0),
    new Choice("You let her feed the dog the cookie", "L1.1 CoworkerCookieDogDied", 0)
    ));

  retScenarios.put("L1.1 CoworkerCookieExplain",
    new Scenario("data/karen.png",
    "\"Just some sugar, chocolate, a standard cookie\" She says before repeating her previous motion.",
    new Choice("You stop her and tell her not to", "L1.1 CoworkerCookieAvoided", 0),
    new Choice("You let her feed the dog the cookie", "L1.1 CoworkerCookieDogDied", 0)
    ));

  retScenarios.put("L1.1 CoworkerCookieDogDied",
    new Scenario("data/dog_explosion.png",
    "The cookie contained chocolate, the dog explodes immedietly taking you and the building with it.",
    new Choice("AAA-", "Exit", 0), new Choice("FUUU-", "Exit", 0)
    ));

  retScenarios.put("L1.1 CoworkerCookieAvoided",
    new Scenario("data/cookie.png",
    "After saving your dog from the posionous chocolate you get called into your boss' office.",
    new Choice("...", "L2.1 CoffeeBossSendsToGet", 0),
    new Choice("...", "L2.1 CoffeeBossSendsToGet", 0)
    ));

  //////////////////////////////////////////////////
  //                     L2.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("L2.1 CoffeeBossSendsToGet",
    new Scenario("data/bossman.png",
    "\"I have been told you've bring your dog to work, that's against the rules...\n\n I am to report this BUT... I really need coffee and the intern's left the country so I'll let it slide if you get me a cuppa.\"",
    new Choice("\"I'll go get you coffee, but what do I do about my dog?\"", "L2.1 CoffeeBossAccept", 0),
    new Choice("\"Nah, you can buy your own coffee\"", "L2.1 CoffeeBossDeny", 0)
    ));

  retScenarios.put("L2.1 CoffeeBossAccept",
    new Scenario("data/bossman.png",
    "Excellent, I'll just keep the dog here... For safe keeping",
    new Choice("...", "L2.1 CoffeeShopArrival", 0),
    new Choice("...", "L2.1 CoffeeShopArrival", 0)
    ));

  retScenarios.put("L2.1 CoffeeBossDeny",
    new Scenario("data/bossman.png",
    "\"HOW DARE YOU?! I provide you a chance to avoid a write-up for a simple cup of coffee and you dare to deny me? You are fired.\" he says as security enters.",
    new Choice("Oh...", "Exit", 0),
    new Choice("I WILL FIGHT!!!", "L2.1 CoffeeBossFight", 0)
    ));

  retScenarios.put("L2.1 CoffeeBossFight",
    new Scenario("data/bossman.png",
    "You proceed to get your ass handed to you.",
    new Choice("...", "Exit", 0),
    new Choice("...", "Exit", 0)
    ));

  retScenarios.put("L2.1 CoffeeShopArrival",
    new Scenario("data/Mom.png",
    "You arrive at the coffee shop, enter and go to the counter.\n As the Barista asks you what you want to order you realise that you don't actually know what your boss would like...",
    new Choice("Order a Venti cup of Double Ristretto with Iced Vanilla Double Shot and Organic Chocolate Brownie Decaf coffee; Nonfat half-breve double blended upside-down with whipped cream and foam, extra hot Gingerbread Frappuccino, a Nutrasweet and a Sweet N'Low, finally touched with some ice.",
    "L2.2 ReturnToOffice:SweetCoffee", 0),
    new Choice("Order a black coffee, dark like his soul.", "L2.2 ReturnToOffice:DarkCoffee", 0)
    ));

  //////////////////////////////////////////////////
  //                     L2.2                     //
  //////////////////////////////////////////////////
  retScenarios.put("L2.2 ReturnToOffice",
    new Scenario("data/Mom.png",
    "Upon returning to the office you find that the bottom floor of the building is packed with people, how do you get to the top floor?",
    new Choice("You brave the elevator", "L2.2 BraveElevator", 0),
    new Choice("You take that stairs", "L2.2 TakeStairs", 0)
    ));

  retScenarios.put("L2.2 BraveElevator",
    new Scenario("data/Mom.png",
    "You have to try to press the button, but there are many people.\n you don't know where you went.",
    new Choice("...", "L2.3 BossReturn", 0),
    new Choice("...", "L2.3 BossReturn", 0)
    ));

  retScenarios.put("L2.2 TakeStairs",
    new Scenario("data/Mom.png",
    "Those aren't yours!",
    new Choice("I own this building!", "L2.2 StairsOwn", 0),
    new Choice("That makes no sense...", "L2.2 StairsNoSense", 0)
    ));

  retScenarios.put("L2.2 StairsOwn",
    new Scenario("data/Mom.png",
    "Spoilers! Also not yet! but fine... Take them!",
    new Choice("...", "L2.2 StairsEnd", 0),
    new Choice("...", "L2.2 StairsEnd", 0)
    ));

  retScenarios.put("L2.2 StairsEnd",
    new Scenario("data/Mom.png",
    "You stop staring at a blank wall, you take the elevator",
    new Choice("...", "L2.3 BossReturn", 0),
    new Choice("...", "L2.3 BossReturn", 0)
    ));

  //////////////////////////////////////////////////
  //                     L2.3                     //
  //////////////////////////////////////////////////

  retScenarios.put("L2.3 BossReturn:DarkCoffee",
    new Scenario("data/Mom.png",
    "You end up on the correct floor where you meet your boss.\nHe takes the coffee and says \"You should go see the new boss, apparently just got hired\"",
    new Choice("...", "L2.3 GoToNewBoss", 0),
    new Choice("...", "L2.3 GoToNewBoss", 0)
    ));

  retScenarios.put("L2.3 GoToNewBoss",
    new Scenario("data/Mom.png",
    "You go to the top floor and enter a grand hall, it's empty except for a desk at the end with a chair turned away from you.\nWhen you get closer the chair slowly turns and you see...",
    new Choice("...", "Exit", 0),
    new Choice("...", "Exit", 0)
    ));


  retScenarios.put("L2.3 BossReturn:SweetCoffee",
    new Scenario("data/Mom.png",
    "You somehow ended up on the top floor, a generic looking office, where a man approaches you.\n\"Hey I need a coffee, gimme that!\"",
    new Choice("But I need to give it to my boss!", "L2.3 CEOResist", 0),
    new Choice("Fine, here you go", "Exit", 0)
    ));

  retScenarios.put("L2.3 CEOResist",
    new Scenario("data/Mom.png",
    "\"How dare you?!, I own this building!\" He says as he grabs the drink out of your hand.",
    new Choice("Oh I am sorry...", "L2.3 CEOQuit", 0),
    new Choice("\"Prick...\" You mutter under your breath", "L2.3 CEOQuit", 0)
    ));

  retScenarios.put("L2.3 CEOAllow",
    new Scenario("data/Mom.png",
    "\"Thank you!\n He says as he grabs it and drinks.",
    new Choice("TODO", "L2.3 CEOQuit", 0),
    new Choice("TODO", "L2.3 CEOQuit", 0)
    ));

  retScenarios.put("L2.3 CEOQuit",
    new Scenario("data/Mom.png",
    "\"I... have never tasted anything to exqusite\nI quit! I don't care anymore! Whoever sits on the chair in the main hall becomes CEO\"",
    new Choice("I'll go to the main hall then", "L2.3 NewCEO", 0),
    new Choice("Ooo, let's see who becomes the CEO!", "L2.3 NewCEO", 0)
    ));

  retScenarios.put("L2.3 NewCEO",
    new Scenario("data/Mom.png",
    "As you arrive in the main hall you find a great room empty except for a desk at the end with a chair, before you can get closer to it you hear a woof from behind you as your dog charges to and sits in the new chair",
    new Choice("TODO", "Exit", 0),
    new Choice("TODO", "Exit", 0)
    ));

  //////////////////////////////////////////////////
  //                     R1.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("R1.1 Arrival",
    new Scenario("data/Mom.png",
    "THIS IS YET TO BE IMPLEMENTED.",
    new Choice("I WANT MY MONEY BACK!", "R1.1 Moneyyy", 0),
    new Choice("Fineee, I'll wait", "Exit", 0)
    ));

  retScenarios.put("R1.1 Moneyyy",
    new Scenario("data/Mom.png",
    "You paid money for this?! GO GET IT BACK! THIS IS FREE!!!",
    new Choice("FUCK, I really should stop buying games on the black market :/", "Exit", 0),
    new Choice("Roger Roger Comrade", "Exit", 0)
    ));

  retScenarios.put("TITLE",
    new Scenario("data/Mom.png",
    "MESSAGE",
    new Choice("ANSWER1", "Exit", 0),
    new Choice("ANSWER2", "Exit", 0)
    ));

  // Return our Dict
  return retScenarios;
}
