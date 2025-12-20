
void createScreen() {
  if (currentScreen == 4) {
    background(255);
    navBar("Create Screen");

    rect(0, height*0.9-10, width, 10);
    colorMode(HSB, 360, 100, 100);
    fill(frameCount%360, 100, 100);
    rect(0, height*0.9-10, width-2.5*(frameCount%300), 10);
    colorMode(RGB, 255, 255, 255);

    fill(0);
    textSize(15);
    textAlign(LEFT, CENTER);
    text("Carbon based: " + materialConverted[0], 5, height*0.9/2);

    textAlign(RIGHT, CENTER);
    text("Calcium based: " + materialConverted[1], width-5, height*0.9/2);

    for (int i = 0; i < creation.length; i++) {
      creation[i].display();
      float distanceFromMouse = dist(mouseX, mouseY, creation[i].center.x, creation[i].center.y);

      boolean matConTest = false;
      if (i <= 2) {
        if (materialConverted[0] >= 1) {
          matConTest = true;
        }
      } else {
        if (materialConverted[1] >= 1) {

          matConTest = true;
        }
      }


      if ((distanceFromMouse <= creation[i].chamberRad/2) && click && (matConTest)) {
        creation[i].process = true;
        if (i <= 2) {
          materialConverted[0]--;
        } else {
          materialConverted[1]--;
        }
      }

      if (frameCount % 300 == 0) {
        if (creation[i].process) {
          creation[i].process = !creation[i].process;
          totalCreate++;
          carbonCreate++;
          materialCreated[i] = materialCreated[i] + 1;
        }
      }
    }


    textAlign(CENTER, CENTER);
    textSize(20);
    fill(0);

    text("Press the circles to create your end products!", width/2, 20);

    textSize(15);
    text("Stay on this screen to keep creating the materials", 2*width/3, 3*height*0.9/4);
    text("There's totally no bugs here", 2*width/3, 3*height*0.9/4 + 20);
    text("These are your stats:", 2*width/3, 3*height*0.9/4 + 40);
    statboard(2*width/3, 3*height*0.9/4 + 60);
  }
}
