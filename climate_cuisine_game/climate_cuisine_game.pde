
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
int shopCO2; //increase when CO2 amt increase bought
int shopCapture; //increase when capture upgrade bought
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
  "Tutorial Tester", // the tutorial person
  "Heating Henderson", // for fuel
  "Composite Coleman", // for C nanotubes
  "Alkaseltzer Andy", // for alkaseltzer
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

// convert screen
Reactions[] reaction;
/*
methane
 nanotubes
 alkaseltzer
 concrete
 chalk
 */

void setup() {
  size(750, 500);
  background(255);
  frameRate(60);

  carbonCaught = 0;
  carbonConvert = 0;
  captureRad = 67;
  shopCO2 = 0;
  shopCapture = 0;

  randomScrollText = int(random(0, scrollText.length));

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

  TOTAL_CO2 = 10;
  molecule = new Molecules[TOTAL_CO2];

  for (int i = 0; i < TOTAL_CO2; i++) {
    int startX = int(random(MOL_SIZE, width - MOL_SIZE));
    int startY = int(random(MOL_SIZE, height*0.9 - MOL_SIZE));
    molecule[i] = new Molecules(startX, startY, MOL_SIZE, carbonGray);
  }

  reaction = new Reactions[5];

  /*
 0 = fuel C
   1 = C nanotubes C
   2 = alkaseltzer C
   3 = concrete CaCO3
   4 = chalk CaCO3
   */
  reaction[0] = new Reactions(width/3, height*0.9/4, "Methane");
  reaction[1] = new Reactions(width/3, 2*height*0.9/4, "Nanotubes");
  reaction[2] = new Reactions(width/3, 3*height*0.9/4, "Alkaseltzer");
  reaction[3] = new Reactions(2*width/3, height*0.9/4, "Concrete");
  reaction[4] = new Reactions(2*width/3, 2*height*0.9/4, "Chalk");
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

  textAlign(RIGHT, CENTER);
  text("Captured C: " + carbonCaught + " " + "Converted C: " + carbonConvert, width-width/100, 0.95*height);
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

    captureBackground();
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

void captureBackground() {
  fill(255);
  rect(width*0.1, height*0.1, width*0.8, height*0.1);
  textAlign(CENTER, CENTER);
  textSize(25);
  fill(0);
  text("6343.2 million metric tons of CO2eq in the US (2022)", width/2, height*0.15);

  fill(255);
  rect(width*0.1, height*0.2, width*0.8, height*0.1);

  fill(0, 0, 255);
  rect(width*0.1, height*0.2, width*0.8*.28, height*0.1);
  fill(255, 255, 0);
  rect(width*0.1+width*0.8*.28, height*0.2, width*0.8*.25, height*0.1);
  fill(128, 128, 128);
  rect(width*0.1+width*0.8*.28+width*0.8*.25, height*0.2, width*0.8*.23, height*0.1);
  fill(255, 75, 75);
  rect(width*0.1+width*0.8*.28+width*0.8*.25+width*0.8*.23, height*0.2, width*0.8*.13, height*0.1);
  fill(0, 255, 0);
  rect(width*0.1+width*0.8*.28+width*0.8*.25+width*0.8*.23+width*0.8*.13, height*0.2, width*0.8*.10, height*0.1);

  fill(0);
  textSize(15);
  textAlign(LEFT, CENTER);
  text("The Transportation, Electrical, Industrial, Residential/Commercial, and Agricultural sectors", width*0.1, height*0.35);
  text("creates 99% of the US's Greenhouse Gases (28%, 25%, 23%, 13%, 10% respectively + 1% other)", width*0.1, height*0.35+20);

  textAlign(CENTER, CENTER);
  text("How CO2 becomes usable (as in the playable part):", width/2, height*0.45);
  textAlign(LEFT, CENTER);
  text("Liquid Filtration", width*0.1, height*0.485);
  textAlign(RIGHT, CENTER);
  text("Gas Filtration", width*0.9, height*0.485);

  fill(255);
  rect(width*0.1, height*0.5, width*0.4, height*0.25);
  rect(width*0.1+width*0.4, height*0.5, width*0.4, height*0.25);

  textAlign(LEFT, CENTER);
  fill(0);
  text("- extracts CO2 by converting it to CaCO3", width*0.1+5, height*0.5+10);
  text("- after CaCO3 is made, needs to heat up to use", width*0.1+5, height*0.5+30);
  text("- inefficent", width*0.1+5, height*0.5+50);
  text("- takes a while to collect", width*0.1+5, height*0.5+70);
  text("CO2+H2O -> H2CO3+Ca(OH)2 -> CaCO3+2H2O", width*0.1+5, height*0.5+90);

  text("- extracts CO2 by separating from the air", width*0.5+5, height*0.5+10);
  text("- catalysts (end material = starting material)", width*0.5+5, height*0.5+30);
  text("- works faster than liquid filtration", width*0.5+5, height*0.5+50);
  text("- energy intensive", width*0.5+5, height*0.5+70);
  text("CO2(g) -> filter -> CO2(g)", width*0.5+5, height*0.5+90);
}

void convertScreen() {
  if (currentScreen == 3) {
    background(255);
    navBar("Convert Screen");

    rect(0, height*0.9-10, width, 10);
    colorMode(HSB, 360, 100, 100);
    fill(frameCount%360, 100, 100);
    rect(0, height*0.9-10, width-2.5*(frameCount%300), 10);
    colorMode(RGB, 255, 255, 255);


    for (int i = 0; i < reaction.length; i++) {
      reaction[i].display();
      float distanceFromMouse = dist(mouseX, mouseY, reaction[i].center.x, reaction[i].center.y);
      if ((distanceFromMouse <= reaction[i].chamberRad/2) && click && (carbonCaught>=5)) {
        reaction[i].process = true;

        carbonCaught = carbonCaught - 5;
      }

      if (frameCount % 300 == 0) {
        if (reaction[i].process) {
          reaction[i].process = !reaction[i].process;
          carbonConvert++;
          materialCreated[i] = materialCreated[i] + 1;
        }
      }
    }
    for (int i = 0; i < materialCreated.length; i++) {
      println(materialCreatedNames[i] + " " + materialCreated[i]);
    }

    textAlign(CENTER, CENTER);
    textSize(15);
    fill(0);
    text("Press the circles to convert CO2 into the materials you need", 2*width/3, 3*height*0.9/4);
    text("There's totally no bug here", 2*width/3, 3*height*0.9/4 + 20);
    text("These are your stats in the order of", 2*width/3, 3*height*0.9/4 + 40);
    convertStats();
  }
}

void convertStats() {
  textAlign(CENTER, CENTER);
  for (int i = 0; i < materialCreated.length; i++) {
    text(materialCreatedNames[i], 2*width/3 - i*75 + 150, 3*height*0.9/4 + 60);
    text(materialCreated[i], 2*width/3 - i*75 + 150, 3*height*0.9/4 + 75);
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
