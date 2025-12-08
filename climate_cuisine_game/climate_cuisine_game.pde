
boolean update = false;
int currentScreen = 0;
/*
 0 = title screen
 1 = order screen
 2 = capture screen
 3 = convert station
 4 = create station
 */

// stats (stuff that changes)
int level = 0; //tut = 0
int carbonCaught;
int carbonConvert;
int carbonStored;
int[] materialCreated;
/*
0 = concrete
 1 = fuel (CH4)
 2 = C nanotubes
 3 = carbonated water
 4 = bioplastic
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
int testPerson = 0;
int person1, person2, person3 = 0;
String[] buyers = {
  "Tutorial Tester", // the tutorial person
  "Building Benny", // for concrete
  "Heating Henderson", // for fuel
  "Composite Coleman", // for C nanotubes
  "Sparkling ", // for carbonated water
  "Polymer ", // for bioplastic
};



void setup() {
  size(750, 500);
  background(255);
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
}

void draw() {
  //println(currentScreen);
  updateStats(); // updates how much carbon created etc.
  titleScreen(); // current screen is 0
  orderScreen(); // current screen is 1
  captureScreen(); // current screen is 2
  convertScreen(); // current screen is 3
  createScreen(); // current screen is 4
  update = false;
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

  if (key == 'q') {
    level = level+1;
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
}

void orderScreen() {
  if (currentScreen == 1) {
    background(255);

    fill(0);
    rect(0, 0.9*height, width, height);

    fill(255);
    textAlign(CENTER, CENTER);
    text("Order Screen", width/2, 0.95*height);

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
}

void orderTicket(float topX, float topY, float ticketWidth, float ticketHeight, int person) {
  fill(255);
  rect(topX, topY, ticketWidth, ticketHeight); //whole ticket

  //ticket head
  rect(topX, topY, ticketWidth, 0.15*ticketHeight);
  fill(0);
  text(buyers[person], topX + ticketWidth/2, topY + 0.15*ticketHeight/2);
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

  if (frameCount % (frameRate * 30 * 1) == 0) { // 5 mins
    println("update");
    update = true;
  }
}
