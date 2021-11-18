public ArrayList<keypadButtonObject> keypad = new ArrayList<keypadButtonObject>();

int keypadCode = 1234;
int attempt;
String result;
boolean keypadCompleted, keypadSetProgress;
float keypadContinueTime;



void createKeypad(int xPos, int yPos, int buttonSize, float spaceBetween) {

  int startXPos = xPos;
  for (int i = 9; i > 0; i--) {
    keypad.add(new keypadButtonObject(xPos, yPos, buttonSize, spaceBetween, i));
    xPos += buttonSize + spaceBetween;
    if (xPos == startXPos + ((spaceBetween + buttonSize )* 3)) {
      yPos += buttonSize + spaceBetween;
      xPos = startXPos;
    }
  }
  //for ( keypadButtonObject kepadButton : keypad) kepadButton.drawButton();
}

void drawKeypad() {
  for ( keypadButtonObject keypadButton : keypad) keypadButton.drawButton();
  fill(0);
  textSize(40);
  if (result == "CORRECT") {
    
    if (!keypadSetProgress) {
      keypadSetProgress = true;
      sceneManager.scenes.get("scene02").backgroundImage = loadImage("scene02doorOpen.png");
      MoveToSceneObject s02GoOutside = new MoveToSceneObject("s02GoOutside", 640, 300, 50, 50, "debugblock.png", "scene03");//go to outside Door scene
      sceneManager.scenes.get("scene02").addGameObject(s02GoOutside);
    }
    text("CORRECT", (width/2), 300);
    if (keypadContinueTime <= millis() && !keypadCompleted) {
      sceneManager.goToScene("scene02");//TODO set next scene TODO
      keypadCompleted = true;
    }
  } else if (attempt != 0) {
    if (String.valueOf(attempt).length() == 4) {
      if (attempt == keypadCode) {
        result = "CORRECT";
        keypadContinueTime = millis() + 2000;
      } else {
        attempt = 0;
        result = "WRONG";
      }
    } else {
      text(attempt, (width/2), 300);
    }
  } else if (result == "WRONG") {
    text("WRONG", (width/2), 300);
  }
}
class keypadButtonObject {
  float xPos, yPos, buttonSize, spaceBetween;
  int number;

  keypadButtonObject(float xPos, float yPos, float buttonSize, float spaceBetween, int number) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.buttonSize = buttonSize;
    this.spaceBetween = spaceBetween;
    this.number = number;
  }

  void drawButton() {
    fill(255);
    square(xPos, yPos, buttonSize);
    fill(0);
    textSize(40);
    text(number, (xPos + buttonSize/2 - spaceBetween), (yPos + buttonSize/2 + spaceBetween));
  }
  void clicked() {//check if key has been clicked
    if ((mouseX > (this.xPos) && mouseX < (this.xPos + (buttonSize))) && (mouseY > (this.yPos) && mouseY < (this.yPos + (buttonSize)))  ) {
      attempt = attempt * 10 + number;
    }
  }
}
