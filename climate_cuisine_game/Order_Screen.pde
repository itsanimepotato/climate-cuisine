boolean active = true;
boolean replace = false;

int placementX, placementY, newPerson;
void orderScreen() {
  if (currentScreen == 1) {
    background(255);
    navBar("Order Screen");

    orderTicketAndLevels();
    if (replace) {
      replace(placementX, 0, newPerson);
    }
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


  orderChara(int(topX+ticketWidth/2), int(topY+ticketHeight/2)+50);
  orderBubble(int(topX), int(topY)+100, int(ticketWidth), person);
  orderSend(int(topX), int(topY)+375, int(ticketWidth), person);
}


void orderChara(int x, int y) {
  fill(255, 0, 0);
  rect(x - 25, y - 50, 50, 100);
  rect(x - 50, y - 25, 25, 50);
  rect(x - 15, y + 50, 15, 25);
  rect(x + 5, y + 50, 15, 25);
  fill(0, 255, 255);
  square(x+10, y-40, 25);
}

void orderBubble(int x, int y, int w, int type) {
  fill(128);
  rect(x+25, y, w*0.8, 100);

  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Hey, I want " + materialCreatedNames[type], x+25 + w*0.4, y+50);
  textSize(15);
  text(buyerReason[type], x+25 + w*0.4, y+75);

  if (type == 4) {
    textAlign(LEFT, CENTER);
    textSize(10);
    text("Sorry I didn't have any short sentences for uses of chalk", x + 10, y+110);
  }
}

void orderSend(int x, int y, int w, int type) {
  fill(#1B17BC);
  rect(x+25, y, w*0.8, 50, 10);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Send me " + materialCreatedNames[type], x+25 + w*0.4, y+20);

  if (materialCreated[type] >= 1 && active && click && withinBorder(x+25, y, x+25+int(w*0.8), y+50)) {
    int prevPerson = type;
    int person = int(random(1, buyers.length));

    while (person == prevPerson) {
      person = int(random(1, buyers.length));
    }
    replace = true;
    placementX = x;
    placementY = y;
    newPerson = person;
    
    materialCreated[type]--;
  }
}

boolean withinBorder(int tx, int ty, int bx, int by) {
  if (mouseX >= tx && mouseX <= bx) {
    if (mouseY >= ty && mouseY <= by) {
      return true;
    }
  }
  return false;
}

void replace(int x, int y, int person) {
  if (replace) {
    orderTicket(x, y, width/3, 0.9*height, person);
    
  }
}
