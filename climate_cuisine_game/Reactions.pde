class Reactions {
  PVector center;
  String type;
  int chamberRad;
  boolean process;
  int count = 0;


  Reactions(float x, float y, String t, int r) {
    center = new PVector(x, y);
    type = t;
    chamberRad = r;
  }

  void display() {
    fill(255);
    circle(center.x, center.y, chamberRad);
    fill(0);
    textSize(12.5);

    if (center.x < width/2) {
      textAlign(RIGHT, CENTER);
      text(type + ": " + count, center.x - chamberRad/2 - 5, center.y);
    }
    if (center.x > width/2) {
      textAlign(LEFT, CENTER);
      text(type + ": " + count, center.x + chamberRad/2 + 5, center.y);
    }

    if (process) {
      colorMode(HSB, 360, 100, 100);
      fill(frameCount%360, 100, 100);
      circle(center.x, center.y, chamberRad);
      colorMode(RGB, 255, 255, 255);
    }
  }
}
