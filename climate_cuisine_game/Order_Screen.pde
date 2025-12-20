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
