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
    new Scenario("data/Mom.png", "Narrator",
    "You wake up, regretfully having to go to work.\n\nBefore you stands your dog, big cute eyes looking up, begging to go to work with you.",
    new Choice("Take the dog to work", "L1.1 Arrival"),
    new Choice("Go to work alone", "R1.1 Arrival")
    ));

  //////////////////////////////////////////////////
  //                     L1.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("L1.1 Arrival",
    new Scenario("data/doorguard.png", "Narrator",
    "You and your dog drive together to work, and you park outside. You enter the building and immediately get stopped by the front door guard.\nHe tells you that you need to fill out several forms before you're allowed in with the dog.",
    new Choice("Following protocol is important. You begin painstakingly filling out the tedious forms one by one", "L1.1 ArrivalForm:FilledDogForm"),
    new Choice("\"But he's so cuuute!! Can't you just let him in? He won't cause any trouble, I promise\"", "L1.1 ArrivalCuteness:SkippedDogForm")
    ));

  retScenarios.put("L1.1 ArrivalForm",
    new Scenario("data/dogform.png", "Narrator",
    "You spend an hour filling out forms, and after forgetting your name several times you are finally let into the building. The guard gives you a smile as you go and bids you a good day.",
    new Choice("...", "L1.1 CoworkerInit"),
    new Choice("...", "L1.1 CoworkerInit")
    ));

  retScenarios.put("L1.1 ArrivalCuteness",
    new Scenario("data/Mom.png", "Narrator",
    "\"Well... It's against the rules... But...\" He looks down at your dog for a few minutes, and seems to lose an internal battle against his professionalism. \n\"Awww okay yeah, he's a real cutie pie, I'll let him in,\" he says, and then lets you inside the building.",
    new Choice("...", "L1.1 CoworkerInit"),
    new Choice("...", "L1.1 CoworkerInit")
    ));

  retScenarios.put("L1.1 CoworkerInit",
    new Scenario("data/karen.png", "Narrator",
    "After finally being allowed in you get to your floor and step into your office, where you are stopped by your coworker Karen. She seems to be holding something.",
    new Choice("...", "L1.1 CoworkerLovesDoggie"),
    new Choice("...", "L1.1 CoworkerLovesDoggie")
    ));

  retScenarios.put("L1.1 CoworkerLovesDoggie",
    new Scenario("data/karen.png", "Karen",
    "\"Your dog is so adorable! I've got a cookie for him,\" she says as she crouches down and extends a cookie towards your dog.",
    new Choice("You stop her and ask what's in the cookie", "L1.1 CoworkerCookieExplain"),
    new Choice("You let her feed the dog the cookie", "L1.1 CoworkerCookieDogDied")
    ));

  retScenarios.put("L1.1 CoworkerCookieExplain",
    new Scenario("data/karen.png", "Karen",
    "\"What? Oh, just some sugar, chocolate, butter, you know, your standard cookie.\" She says before repeating her previous motion.",
    new Choice("You stop her and tell her not to feed it to the dog", "L1.1 CoworkerCookieAvoided"),
    new Choice("You let her feed the dog the cookie", "L1.1 CoworkerCookieDogDied")
    ));

  retScenarios.put("L1.1 CoworkerCookieDogDied",
    new Scenario("data/dog_explosion.png", "Narrator",
    "The cookie contains chocolate. The dog explodes, immediatly taking you and the building with it.\n What were you expecting, honestly? You can't go giving dogs chocolate, it's a public hazard, everyone knows that.",
    new Choice("AAA-", "Exit"), new Choice("FUUU-", "Exit")
    ));

  retScenarios.put("L1.1 CoworkerCookieAvoided",
    new Scenario("data/cookie.png", "Narrator",
    "You snatch the cookie from her hand and shove it in your mouth, complimenting it's delicious taste before you're done chewing. Karen stares at you with her mouth open in shock, and with an expression containing a faint hint of disgust. \n Phew, disaster avoided and successfully having saved your dog from the posionous chocolate you get called into your boss' office.",
    new Choice("...", "L2.1 CoffeeBossSendsToGet"),
    new Choice("...", "L2.1 CoffeeBossSendsToGet")
    ));

  //////////////////////////////////////////////////
  //                     L2.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("L2.1 CoffeeBossSendsToGet",
    new Scenario("data/bossman.png", "Boss",
    "\"I have been told you've brought your dog to work today, that's against the rules...\n\n I am to report this BUT... I really need coffee and the intern's left the country so I'll let it slide if you get me a cuppa.\"",
    new Choice("\"I'll go get you a coffee sir, but what do I do about my dog?\"", "L2.1 CoffeeBossAccept"),
    new Choice("\"Nah, you can buy your own coffee, why should I do it? You know I feel like it even goes against some workplace rights, I could take you to court, and I'd easily win. I mean can't you see how wrong this is? Asking your subordinate to grab you a cuppa, what am I, a slave to your every need and desires?\"", "L2.1 CoffeeBossDeny")
    ));

  retScenarios.put("L2.1 CoffeeBossAccept",
    new Scenario("data/bossman.png", "Boss",
    "Excellent then, I'll just keep the dog here... For safe keeping.",
    new Choice("...", "L2.1 CoffeeShopArrival"),
    new Choice("...", "L2.1 CoffeeShopArrival")
    ));

  retScenarios.put("L2.1 CoffeeBossDeny",
    new Scenario("data/bossman.png", "Boss",
    "\"HOW DARE YOU?! I provide you a chance to avoid a write-up for a simple cup of coffee and you dare to deny me? You are fired,\" he says as security enters.",
    new Choice("Oh...", "Exit"),
    new Choice("I WILL FIGHT!!! VIVE LA RÉVOLUTION!!!", "L2.1 CoffeeBossFight")
    ));

  retScenarios.put("L2.1 CoffeeBossFight",
    new Scenario("data/bossman.png", "Boss",
    "You try to fight your boss who fired you for refusing to get him coffee and vault over his desk to attack.\nUnfortunately, you proceed to get your ass handed to you.",
    new Choice("...", "Exit"),
    new Choice("...", "Exit")
    ));

  retScenarios.put("L2.1 CoffeeShopArrival",
    new Scenario("data/Mom.png", "Narrator",
    "You arrive at the coffee shop, enter and go to the counter.\n As the Barista asks you what you want to order you realise that you don't actually know what your boss would like...",
    new Choice("Order a Venti cup of Double Ristretto with Iced Vanilla Double Shot and Organic Chocolate Brownie Decaf coffee; Nonfat half-breve double blended upside-down with whipped cream and foam, extra hot Gingerbread Frappuccino, a Nutrasweet and a Sweet N'Low, finally touched with some ice",
    "L2.2 ReturnToOffice:SweetCoffee"),
    new Choice("Order a black coffee, dark like his soul", "L2.2 ReturnToOffice:DarkCoffee")
    ));

  //////////////////////////////////////////////////
  //                     L2.2                     //
  //////////////////////////////////////////////////
  retScenarios.put("L2.2 ReturnToOffice",
    new Scenario("data/Mom.png", "Narrator",
    "Upon returning to the building with drink in hand, you find that the entance floor is packed with people. How do you get want to get to the top floor?",
    new Choice("You don't feel like walking any more, and brave the elevator", "L2.2 BraveElevator"),
    new Choice("You take that stairs", "L2.2 TakeStairs")
    ));

  retScenarios.put("L2.2 BraveElevator",
    new Scenario("data/Mom.png", "Narrator",
    "You have to try to press the button, but there are many people.\n you don't know where you went.",
    new Choice("...", "L2.3 BossReturn"),
    new Choice("...", "L2.3 BossReturn")
    ));

  retScenarios.put("L2.2 TakeStairs",
    new Scenario("data/Mom.png", "Narrator",
    "Those aren't yours!",
    new Choice("I own this building!", "L2.2 StairsOwn"),
    new Choice("That makes no sense...", "L2.2 StairsNoSense")
    ));

  retScenarios.put("L2.2 StairsOwn",
    new Scenario("data/Mom.png", "Narrator",
    "[new Scenario ☐☐☐☐ started] Spoilers! Also not yet! But fine... Take them!",
    new Choice("...", "L2.2 StairsEnd"),
    new Choice("...", "L2.2 StairsEnd")
    ));

  retScenarios.put("L2.2 StairsEnd",
    new Scenario("data/Mom.png", "Narrator",
    "You stop staring at a blank wall, you take the elevator",
    new Choice("...", "L2.3 BossReturn"),
    new Choice("...", "L2.3 BossReturn")
    ));

  //////////////////////////////////////////////////
  //                     L2.3                     //
  //////////////////////////////////////////////////

  retScenarios.put("L2.3 BossReturn:DarkCoffee",
    new Scenario("data/Mom.png", "Narrator",
    "After getting through that whole ordeal and little misadventure, you end up on the correct floor where you meet your boss.\nHe takes the coffee and says \"You should go see the new boss, apparently just got hired\".",
    new Choice("...", "L2.3 GoToNewBoss"),
    new Choice("...", "L2.3 GoToNewBoss")
    ));

  retScenarios.put("L2.3 GoToNewBoss",
    new Scenario("data/Mom.png", "Narrator",
    "You go to the top floor and enter a grand hall, it's empty except for a desk at the end with a chair turned away from you.\nWhen you get closer the chair slowly turns around and you see...",
    new Choice("...", "Exit"),
    new Choice("...", "Exit")
    ));


  retScenarios.put("L2.3 BossReturn:SweetCoffee",
    new Scenario("data/Mom.png", "Narrator",
    "You somehow ended up on the top floor, a generic looking office, where a man approaches you.\n\"Hey I need a coffee, gimme that!\"",
    new Choice("But I need to give it to my boss!", "L2.3 CEOResist"),
    new Choice("Fine, here you go", "Exit")
    ));

  retScenarios.put("L2.3 CEOResist",
    new Scenario("data/Mom.png", "CEO",
    "\"How dare you?! I own this building!\" He says as he grabs the drink out of your hand.",
    new Choice("Oh, I am sorry...", "L2.3 CEOQuit"),
    new Choice("\"Prick...\" You mutter under your breath", "L2.3 CEOQuit")
    ));

  retScenarios.put("L2.3 CEOAllow",
    new Scenario("data/Mom.png", "CEO",
    "\"Thank you!\n He says as he grabs it and turns it up, taking a big gulp of the liquid.",
    new Choice("TODO", "L2.3 CEOQuit"),
    new Choice("TODO", "L2.3 CEOQuit")
    ));

  retScenarios.put("L2.3 CEOQuit",
    new Scenario("data/Mom.png", "CEO",
    "\"I... have never tasted anything so exquisite!\nI quit! I don't care anymore! Whoever first sits on the chair in the main hall immediately becomes the acting CEO, starting now.\"",
    new Choice("I'll go to the main hall then", "L2.3 NewCEO"),
    new Choice("Ooo, let's see who becomes the CEO!", "L2.3 NewCEO")
    ));

  retScenarios.put("L2.3 NewCEO",
    new Scenario("data/Mom.png", "Narrator",
    "As you arrive in the main hall you find a great room empty except for a desk at the end with a chair, before you can get closer to it you hear a woof from behind you as your dog charges forward and sits in the new chair.",
    new Choice("TODO", "Exit"),
    new Choice("TODO", "Exit")
    ));

  //////////////////////////////////////////////////
  //                     R1.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("R1.1 Arrival",
    new Scenario("data/Mom.png", "Narrator",
    "THIS IS YET TO BE IMPLEMENTED.",
    new Choice("I WANT MY MONEY BACK!", "R1.1 Moneyyy"),
    new Choice("Fineee, I'll wait", "Exit")
    ));

  retScenarios.put("R1.1 Moneyyy",
    new Scenario("data/Mom.png", "Narrator",
    "You paid money for this?! GO GET IT BACK! THIS IS FREE!!!",
    new Choice("FUCK, I really should stop buying games on the black market :/", "Exit"),
    new Choice("Roger Roger Comrade", "Exit")
    ));

  retScenarios.put("TITLE",
    new Scenario("data/Mom.png", "Narrator",
    "MESSAGE",
    new Choice("ANSWER1", "Exit"),
    new Choice("ANSWER2", "Exit")
    ));

  // Return our Dict
  return retScenarios;
}
