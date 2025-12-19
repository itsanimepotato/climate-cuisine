class Reactions {
  PVector center;
  String type;
  int chamberRad;
  boolean process;
  int count = 0;


  Reactions(float x, float y, String t) {
    center = new PVector(x, y);
    type = t;
    chamberRad = 100;
  }

  void display() {
    fill(255);
    circle(center.x, center.y, chamberRad);
    fill(0);
    textSize(15);
    if (center.x < width/2) {
      textAlign(RIGHT, CENTER);
      text(type + " Materials: " + count, center.x - chamberRad, center.y);
    }
    if (center.x > width/2) {
      textAlign(LEFT, CENTER);
      text(type + " Materials: " + count, center.x + chamberRad, center.y);
    }

    if (process) {
      colorMode(HSB, 360, 100, 100);
      fill(frameCount*3%360, 100, 100);
      circle(center.x, center.y, chamberRad);
      colorMode(RGB, 255, 255, 255);
    }
  }
}
