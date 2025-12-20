void captureScreen() {
  if (currentScreen == 2) {
    background(255);
    navBar("Capture Screen");
    rect(0, height*0.9-10, width, 10);
    colorMode(HSB, 360, 100, 100);
    fill(frameCount%360, 100, 100);
    rect(0, height*0.9-10, width-2.5*(frameCount%300), 10);
    colorMode(RGB, 255, 255, 255);

    captureBackground();
    captureCarbon();

    for (int i = 0; i < molecule.length; i++) {

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
  int fullCapture = captureRad + shopCapture*25;
  if (shopCapture != 0) {
    captureRad = 75;
  }
  println(fullCapture);
  strokeWeight(3);
  fill(255, 255, 255, 0);

  circle(mouseX, mouseY, fullCapture);


  for (int i = 0; i < molecule.length; i++) {
    float distanceFromMouse = dist(mouseX, mouseY, molecule[i].position.x, molecule[i].position.y);

    if ((distanceFromMouse <= fullCapture/2) && click) {
      int startX = int(random(MOL_SIZE, width - MOL_SIZE));
      int startY = int(random(MOL_SIZE, height*0.9 - MOL_SIZE));
      stroke(255, 0, 0);
      if (molecule[i].visible) {
        carbonCaught++;
        totalCarbon++;
      }
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
  text("- inefficient", width*0.1+5, height*0.5+50);
  text("- takes a while to collect", width*0.1+5, height*0.5+70);
  text("CO2+H2O -> H2CO3+Ca(OH)2 -> CaCO3+2H2O", width*0.1+5, height*0.5+90);

  text("- extracts CO2 by separating from the air", width*0.5+5, height*0.5+10);
  text("- catalysts (end material = starting material)", width*0.5+5, height*0.5+30);
  text("- works faster than liquid filtration", width*0.5+5, height*0.5+50);
  text("- energy intensive", width*0.5+5, height*0.5+70);
  text("CO2(g) -> filter -> CO2(g)", width*0.5+5, height*0.5+90);

  textAlign(CENTER, CENTER);
  textSize(20);
  text("Carbon Stored: " + carbonCaught, width/2, height*0.9 - 50);
}
