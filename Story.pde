ArrayList<String> storyFlags = new ArrayList<String>();
String introScenario = "1.0 Awaken";

void SwitchScenario(String _newScenario) {
  String newScenario = "";

  if (_newScenario.indexOf(":") != -1) {
    String[] splitString = split(_newScenario, ":");

    newScenario = splitString[0];
    storyFlags.add(splitString[1]);
  } else {
    newScenario = _newScenario;
  }

  for (HashMap.Entry<String, Scenario> set : scenarios.entrySet()) {
    if (set.getKey().indexOf(newScenario) != -1) {
      if (set.getKey().indexOf(":") != -1) {
        String[] splitString = split(set.getKey(), ":");
        if (storyFlags.indexOf(splitString[1]) != -1 ) {
          currentScenario = scenarios.get(newScenario + ":" + storyFlags.get(storyFlags.indexOf(splitString[1])));
          return;
        }
      } else {
        currentScenario = scenarios.get(set.getKey());
        return;
      }
    }
  }
}

HashMap<String, Scenario> GetScenarioTree() {
  // Set up Dictionary
  HashMap<String, Scenario> retScenarios = new HashMap<String, Scenario>();

  //////////////////////////////////////////////////
  //                     1.0                      //
  //////////////////////////////////////////////////
  retScenarios.put("M1.0 Awaken",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "You wake up, regretfully having to go to work.\n\nBefore you stands your dog, begging to go to work with you.",
    new Choice("Take the dog to work", "L1.1 Arrival"),
    new Choice("Go to work alone", "R1.1 Arrival")
    ));

  //////////////////////////////////////////////////
  //                     L1.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("L1.1 Arrival",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "After having brought your dog, you get stopped by the front door guard.\n\nHe tells you that you need to fill out several forms before you're allowed in with the dog.",
    new Choice("You begin filling out forms", "L1.1 ArrivalForm:FilledDogForm"),
    new Choice("\"But he's so cuuute!!\"", "L1.1 ArrivalCuteness:SkippedDogForm")
    ));

  retScenarios.put("L1.1 ArrivalForm",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "You spend an hour filling out forms, after forgetting your name several time you finally get let into the building.",
    new Choice("...", "L1.1 CoworkerInit"),
    new Choice("...", "L1.1 CoworkerInit")
    ));

  retScenarios.put("L1.1 ArrivalCuteness",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "\"Awww okay yeah, he's a real cutie pie, I'll let him in\" he said, then let you inside the building",
    new Choice("...", "L1.1 CoworkerInit"),
    new Choice("...", "L1.1 CoworkerInit")
    ));

  retScenarios.put("L1.1 CoworkerInit",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "After finally being allowed in you get to your floor where you get stopped by your coworker Karen.",
    new Choice("...", "L1.1 CoworkerLovesDoggie"),
    new Choice("...", "L1.1 CoworkerLovesDoggie")
    ));

  retScenarios.put("L1.1 CoworkerLovesDoggie",
    new Scenario("data/Mom.png", "data/bg.png", "Karen",
    "\"Your dog is so adorable, I've got a cookie for him\" She says as she extends a cookie towards your dog.",
    new Choice("You stop her and ask what's in the cookie", "L1.1 CoworkerCookieExplain"),
    new Choice("You let her feed the dog the cookie", "L1.1 CoworkerCookieDogDied")
    ));

  retScenarios.put("L1.1 CoworkerCookieExplain",
    new Scenario("data/Mom.png", "data/bg.png", "Karen",
    "\"Just some sugar, chocolate, a standard cookie\" She says before repeating her previous motion.",
    new Choice("You stop her and tell her not to", "L1.1 CoworkerCookieAvoided"),
    new Choice("You let her feed the dog the cookie", "L1.1 CoworkerCookieDogDied")
    ));

  retScenarios.put("L1.1 CoworkerCookieDogDied",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "The cookie contained chocolate, the dog explodes immedietly taking you and the building with it.",
    new Choice("AAA-", "Exit"), new Choice("FUUU-", "Exit")
    ));

  retScenarios.put("L1.1 CoworkerCookieAvoided",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "After saving your dog from the posionous chocolate you get called into your boss' office.",
    new Choice("...", "L2.1 CoffeeBossSendsToGet"),
    new Choice("...", "L2.1 CoffeeBossSendsToGet")
    ));

  //////////////////////////////////////////////////
  //                     L2.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("L2.1 CoffeeBossSendsToGet",
    new Scenario("data/Mom.png", "data/bg.png", "Boss",
    "\"I have been told you've bring your dog to work, that's against the rules...\n\n I am to report this BUT... I really need coffee and the intern's left the country so I'll let it slide if you get me a cuppa.\"",
    new Choice("\"I'll go get you coffee, but what do I do about my dog?\"", "L2.1 CoffeeBossAccept"),
    new Choice("\"Nah, you can buy your own coffee\"", "L2.1 CoffeeBossDeny")
    ));

  retScenarios.put("L2.1 CoffeeBossAccept",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "Excellent, I'll just keep the dog here... For safe keeping",
    new Choice("...", "L2.1 CoffeeShopArrival"),
    new Choice("...", "L2.1 CoffeeShopArrival")
    ));

  retScenarios.put("L2.1 CoffeeBossDeny",
    new Scenario("data/Mom.png", "data/bg.png", "Boss",
    "\"HOW DARE YOU?! I provide you a chance to avoid a write-up for a simple cup of coffee and you dare to deny me? You are fired.\" he says as security enters.",
    new Choice("Oh...", "Exit"),
    new Choice("I WILL FIGHT!!!", "L2.1 CoffeeBossFight")
    ));

  retScenarios.put("L2.1 CoffeeBossFight",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "You proceed to get your ass handed to you.",
    new Choice("...", "Exit"),
    new Choice("...", "Exit")
    ));

  retScenarios.put("L2.1 CoffeeShopArrival",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "You arrive at the coffee shop, enter and go to the counter.\n As the Barista asks you what you want to order you realise that you don't actually know what your boss would like...",
    new Choice("Order a Venti cup of Double Ristretto with Iced Vanilla Double Shot and Organic Chocolate Brownie Decaf coffee; Nonfat half-breve double blended upside-down with whipped cream and foam, extra hot Gingerbread Frappuccino, a Nutrasweet and a Sweet N'Low, finally touched with some ice.",
      "L2.2 ReturnToOffice:SweetCoffee"),
    new Choice("Order a black coffee, dark like his soul.", "L2.2 ReturnToOffice:DarkCoffee")
    ));

  //////////////////////////////////////////////////
  //                     L2.2                     //
  //////////////////////////////////////////////////
  retScenarios.put("L2.2 ReturnToOffice",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "MESSAGE",
    new Choice("ANSWER1", "Exit"),
    new Choice("ANSWER2", "Exit")
    ));

  //////////////////////////////////////////////////
  //                     R1.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("R1.1 Arrival",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "THIS IS YET TO BE IMPLEMENTED.",
    new Choice("I WANT MY MONEY BACK!", "R1.1 Moneyyy"),
    new Choice("Fineee, I'll wait", "Exit")
    ));

  retScenarios.put("R1.1 Moneyyy",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "You paid money for this?! GO GET IT BACK! THIS IS FREE!!!",
    new Choice("FUCK, I really should stop buying games on the black market :/", "Exit"),
    new Choice("Roger Roger Comrade", "Exit")
    ));

  retScenarios.put("TITLE",
    new Scenario("data/Mom.png", "data/bg.png", "Narrator",
    "MESSAGE",
    new Choice("ANSWER1", "Exit"),
    new Choice("ANSWER2", "Exit")
    ));

  // Return our Dict
  return retScenarios;
}
