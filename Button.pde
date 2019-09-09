class Button {
  int x, y, bWidth, bHeight;
  PImage icon;
  String switchType;

  //The constructor of the button class
  Button(int _x, int _y, int _bWidth, int _bHeight, String _switchType, PImage _icon) {
    x = _x;
    y = _y;
    bWidth = _bWidth;
    bHeight = _bHeight;
    switchType=_switchType;
    icon = _icon;
  }

  void drawButton() {
    //Draw button
    stroke(0);
    strokeWeight(5);
    fill(203, 45, 62, 200);
    rect(x, y, bWidth, bHeight);

    if (switchType=="Sand"||switchType=="Water"||switchType=="Lava"||switchType=="Grass") {
      //Draw icon
      imageMode(CENTER);
      image(icon, x+bWidth/2, y+bHeight/2, 108, 108);
    } else {
      //Draw button text
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(30);
      text(switchType, x+bWidth/2, y+bHeight/2);
    }
  }

  void checkCollisions() {
    if (mouseX > x && mouseY > y && mouseX < x + bWidth && mouseY < y+bHeight) {
      //Slightly highlight the button
      fill(239, 71, 58, 100);
      rect(x, y, bWidth, bHeight);
      if (mousePressed) {
        onClick();
      }
    }
  }

  void onClick() {
    //Modify the type variable in the program
    if (switchType=="Clear") {
      //Clear all particles
      particleList = new ArrayList<Particle>();

      //Re-add border
      for (int x = 1; x < int(width/PARTICLESIZE); x ++) {
        for (int y = 1; y < int(height/PARTICLESIZE); y++) {
          if (y ==1 || y == int(height/PARTICLESIZE)-1 || x == 1 || x == int(width/PARTICLESIZE)-1) {
            particleArray[x][y] = 30;
          } else {
            particleArray[x][y] = 0;
          }
        }
      }
    } else if (switchType=="Main Menu\nWIP") {
      return;
    } else {
      type = switchType;
    }
  }
}
