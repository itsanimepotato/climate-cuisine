
boolean update = false;
boolean gameStarted;
int currentScreen = 0;
boolean click;
/*
 0 = title screen
 1 = order screen
 2 = capture screen
 3 = convert station
 4 = create station
 5 = shop screen
 */

// stats (stuff that changes)
int level = -1; //tut = 0
int carbonCaught;
int totalCarbon = 0;
int carbonConvert;
int totalConvert = 0;
int carbonCreate;
int totalCreate = 0;
int[] materialConverted; // 0 = CO2, 1 = CaCO3
int[] materialCreated;
String[] materialCreatedNames = {
  "Methane",
  "Nanotubes",
  "Alkaseltzer",
  "Concrete",
  "Chalk"
};
/*
 0 = methane
 1 = nanotubes
 2 = alkaseltzer
 3 = concrete
 4 = chalk
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
  "You can digitally filter CO2 out of the air!" //9
};

// order screen
int testPerson = 0;
int person1, person2, person3 = 0;
String[] buyers = {
  "Heating Henderson", // for fuel
  "Nanotube Nate", // for nanotubes
  "Alkaseltzer Andy", // for alkaseltzer
  "Building Benny", // for concrete
  "Chalk Coleman", // for chalk
};
String[] buyerReason = {
  "so I can heat buildings and cook", // for fuel
  "so I can do electronics", // for nanotubes
  "so I can have soda", // for alkaseltzer
  "so I can build buildings", // for concrete
  "so I can write on a chalkboard", // for chalk
};


// capture screen
int START_CO2;
int captureRad;
int MOL_SIZE = 10;
color carbonGray = color(128, 128, 128);
color oxygenRed = color(255, 0, 0);
Molecules[] molecule;

// convert screen
Molecules[] convertChamberMols;
boolean[] converting;


// create screen
Reactions[] creation;
/*
methane
 nanotubes
 alkaseltzer
 concrete
 chalk
 */


// shop screen
int shopCO2 = 0; //increase when CO2 amt increase bought
int shopCapture = 0; //increase when capture upgrade bought

void setup() {
  size(750, 500);
  background(255);
  frameRate(60);

  carbonCaught = 0;
  carbonConvert = 0;
  carbonCreate = 0;
  captureRad = 67;
  shopCO2 = 0;
  shopCapture = 0;

  randomScrollText = int(random(0, scrollText.length));

  materialConverted = new int[2];
  materialConverted[0] = 0;
  materialConverted[1] = 0;

  converting = new boolean[2];
  converting[0] = false;
  converting[1] = false;

  materialCreated = new int[5];
  // println("materialCreated has been created: " + materialCreated);
  person1 = int(random(1, buyers.length));
  person2 = int(random(1, buyers.length));
  person3 = int(random(1, buyers.length));

  while (person2 == person1) {
    person2 = int(random(1, buyers.length));
  }
  while (person3 == person1 || person3 == person2) {
    person3 = int(random(1, buyers.length));
  }
  println("person setup: " + person1 + person2 + person3);

  START_CO2 = 5;
  molecule = new Molecules[START_CO2];

  for (int i = 0; i < START_CO2; i++) {
    int startX = int(random(MOL_SIZE, width - MOL_SIZE));
    int startY = int(random(MOL_SIZE, height*0.9 - MOL_SIZE));
    molecule[i] = new Molecules(startX, startY, MOL_SIZE, carbonGray);
  }

  convertChamberMols = new Molecules[5];


  creation = new Reactions[5];

  /*
 0 = fuel C
   1 = C nanotubes C
   2 = alkaseltzer C
   3 = concrete CaCO3
   4 = chalk CaCO3
   */
  creation[0] = new Reactions(width/3, height*0.9/4, "Methane", 100);
  creation[1] = new Reactions(width/3, 2*height*0.9/4, "Nanotubes", 100);
  creation[2] = new Reactions(width/3, 3*height*0.9/4, "Alkaseltzer", 100);
  creation[3] = new Reactions(2*width/3, height*0.9/4, "Concrete", 100);
  creation[4] = new Reactions(2*width/3, 2*height*0.9/4, "Chalk", 100);
}

void draw() {
  //println(currentScreen);
  titleScreen(); // current screen is 0
  orderScreen(); // current screen is 1
  captureScreen(); // current screen is 2
  convertScreen(); // current screen is 3
  createScreen(); // current screen is 4
  shopScreen(); // current screeen is 5
}

void keyPressed() {
  if (currentScreen == 0) {
    if (key == '1') {
      level = 1;
      currentScreen = 1;
      gameStarted = true;
    }
    if (key == '2') {
      level = 2;
      currentScreen = 1;
      gameStarted = true;
    }
    if (key == '3') {
      level = 3;
      currentScreen = 1;
      gameStarted = true;
    }
  }


  if (gameStarted) {
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
    if (key == '5') {
      currentScreen = 5;
    }
  }
}

void mousePressed() {
  click = true;
}

void mouseReleased() {
  click = false;
}


void titleScreen() {

  if (currentScreen == 0) {
    background(255);
    titleGameText();
    titleBlinkingText();
    titleScrollingText();
  }
}
void titleGameText() {
  //displays climate cuisine
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(100);
  text("CLIMATE CUISINE", width/2, height/2 - 150);
}

void titleBlinkingText() {
  //displays the blinking "press space" to move on to next
  textSize(40);
  if (frameCount % 60 == 0) {
    blinky = !blinky;
  }
  if (blinky) {
    fill(255, 0, 0);
    text ("PRESS 1 for EASY, 2 for MEDIUM, 3 for HARD", width/2, height/2 + 150);
  } else {
    fill(0, 255, 0);
    text ("PRESS 1 for EASY, 2 for MEDIUM, 3 for HARD", width/2, height/2 + 150);
  }
}

void titleScrollingText() {
  //displays scrolling text
  textAlign(LEFT, CENTER);
  textSize(25);
  fill(#11BAF5);
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


void navBar(String screen) {
  // black bar
  fill(0);
  rect(0, 0.9*height, width, height);
  // white text
  fill(255);
  textSize(25);

  textAlign(CENTER, CENTER);
  text(screen, width/2, 0.95*height);

  textSize(15);
  textAlign(LEFT, CENTER);
  text("Move screens using the keys [1,2,3,4,5]", width/100, 0.95*height);

  textSize(12);
  textAlign(RIGHT, CENTER);
  text("Total Captured C: " + totalCarbon + " " + "Total Converted C: " + totalConvert + " " + "Total Created: " +  totalCreate, width-width/100, 0.95*height);
}

void statboard(float x, float y) {
  textAlign(CENTER, CENTER);
  fill(0);

  for (int i = 0; i < materialCreated.length; i++) {
    text(materialCreatedNames[i], x-i*75 + 150, y);
    text(materialCreated[i], x-i*75 + 150, y + 15);
  }
}
