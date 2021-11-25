ArrayList<Dialogue> dialogueManager = new ArrayList<Dialogue>();
public boolean isDialogueActive;

class SpriteCharacter {
  protected PImage sprite;
  protected String name;

  public SpriteCharacter( String name, String sprite) {
    this.sprite = loadImage(sprite);
    this.name = name;
  }
}


class DialogueObject extends GameObject {

  private Dialogue dialogue;

  public DialogueObject(String identifier, int x, int y, int owidth, 
    int oheight, String gameObjectImageFile, Dialogue dialogue) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, null);
    this.dialogue = dialogue;
  }

  @Override
    public void mouseClicked() {
    if (mouseIsHovering) { 
      dialogue.activateDialogue();
    }
  }
}


class DialogueBox {
  //dialogueSettings
  protected int xPos = 212;
  protected int yPos = 531;
  protected int w = 842;//695
  protected int h = 167;//139
  protected float textSize = 20;
  protected PImage background = loadImage("TextBox.png");
  protected PImage backgroundText;

  //character
  protected SpriteCharacter sprite;

  //text 
  protected String text;
  protected int textLength;
  protected int textCurrent;
  protected String printText = "";
  private AudioPlayer soundEffect;

  public DialogueBox(String text, SpriteCharacter sprite) {
    this.sprite = sprite;
    this.text = text;
    this.textLength = text.length();
  }
  public DialogueBox(String text, SpriteCharacter sprite, AudioPlayer soundEffect) {
    this.sprite = sprite;
    this.text = text;
    this.textLength = text.length();
    this.soundEffect = soundEffect;
  }


  public void drawDialogueBox() {
    //quad(xPos, yPos, (xPos+w), yPos, (xPos+w), (yPos+h), xPos, (yPos+h));
    //image(sprite.sprite, (xPos + w - 300), (yPos - 350));//sprite image
    fill(180);
    //quad(xPos, (yPos- textSize), (xPos+200), (yPos-textSize), (xPos+200), yPos, xPos, yPos);
    //quad(xPos, yPos, (xPos+w), yPos, (xPos+w), (yPos+h), xPos, (yPos+h));
    image(sprite.sprite, -1, -1);
    if (background != null) {
      image(background, xPos, yPos, w, h);
      //image(backgroundText, xPos, (yPos-textSize), 200, (yPos+textSize));
    }

    drawText();
  }

  public void drawText() {
    fill(0);
    if (textLength > textCurrent) {
      printText += text.charAt(textCurrent);
      textCurrent++;
    }
    textSize(textSize);
    text(printText, xPos + 32, yPos + 35);
    // text(sprite.name, xPos + 5, yPos -2);
  }

  boolean finishedTyping() {

    if (textLength == textCurrent) {
      return true;
    }
    return false;
  }
}

class Dialogue {
  private ArrayList<DialogueBox> dialogue = new ArrayList<DialogueBox>();

  private int currentDialogueBox = 0;
  private boolean isActive;
  private String afterDialogueMethod;


  public Dialogue() {
  }

  public Dialogue(String afterDialogueMethod) {
    this.afterDialogueMethod = afterDialogueMethod;
  }


  public void nextDialogueBox() {
    if (isActive && dialogue.get(currentDialogueBox).finishedTyping() ) {
      if (dialogue.get(currentDialogueBox).soundEffect != null) {
        dialogue.get(currentDialogueBox).soundEffect.rewind();
        dialogue.get(currentDialogueBox).soundEffect.play();
      }
      println("typing text...");
      ++currentDialogueBox;
      if (dialogue.size() == currentDialogueBox) {
        this.disableDialogue();
      }
    } else if (isActive) {
      this.dialogue.get(currentDialogueBox).textCurrent = dialogue.get(currentDialogueBox).textLength;
      this.dialogue.get(currentDialogueBox).printText = dialogue.get(currentDialogueBox).text;
    }
  }

  public void activateDialogue() {
    if (playDialogue) {
      for ( DialogueBox dialogueBox : dialogue) {
        dialogueBox.textCurrent = 0;
        dialogueBox.printText = "";
      }
      this.currentDialogueBox = 0;
      isDialogueActive = true;
      isActive = true;
    }
  }

  public void drawDialogueBox() {
    if (isActive) {
      dialogue.get(currentDialogueBox).drawDialogueBox();
    }
  }

  public void addDialogueBox(DialogueBox dialoguebox) {
    dialogue.add(dialoguebox);
  }

  public void disableDialogue() {

    isActive = false;
    isDialogueActive = false;
    if (afterDialogueMethod != null) {
      afterDialogue(afterDialogueMethod);
    }
  }
}

public void afterDialogue(String afterDialogue) {
  println("Dialogue ended method: " + afterDialogue);
  if (afterDialogue.equals("activatedHologram")) {
    //sceneManager.getCurrentScene().removeGameObject(newsReporter);
  }
  if (afterDialogue.equals("cutScene01")) {
    sceneManager.goToScene("cutScene02");
  }
  if (afterDialogue.equals("cutScene02")) {
    heartbeat.play();
    sceneManager.goToScene("blackScene");
  }
  if (afterDialogue.equals("checkForEnd")) {
    if (timeBatterySolved && timeResult == "CORRECT") {
      sceneManager.goToScene("endingScene");
    }
  }
  if (afterDialogue.equals("theEnd")) {
    sceneManager.goToScene("creditScene");
    sceneManager.getCurrentScene().removeGameObject(playButton);
  }
}
public void Dialogue() {

}
