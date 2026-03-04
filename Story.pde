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
    "You wake up, regretfully having to go to work.\n\nBefore you stands your dog, big cute eyes looking up, begging to go to work with you.",
    new Choice("Take the dog to work", "L1.1 Arrival"), -15
    new Choice("Go to work alone", "M1.1 Awaken")
    ));

retScenarios.put("M1.1 Awaken",
    new Scenario("data/Mom.png",
    "You open the door to leave but before it shuts your dog sneaks out with you, and unnoticed climbs into your car. Only half way do you discover your extra passenger and by then it's too late to turn back.",
    new Choice("You've been a bad dog, no treats for you when we get home", "L1.1 Arrival"), -5
    new Choice("Alright, just this once", "L1.1 Arrival"), 10
    ));

  //////////////////////////////////////////////////
  //                     L1.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("L1.1 Arrival",
    new Scenario("data/doorguard.png",
    "You and your dog drive together to work, and you park outside. You enter the building and immediately get stopped by the front door guard.\nHe tells you that you need to fill out several forms before you're allowed in with the dog.",
    new Choice("Following protocol is important. You begin painstakingly filling out the tedious forms one by one", "L1.1 ArrivalForm:FilledDogForm"), 20
    new Choice("\"But he's so cuuute!! Can't you just let him in? He won't cause any trouble, I promise\"", "L1.1 ArrivalCuteness:SkippedDogForm"), -15
    ));

  retScenarios.put("L1.1 ArrivalForm",
    new Scenario("data/dogform.png",
    "You spend an hour filling out forms, and after forgetting your name several times you are finally let into the building. The guard gives you a smile as you go and bids you a good day.",
    new Choice("You too!", "L1.1 CoworkerInit"), 5
    new Choice("...", "L1.1 CoworkerInit"), -5
    ));

  retScenarios.put("L1.1 ArrivalCuteness",
    new Scenario("data/Mom.png",
    "\"Well... It's against the rules... But...\" He looks down at your dog for a few minutes, and seems to lose an internal battle against his professionalism. \n\"Awww okay yeah, he's a real cutie pie, I'll let him in,\" he says, and then lets you inside the building.",
    new Choice("...", "L1.1 CoworkerInit"), -10
    new Choice("...", "L1.1 CoworkerInit"), -10
    ));

  retScenarios.put("L1.1 CoworkerInit",
    new Scenario("data/karen.png",
    "After finally being allowed in you get to your floor and step into your office, where you are stopped by your coworker Karen. She seems to be holding something.",
    new Choice("Ugh not this bitch Karen", "L1.1 CoworkerLovesDoggie"), -5
    new Choice("What's that?", "L1.1 CoworkerLovesDoggie")
    ));

  retScenarios.put("L1.1 CoworkerLovesDoggie",
    new Scenario("data/karen.png",
    "\"Your dog is so adorable! I've got a cookie for him,\" she says as she crouches down and extends a cookie towards your dog.",
    new Choice("You stop her and ask what's in the cookie", "L1.1 CoworkerCookieExplain"), 5
    new Choice("You let her feed the dog the cookie", "L1.1 CoworkerCookieDogDied"), -10
    ));

  retScenarios.put("L1.1 CoworkerCookieExplain",
    new Scenario("data/karen.png",
    "\"What? Oh, just some sugar, chocolate, butter, you know, your standard cookie.\" She says before repeating her previous motion.",
    new Choice("You stop her and tell her not to feed it to the dog", "L1.1 CoworkerCookieAvoided"), 5
    new Choice("You let her feed the dog the cookie", "L1.1 CoworkerCookieDogDied"), -15
    ));

  retScenarios.put("L1.1 CoworkerCookieDogDied",
    new Scenario("data/dog_explosion.png",
    "The cookie contains chocolate. The dog explodes, immediatly taking you and the building with it.\n What were you expecting, honestly? \nYou can't go giving dogs chocolate, it's a public hazard, everyone knows that.",
    new Choice("AAA-", "Exit"),
    new Choice("FUUU-", "Exit")
    ));

  retScenarios.put("L1.1 CoworkerCookieAvoided",
    new Scenario("data/cookie.png",
    "You snatch the cookie from her hand and shove it in your mouth, complimenting it's delicious taste before you're done chewing. Karen stares at you with her mouth open in shock, and with an expression containing a faint hint of disgust. \n Phew, disaster avoided and successfully having saved your dog from the posionous chocolate you get called into your boss' office.",
    new Choice("...", "L2.1 CoffeeBossSendsToGet"),
    new Choice("...", "L2.1 CoffeeBossSendsToGet")
    ));

  //////////////////////////////////////////////////
  //                     L2.1                     //
  //////////////////////////////////////////////////
  retScenarios.put("L2.1 CoffeeBossSendsToGet",
    new Scenario("data/bossman.png",
    "\"I have been told you've brought your dog to work today, that's against the rules...\n\n I am to report this BUT... I really need coffee and the intern's left the country so I'll let it slide if you get me a cuppa.\"",
    new Choice("\"I'll go get you a coffee sir, but what do I do about my dog?\"", "L2.1 CoffeeBossAccept"), 10
    new Choice("\"Nah, you can buy your own coffee, why should I do it? You know I feel like it even goes against some workplace rights, I could take you to court, and I'd easily win. I mean can't you see how wrong this is? Asking your subordinate to grab you a cuppa, what am I, a slave to your every need and desires?\"", "L2.1 CoffeeBossDeny")
    ));

  retScenarios.put("L2.1 CoffeeBossAccept",
    new Scenario("data/bossman.png",
    "\"Excellent then, I'll just keep the dog here... For safe keeping.\"",
    new Choice("...", "L2.1 CoffeeShopArrival"),
    new Choice("...", "L2.1 CoffeeShopArrival")
    ));

  retScenarios.put("L2.1 CoffeeBossDeny",
    new Scenario("data/bossman.png",
    "\"HOW DARE YOU?! I provide you a chance to avoid a write-up for a simple cup of coffee and you dare to deny me? You are fired,\" he says as security enters.",
    new Choice("Oh...", "Exit"),
    new Choice("I WILL FIGHT!!! VIVE LA RÉVOLUTION!!!", "L2.1 CoffeeBossFight")
    ));

  retScenarios.put("L2.1 CoffeeBossFight",
    new Scenario("data/asshand.png",
    "You try to fight your boss who fired you for refusing to get him coffee and vault over his desk to attack.\nUnfortunately, you proceed to get your ass handed to you.",
    new Choice("...", "Exit"),
    new Choice("...", "Exit")
    ));

  retScenarios.put("L2.1 CoffeeShopArrival",
    new Scenario("data/Mom.png",
    "You arrive at the coffee shop, enter and go to the counter.\n As the Barista asks you what you want to order you realise that you don't actually know what your boss would like...",
    new Choice("Order a Venti cup of Double Ristretto with Iced Vanilla Double Shot and Organic Chocolate Brownie Decaf coffee; Nonfat half-breve double blended upside-down with whipped cream and foam, extra hot Gingerbread Frappuccino, a Nutrasweet and a Sweet N'Low, finally touched with some ice",
    "L2.2 ReturnToOffice:SweetCoffee"),
    new Choice("Order a black coffee, dark like his soul", "L2.1 SusCoffee")
    ));

