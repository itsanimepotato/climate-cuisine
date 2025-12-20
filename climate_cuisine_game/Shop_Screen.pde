
void shopScreen() {
  if (currentScreen == 5) {
    background(255);
    navBar("Shop Screen");

    shopButton(width/3, height*0.9/2, 200, "Amount of CO2 available", 0, 10);
    shopButton(2*width/3, height*0.9/2, 200, "Size of CO2 capture radius", 1, 5);

    text(shopCO2 + " out of 5", width/3, height*0.9 - 100);
    text(shopCapture + " out of 5", 2*width/3, height*0.9 - 100);
  }
}

void shopButton(float x, float y, int r, String typeName, int type, int cost) {
  fill(255);
  circle(x, y, r);

  textAlign(CENTER, CENTER);
  textSize(20);
  fill(0);
  text(typeName, x, y - r/2 - 15);

  float distanceFromMouse = dist(mouseX, mouseY, x, y);

  if (distanceFromMouse <= r/2 && click) {
    if (carbonCreate >= cost) {
      fill(0);
      circle(x, y, r);

      if (type == 0) {
        if (shopCO2 != 5) {
          molecule = (Molecules[])expand(molecule);
          shopCO2++;

          for (int i = 0; i < molecule.length; i++) {
            int startX = int(random(MOL_SIZE, width - MOL_SIZE));
            int startY = int(random(MOL_SIZE, height*0.9 - MOL_SIZE));
            molecule[i] = new Molecules(startX, startY, MOL_SIZE, carbonGray);
          }
        }
      }

      if (type == 1) {
        if (shopCapture != 5) {
          shopCapture++;
        }
      }

      carbonCreate-=cost;
    }
  }
}
