public ArrayList<keypadButtonObject> keypad = new ArrayList<keypadButtonObject>();
public ArrayList<keypadButtonObject> timeKeypad = new ArrayList<keypadButtonObject>();

String keypadCode = "12152205";
String attempt = "";
String result;
boolean keypadCompleted, keypadSetProgress;
float keypadContinueTime;

String timeKeypadCode = "03122122";
String timeAttempt = "";
String timeResult;
boolean timeKeypadCompleted, timeKeypadSetProgress;
float timeKeypadContinueTime;


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
  keypad.add(new keypadButtonObject((xPos + buttonSize + spaceBetween), (yPos), buttonSize, spaceBetween, 0));

  //for ( keypadButtonObject kepadButton : keypad) kepadButton.drawButton();
}
void createTimeKeypad(int xPos, int yPos, int buttonSize, float spaceBetween) {

  int startXPos = xPos;
  for (int i = 9; i > 0; i--) {
    timeKeypad.add(new keypadButtonObject(xPos, yPos, buttonSize, spaceBetween, i));
    xPos += buttonSize + spaceBetween;
    if (xPos == startXPos + ((spaceBetween + buttonSize )* 3)) {
      yPos += buttonSize + spaceBetween;
      xPos = startXPos;
    }
  }
  timeKeypad.add(new keypadButtonObject((xPos + buttonSize + spaceBetween), (yPos), buttonSize, spaceBetween, 0));

  //for ( keypadButtonObject kepadButton : keypad) kepadButton.drawButton();
}

void drawKeypad() {
  if (sceneManager.getCurrentScene().getSceneName() == "scene02Keypad") {
    for ( keypadButtonObject keypadButton : keypad) keypadButton.drawButton();
  } else if ( sceneManager.getCurrentScene().getSceneName() == "scene01TimeMachineKeyPad") {
    for ( keypadButtonObject keypadButton : timeKeypad) keypadButton.drawButton();
  }
  fill(0);
  textSize(42);
  if (sceneManager.getCurrentScene().getSceneName() == "scene02Keypad") {
    if (result == "CORRECT") {

      if (!keypadSetProgress) {
        keypadSetProgress = true;
        sceneManager.scenes.get("scene02").backgroundImage = loadImage("door_open.png");
        MoveToSceneObject s02GoOutside = new MoveToSceneObject("s02GoOutside", 625, 550, 50, 50, "debugblock.png", "scene03", walk1);//go to outside Door scene
        sceneManager.scenes.get("scene02").addGameObject(s02GoOutside);
      }
      text("CORRECT", 490, 225);
      if (keypadContinueTime <= millis() && !keypadCompleted) {
        sceneManager.goToScene("scene02");//TODO set next scene TODO
        keypadCompleted = true;
      }
    } else if (attempt != "") {
      if (String.valueOf(attempt).length() == 8) {
        if (attempt.equals(keypadCode)) {
          result = "CORRECT";
          keypadContinueTime = millis() + 2000;
        } else {
          attempt = "";
          result = "WRONG";
        }
      } else {
        text(attempt, 490, 225);
      }
    } else if (result == "WRONG") {
      text("WRONG", 490, 225);
    }
  }
  if (sceneManager.getCurrentScene().getSceneName() == "scene01TimeMachineKeyPad") {
    if (timeResult == "CORRECT") {
      text("CORRECT", (width/2), 300);
    } else if (timeAttempt != "") {
      if (String.valueOf(timeAttempt).length() == String.valueOf(timeKeypadCode).length()) {
        if (attempt.equals(keypadCode)) {
          timeResult = "CORRECT";
          timeKeypadContinueTime = millis() + 2000;
        } else {
          timeAttempt = "";
          timeResult = "WRONG";
        }
      } else {
        String timeDate = timeAttempt;
        while (String.valueOf(timeDate).length() < String.valueOf(timeKeypadCode).length()) {
          timeDate += "0";
          println(timeDate);
        }
        String ss1 = timeDate.substring(0, 2);
        String ss2 = timeDate.substring(2, 4); 
        String ss3 = timeDate.substring(4, 8);  
        timeDate = timeDate.substring(0, 2) + "-" + timeDate.substring(2, 4) + "-" + timeDate.substring(4, 8);
        text(timeDate, (width/2), 300);
      }
    } else if (timeResult == "WRONG") {
      text("WRONG", (width/2), 300);
    }
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
      if (sceneManager.getCurrentScene().getSceneName() == "scene02Keypad") {
        attempt += str(number);
      } else if (sceneManager.getCurrentScene().getSceneName() == "scene01TimeMachineKeyPad") {
        timeAttempt += str(number);
      }
    }
    else return false;
  }
}