retScenarios.put("L2.1 SusCoffee",
    new Scenario("data/Mom.png",
    "You get the coffee, but you notice there seems to be something slightly sinister about it... \n Oh well, it's probably nothing.",
    new Choice("Um...", "L2.2 ReturnToOffice:DarkCoffee"),
    new Choice("What was that..?", "L2.2 ReturnToOffice:DarkCoffee")
    ));

  //////////////////////////////////////////////////
  //                     L2.2                     //
  //////////////////////////////////////////////////
  retScenarios.put("L2.2 ReturnToOffice",
    new Scenario("data/Mom.png",
    "Upon returning to the building with drink in hand, you find that the entance floor is packed with people. How do you get want to get to the top floor?",
    new Choice("You don't feel like walking any more, and brave the elevator", "L2.2 BraveElevator"),
    new Choice("You take that stairs", "L2.2 TakeStairs")
    ));

  retScenarios.put("L2.2 BraveElevator",
    new Scenario("data/Mom.png",
    "You have to try to press the button, but there are many people.\n You don't know where you went.",
    new Choice("...", "L2.3 BossReturn"),
    new Choice("...", "L2.3 BossReturn")
    ));

  retScenarios.put("L2.2 TakeStairs",
    new Scenario("data/Mom.png",
    "Those aren't yours!",
    new Choice("I own this building!", "L2.2 StairsOwn"),
    new Choice("That makes no sense...", "L2.2 StairsNoSense")
    ));

  retScenarios.put("L2.2 StairsOwn",
    new Scenario("data/Mom.png",
    "[new Scenario ☐☐☐☐ started] Spoilers! Also not yet! But fine... Take them!",
    new Choice("...", "L2.2 StairsEnd"),
    new Choice("...", "L2.2 StairsEnd")
    ));

  retScenarios.put("L2.2 StairsEnd",
    new Scenario("data/Mom.png",
    "You stop staring at a blank wall, you take the elevator.",
    new Choice("...", "L2.3 BossReturn"),
    new Choice("...", "L2.3 BossReturn")
    ));

  //////////////////////////////////////////////////
  //                     L2.3                     //
  //////////////////////////////////////////////////

  retScenarios.put("L2.3 BossReturn:DarkCoffee",
    new Scenario("data/Mom.png",
    "After getting through that whole ordeal and little misadventure, you end up on the correct floor where you meet your boss.\nHe takes the coffee and says \"You should go see the new boss, apparently just got hired\".",
    new Choice("Alright", "L2.3 GoToNewBoss"),
    new Choice("Uh...", "L2.3 Hesitate")
    ));

