
void convertScreen() {
  if (currentScreen == 3) {
    background(255);
    navBar("Convert Screen");

    rect(0, height*0.9-10, width, 10);
    colorMode(HSB, 360, 100, 100);
    fill(frameCount%360, 100, 100);
    rect(0, height*0.9-10, width-2.5*(frameCount%300), 10);
    colorMode(RGB, 255, 255, 255);

    int flaskRad = 175;
    fill(255);

    convertMech(width/5, height/4, flaskRad, "CO2", 0);
    convertMech(width/5, height*0.9 - height/4, flaskRad, "CaCO3", 1);
    fill(0);
    text(materialConverted[0], width/2, height/4 + 25);
    text(materialConverted[1], width/2, height*0.9 - height/4 + 25);

    textSize(20);

    text("Methane", width-width/5, height/4-25);
    text("Nanotubes", width-width/5, height/4);
    text("Alkaseltzer", width-width/5, height/4+25);

    text("Concrete", width-width/5, height*0.9 - height/4 -15);
    text("Chalk", width-width/5, height*0.9 - height/4 +15);
  }
}

void convertMech(float x, float y, int flaskRad, String typeName, int type) {

  // chambers
  fill(255);
  rect(x+flaskRad/2, y-10, 3*height/4, 10);
  circle(x, y, flaskRad);
  circle(width-x, y, flaskRad);

  textAlign(CENTER, CENTER);
  textSize(20);
  fill(0);
  text(typeName, width/2, y-25);

  float distance = dist(mouseX, mouseY, x, y);
  if (distance <= flaskRad/2 && click && carbonCaught >= 5) {
    converting[type] = true;
    for (int i = 0; i < convertChamberMols.length; i++) {
      convertChamberMols[i] = new Molecules(int(x), int(y), MOL_SIZE, carbonGray);
    }
    carbonCaught -= 5;
  }

  if (converting[type] == true) {
    for (int i = 0; i < convertChamberMols.length; i++) {
      convertChamberMols[i].position.x += random(-1, 1);
      convertChamberMols[i].position.y += random(-1, 1);
      convertChamberMols[i].display();
    }
    if (frameCount % 300 == 0) {
      materialConverted[type] += 1;
      totalConvert += 1;
      converting[type] = false;
    }
  }
}
