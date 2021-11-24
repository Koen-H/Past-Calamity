import java.util.Stack;
import java.util.HashMap;

class SceneManager {
  private HashMap<String, Scene> scenes;
  private Stack<Scene> scenesStack;
  //private SoundManager soundManager;
  private boolean playingAmbience = false;
  private AudioPlayer currentAmbience;
  
  public SceneManager() {
    minim = new Minim(this);
    currentAmbience = minim.loadFile("");
    scenes = new HashMap<String, Scene>();
    scenesStack = new Stack<Scene>();
  }
  
  public void addScene(Scene scene) {
    scenes.put(scene.getSceneName(), scene);
    if(scenesStack.size() == 0)
    {
      scenesStack.push(scene);
    }
  }
  
  
  public void goToScene(String sceneName) /*throws Exception*/ {    //check scenename() soundmanager
    if(scenes.containsKey(sceneName)) {
      scenesStack.push(scenes.get(sceneName));
      scenes.get(sceneName).playDialogueOnEnter();
      scenes.get(sceneName).hasEntered = true;
          
          if (scenes.get(sceneName).getSceneName() == "sceneDiary" ||       //hide Inventory(Button) when diary is open
           scenes.get(sceneName).getSceneName() == "sceneDiary2"){
           inventoryManager.moveToDiaryScene = false;
           scenesStack.push(scenes.get(sceneName));
           }
          

      /*if (scenes.get(sceneName).getSceneName() == "sceneDiary" ||       //hide Inventory(Button) when diary is open
           scenes.get(sceneName).getSceneName() == "sceneDiary2"){
          showInventory = false;                        
          showInventoryButton = false;
      }
      else { showInventoryButton = true;}    //problem: when going back to previous screen inventory cannot be accessed, only when changing screens
      */      

      
      if (scenes.get(sceneName).ambience != null){                  //playing ambience
        //println(scenes.get(sceneName).ambience);
        
       if(currentAmbience != scenes.get(sceneName).ambience){    //dont rewind when reentering the same scene
          if (playingAmbience){
            pauseAmbience(currentAmbience);
          }
          currentAmbience = scenes.get(sceneName).ambience;                      //play current Ambience
          if(!scenes.get(sceneName).isCutScene){
            currentAmbience.rewind();
            playAmbience(currentAmbience);
            playingAmbience = true;
          }
          else { playCutSceneSound (currentAmbience);}
       }
       
          
        
        //soundManager.playAmbience(scenes.get(sceneName));  //doesnt work ¯\_(ツ)_/¯
      } 
    }
   
    else {
     /* throw new Exception("Scene not found with name: "+ sceneName + "." + 
                         "Make sure it was added to the sceneManager.");*/  
     println("Exception(Scene not found with name: " + sceneName + "." + " Make sure it was added to the sceneManager");
    }
  }
  
  public void playAmbience(AudioPlayer ambience){
    ambience.loop();                            //loop if the song ends
  }
  public void playCutSceneSound(AudioPlayer cutSceneSound){
    cutSceneSound.play();
  }
  
  public void pauseAmbience(AudioPlayer ambience){
    ambience.pause();
  }
  
  public void goToPreviousScene() {
    scenesStack.pop();
  }
  
  public Scene getCurrentScene() {
    return scenesStack.peek();
  }
}