retScenarios.put("L2.3 Hesitate",
    new Scenario("data/Mom.png",
    "You linger awkwardly in the office until your boss impatiently says, \"what is it?\"",
    new Choice("... Nothing", "L2.3 Rumours"),
    new Choice("Reveal your suspicions", "L2.3 Rumours")
    ));

retScenarios.put("L2.3 Rumours",
    new Scenario("data/Mom.png",
    "\"WHAT?! You think my wife is sleeping with another man?! I won't listen to this nonesense! Leave before I FIRE you!\" \n You hastily leave the office and the murderous gaze pointed at you. On your way out you pass CEO the going in.",
    new Choice("Well, that went well", "L2.3 BossDies"),
    new Choice("Shit", "L2.3 BossDies")
    ));

retScenarios.put("L2.3 BossDies",
    new Scenario("data/Mom.png",
    "You watch through the glass as your boss begins coughing violently and falls to the floor. Several guards arrive and drag the CEO away as the employees gossip. Apparently he was receiving a warrant of tax evasion and inappropriate conduct with subordinates, but now additionally manslaughter on top of that.",
    new Choice("Huh?", "L2."),
    new Choice("Guess it was true...", "L2.")
    ));

retScenarios.put("L2.3 WorkWork",
    new Scenario("data/Mom.png",
    "\"Alright! Enough of this, back to work everyone!\" Your boss calls out, and people go back to their stations. You sit down at your desk and begin working.",
    new Choice("*click, clack, click, click, clack, click*", "L2.3 WorkWorkWork"),
    new Choice("type type type type click type type click", "L2.3 WorkWorkWork")
    ));

retScenarios.put("L2.3 WorkWorkWork",
    new Scenario("data/Mom.png",
    "...",
    new Choice("*clack, click, click, clack, click, clack*", "L2.3 WorkWorkWorkWork"),
    new Choice("type type click type type type click type", "L2.3 WorkWorkWorkWork")
    ));

retScenarios.put("L2.3 WorkWorkWorkWork",
    new Scenario("data/Mom.png",
    "...",
    new Choice("*clack, clack, click, clack, clack, click*", "L2.3 NewCEO"),
    new Choice("type click type type click type type type", "L2.3 NewCEO")
    ));

retScenarios.put("L2.3 NewCEO",
    new Scenario("data/Mom.png",
    "After mind numbing work, you're for some reason called up to the CEO's office.",
    new Choice("Thank God", "L2.3 Notice"), 10
    new Choice("Finally a break", "L2.3 Notice"), -5
    ));

retScenarios.put("L2.3 Notice",
    new Scenario("data/Mom.png",
    "You get to the top floor, a spacious room with a single desk and chair in the middle. The leather chair slowly turns around and faces you. Your dog sits in it. \n Apparantly your dog was in the next line of succesion.",
    new Choice("What?", "L2.4 TheTalk"),
    new Choice("Uh, why was I called here... sir...", "L2.4 TheTalk")
    ));

  //////////////////////////////////////////////////
  //                     L2.4                     //
  //////////////////////////////////////////////////

retScenarios.put("L2.4 TheTalk",
    new Scenario("data/Mom.png",
    "...",
    new Choice("...", "L2."),
    new Choice("...", "L2.")
    ));

retScenarios.put("L2.4 ",
    new Scenario("data/Mom.png",
    "...",
    new Choice("...", "L2."),
    new Choice("...", "L2.")
    ));

  //////////////////////////////////////////////////
  //                     R1.1                     //
  //////////////////////////////////////////////////
  
retScenarios.put("R1.1 Arrival",
    new Scenario("data/Mom.png",
    "THIS IS YET TO BE IMPLEMENTED.",
    new Choice("I WANT MY MONEY BACK!", "R1.1 Moneyyy"),
    new Choice("Fineee, I'll wait", "Exit")
    ));

  retScenarios.put("R1.1 Moneyyy",
    new Scenario("data/Mom.png",
    "You paid money for this?! GO GET IT BACK! THIS IS FREE!!!",
    new Choice("FUCK, I really should stop buying games on the black market :/", "Exit"),
    new Choice("Roger Roger Comrade", "Exit")
    ));

  retScenarios.put("TITLE",
    new Scenario("data/Mom.png",
    "MESSAGE",
    new Choice("ANSWER1", "Exit"),
    new Choice("ANSWER2", "Exit")
    ));

  // Return our Dict
  return retScenarios;
}
