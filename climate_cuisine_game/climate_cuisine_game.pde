
// stats (stuff that changes)
int carbonCaught;
int carbonConvert;
int carbonStored;
int[] materialCreated;
/*
0 = concrete
 1 = fuel
 2 = C nanotubes
 3 = carbonated water
 4 = storage
 */

int currentScreen = 0;
/*
 0 = title screen
 1 = order screen
 2 = capture screen
 3 = convert station
 4 = create station
 */

// title screen globals
int randomScrollText;
int prevScrollText = 0;
boolean blinky;
String[] scrollText = {
  "Capture the Carbon!", //0
  "Make stuff using Carbon Dioxide!",
  "Do very simple chemistry!",
  "Become a service worker!", //3
  "Learn about the Tech-optimist POV!",
  "Reduce CO2eq from 6343.2 million metric tons!",
  "Most greenhouse gases are produced from transport!", //6
  "Residential/commercial, and the energy it uses, creates 31% of the US's CO2 production",
  "There are two main ways of collecting carbon: precombustion and postcombustion!",
  "You can literally filter CO2 out of the air!" //9
};

// order screen

String[] buyers = {

};

void setup() {
  size(750, 500);
  background(255);
  randomScrollText = int(random(0, scrollText.length));

  materialCreated = new int[3];
  // println("materialCreated has been created: " + materialCreated);
}

void draw() {
  //println(currentScreen);
  titleScreen(); // current screen is 0
  orderScreen(); // current screen is 1
  captureScreen(); //current screen is 2
  convertScreen(); //current screen is 3
  createScreen(); //current screen is 4
  updateStats();
}

void keyPressed() {
  if ((key == ' ') && (currentScreen == 0)) {
    currentScreen = 1;
  }

  if (currentScreen != 0) {
    if (key == '1') {
      currentScreen = 1;
    }
    if (key == '2') {
      currentScreen = 2;
    }
    if (key == '3') {
      currentScreen = 3;
    }
    if (key == '4') {
      currentScreen = 4;
    }
  }
}

void titleScreen() {
  if (currentScreen == 0) {
    background(255);
    //displays climate cuisine
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(100);
    text("CLIMATE CUISINE", width/2, height/2 - 150);

    //displays the blinking "press space" to move on to next
    textSize(50);
    if (frameCount % 45 == 0) {
      blinky = !blinky;
    }
    if (blinky) {
      fill(255, 0, 0);
      text ("PRESS [SPACE] TO START", width/2, height/2 + 150);
    } else {
      fill(0, 255, 0);
      text ("PRESS [SPACE] TO START", width/2, height/2 + 150);
    }

    //displays scrolling text
    textAlign(LEFT, CENTER);
    textSize(25);
    fill(255, 255, 0);
    if (frameCount % width == 0) {
      randomScrollText = int(random(0, scrollText.length));
      println("randomScrollText " + randomScrollText + " has been picked");
      while (randomScrollText == prevScrollText) {
        randomScrollText = int(random(0, scrollText.length));
      }
    }
    text(scrollText[randomScrollText], width - (frameCount % width + width/4), height/2);
    prevScrollText = randomScrollText;
  }
}

void orderScreen() {
  if (currentScreen == 1) {
    background(255);

    fill(0);
    rect(0, 0.9*height, width, height);

    fill(255);
    textAlign(CENTER, CENTER);
    text("Order Screen", width/2, 0.95*height);

    orderTicket(0, 0, width/3, 0.90*height);
    orderTicket(width/3, 0, 2*width/3, 0.90*height);
    orderTicket(2*width/3, 0, width, 0.90*height);
  }
}

void orderTicket(float topX, float topY, float bottomX, float bottomY) {
  rect(topX, topY, bottomX, bottomY);

  rect(topX, topY, bottomX, 0.15*bottomY);
}

void captureScreen() {
  if (currentScreen == 2) {
    background(255);

    fill(0);
    rect(0, 0.9*height, width, height);

    fill(255);
    textAlign(CENTER, CENTER);
    text("Capture Screen", width/2, 0.95*height);
  }
}

void convertScreen() {
  if (currentScreen == 3) {
    background(255);

    fill(0);
    rect(0, 0.9*height, width, height);

    fill(255);
    textAlign(CENTER, CENTER);
    text("Convert Screen", width/2, 0.95*height);
  }
}

void createScreen() {
  if (currentScreen == 4) {
    background(255);

    fill(0);
    rect(0, 0.9*height, width, height);

    fill(255);
    textAlign(CENTER, CENTER);
    text("Create Screen", width/2, 0.95*height);
  }
}

void updateStats() {
}
