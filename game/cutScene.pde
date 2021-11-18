public ArrayList<CutScene> cutScenes = new ArrayList<CutScene>();
//By creating a CutScene, cutScenes.add(new CutScene scene(3,"cutScene02");
//This example will automatically change the scene to cutScene02 after 3 seconds;

public void doCutScene01() {
  println("test");
  cutScenes.add(new CutScene(0, "cutScene01"));
  cutScenes.add(new CutScene(3, "cutScene02"));
  cutScenes.add(new CutScene(6, "cutScene03"));
}

class CutScene {
  int timeToChange;
  String nextScene;
  boolean changedScene = false;


  public CutScene(int secondToWait, String nextScene) {
    this.timeToChange = millis() + (secondToWait * 1000);
    this.nextScene = nextScene;
  }

  public void update() {
    if (millis() >= timeToChange && !changedScene) {
      changedScene = true;
      sceneManager.goToScene(nextScene);
    }
  }
}
