ArrayList<Dialogue> dialogueManager = new ArrayList<Dialogue>();
public boolean isDialogueActive;

class DialogueObject extends GameObject {

  private Dialogue dialogue;

  public DialogueObject(String identifier, int x, int y, int owidth, 
    int oheight, String gameObjectImageFile, Dialogue dialogue) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
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
  protected int xPos = 284;
  protected int yPos = 545;
  protected int w = 695;
  protected int h = 139;
  protected float textSize = 25;
  protected PImage background /*= loadImage("debugblock.png")*/;

  //text 
  protected String text;
  protected int textLength;
  protected int textCurrent;
  protected String printText = "";

  public DialogueBox(String text) {
    this.text = text;
    this.textLength = text.length();
  }


  public void drawDialogueBox() {
    // quad(xPos, yPos, (xPos+w), yPos, (xPos+w), (yPos+h), xPos, (yPos+h));
    if (background != null) {
      image(background, xPos, yPos, w, h);
    } else {
      fill(#F79500);
      quad(xPos, yPos, (xPos+w), yPos, (xPos+w), (yPos+h), xPos, (yPos+h));
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
    text(printText, xPos + 15, yPos + textSize);
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

  public void nextDialogueBox() {
    if (isActive && dialogue.get(currentDialogueBox).finishedTyping() ) {
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
    for ( DialogueBox dialogueBox : dialogue) {
      dialogueBox.textCurrent = 0;
      dialogueBox.printText = "";
    }
    this.currentDialogueBox = 0;
    isDialogueActive = true;
    isActive = true;
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
  }
}