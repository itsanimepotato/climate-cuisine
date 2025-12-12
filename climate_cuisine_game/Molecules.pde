class Molecules {

  PVector position;
  int radius;
  color carbonColor;
  int movement = 5;

  Molecules(int x, int y, int r, int c) {
    position = new PVector(x, y);
    radius = r;
    carbonColor = c;
  }

  void move() {
    float randX = random(-movement, movement);
    float randY = random(-movement, movement);

    //println("before randcoords" + randX + " " + randY);

    if (wallCollision(position.x, randX, 1)) {
      randX = randX*-1;
    }
    if (wallCollision(position.y, randY, 2)) {
      randY = randY*-1;
    }

    //println("after randcoords" + randX + " " + randY);
    position.x = position.x + randX;
    position.y = position.y + randY;
  }

  boolean wallCollision(float mol, float rand, int axis) { // 1 = x, 2 = y

    if (axis == 1) {
      if (mol + rand > width - radius*3 || mol + rand < radius) {
        return true;
      }
    }
    if (axis == 2) {
      if (mol + rand > 0.9*height - radius || mol + rand < radius) {
        return true;
      }
    }

    return false;
  }

  void display() {
    fill(carbonColor);
    circle(position.x, position.y, radius);
    
    fill(255, 0, 0);
    circle(position.x - radius, position.y, radius);
    circle(position.x + radius, position.y, radius);
  }
}
