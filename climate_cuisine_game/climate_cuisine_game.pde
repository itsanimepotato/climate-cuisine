
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
int carbonConvert;
int carbonStored;
int shopCO2; //increase when CO2 amt increase bought
int shopCapture; //increase when capture upgrade bought
int[] materialCreated;
/*
 0 = fuel C
 1 = C nanotubes C
 2 = carbonated water C
 3 = carbon nanotubes C
 4 = concrete CaCO3
 5 = chalk CaCO3
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
  "Tutorial Tester", // the tutorial person
  "Heating Henderson", // for fuel
  "Composite Coleman", // for C nanotubes
  "Alkaseltzer Andy", // for carbonated water
  "Building Benny", // for concrete
  "Chalk Cindy", // for chalk
};


// capture screen
int TOTAL_CO2;
int captureRad;
int MOL_SIZE = 15;
color carbonGray = color(128, 128, 128);
color oxygenRed = color(255, 0, 0);
Molecules[] molecule;



void setup() {
  size(750, 500);
  background(255);

  carbonCaught = 0;
  carbonConvert = 0;
  carbonStored = 0;

  randomScrollText = int(random(0, scrollText.length));

  materialCreated = new int[3];
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

  TOTAL_CO2 = 10;
  molecule = new Molecules[TOTAL_CO2];

  for (int i = 0; i < TOTAL_CO2; i++) {
    int startX = int(random(MOL_SIZE, width - MOL_SIZE));
    int startY = int(random(MOL_SIZE, height*0.9 - MOL_SIZE));
    molecule[i] = new Molecules(startX, startY, MOL_SIZE, carbonGray);
  }
  captureRad = 67;
  shopCO2 = 0;
  shopCapture = 0;
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
    if (key == '0') {
      level = 0;
    }
    if (key == '1') {
      level = 1;
    }
    if (key == '2') {
      level = 2;
    }
    if (key == '3') {
      level = 3;
    }
    currentScreen = 1;
    gameStarted = true;
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
    text ("PRESS 0 for the TUTORIAL", width/2, height/2 + 200);
  } else {
    fill(0, 255, 0);
    text ("PRESS 1 for EASY, 2 for MEDIUM, 3 for HARD", width/2, height/2 + 150);
    text ("PRESS 0 for the TUTORIAL", width/2, height/2 + 200);
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
}



void orderScreen() {
  if (currentScreen == 1) {
    background(255);
    navBar("Order Screen");

    orderTicketAndLevels();
  }
}

void orderTicketAndLevels() {
  // println(level);
  if (level == 0) {
    orderTicket(0, 0, width/3, 0.90*height, testPerson);
  }

  if (level == 1) {
    orderTicket(0, 0, width/3, 0.90*height, person1);
  }

  if (level == 2) {
    orderTicket(0, 0, width/3, 0.90*height, person1);
    orderTicket(width/3, 0, width/3, 0.90*height, person2);
  }

  if (level == 3) {
    orderTicket(0, 0, width/3, 0.90*height, person1);
    orderTicket(width/3, 0, width/3, 0.90*height, person2);
    orderTicket(2*width/3, 0, width/3, 0.90*height, person3);
  }
}

void orderTicket(float topX, float topY, float ticketWidth, float ticketHeight, int person) {
  fill(255);
  rect(topX, topY, ticketWidth, ticketHeight); //whole ticket

  //ticket head
  rect(topX, topY, ticketWidth, 0.15*ticketHeight);
  fill(0);
  textSize(25);
  textAlign(CENTER, CENTER);
  text(buyers[person], topX + ticketWidth/2, topY + 0.15*ticketHeight/2);
}

void captureScreen() {
  if (currentScreen == 2) {
    background(255);
    navBar("Capture Screen");

    captureCarbon();

    for (int i = 0; i < TOTAL_CO2; i++) {

      molecule[i].move();
      if (molecule[i].visible) {
        molecule[i].display();
      }

      if (frameCount % (60*5) == 0) {
        molecule[i].visible = true;
      }
    }
  }
}

void captureCarbon() {
  int fullCapture = captureRad + shopCapture*10;
  strokeWeight(3);
  fill(255, 255, 255, 0);
  //circle(mouseX, mouseY, fullCapture);

  circle(mouseX, mouseY, fullCapture);


  for (int i = 0; i < TOTAL_CO2; i++) {
    float distanceFromMouse = dist(mouseX, mouseY, molecule[i].position.x, molecule[i].position.y);

    if ((distanceFromMouse <= fullCapture/2) && click) {
      int startX = int(random(MOL_SIZE, width - MOL_SIZE));
      int startY = int(random(MOL_SIZE, height*0.9 - MOL_SIZE));
      stroke(255, 0, 0);
      carbonCaught++;
      molecule[i].visible = false;
      molecule[i].position = new PVector(startX, startY);
    }
  }

  stroke(0);
  strokeWeight(1);
}

void convertScreen() {
  if (currentScreen == 3) {
    background(255);
    navBar("Convert Screen");
  }
}

void createScreen() {
  if (currentScreen == 4) {
    background(255);
    navBar("Create Screen");
  }
}

void shopScreen() {
  if (currentScreen == 5) {
    background(255);
    navBar("Shop Screen");
  }
}
