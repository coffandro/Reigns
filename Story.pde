HashMap<String, Scenario> GetScenarioTree() {
  HashMap<String, Scenario> retScenarios = new HashMap<String, Scenario>();
  
  retScenarios.put("Intro", 
    new Scenario("Mom.png", "Mom", 
      "Heya sweetie, you sleep well?",
      new Choice("Yes", "Exit"), new Choice("No", "SleepNow")
  ));
  
  retScenarios.put("SleepNow", 
    new Scenario("Mom.png", "Mom", 
      "That's not so good, you'll need to sleep now!",
      new Choice("Wait no...", "AcceptSleep"), new Choice("awww okay :/", "Exit")
  ));
  
  retScenarios.put("AcceptSleep", 
    new Scenario("Mom.png", "Mom",
      "That wasn't a request.\n *pulls out baseball bat*",
      new Choice("RUNNN!", "Exit"), new Choice("AAAAA!", "Exit")
  ));
  
  return retScenarios;
}
