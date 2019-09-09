class Particle {
  int x, y, xVel, yVel, col;
  boolean hasMoved = true;

  Particle(int _x, int _y, int _xVel, int _yVel, int _col) {
    x = _x;
    y = _y;
    xVel = _xVel;
    yVel = _yVel;
    col = _col;
  }

  void update() {
    hasMoved = false;
    //Atempt to move one down, then two down, and so on, until yVel.
    //This removes the possibility of going through tiles when falling,
    //but allows for movement less than or eqaul to yVel.
    for (int i = 0; i < yVel; i ++) {
      //If tile below is empty
      if (particleArray[x][y+1] == 0) {
        particleArray[x][y] = 0;
        particleArray[x][y+1] = col;      
        y += 1;
        hasMoved = true;
      }
    }

    //If the particle hasn't moved, try to pile up
    if (!hasMoved) {    
      if (particleArray[x+1][y+1] == 0) {
        particleArray[x][y] = 0;
        particleArray[++x][++y] = col;
      } else if (particleArray[x-1][y+1] == 0) {
        particleArray[x][y] = 0;
        particleArray[--x][++y] = col;
      } else {
        //No else statement is required
        //because the situation does not
        //allow for it.
      }
    }
  }

  void drawParticle() {
    //Draw the particles with rectangles based off of 
    fill(col);
    noStroke();
    rect(x*PARTICLESIZE-PARTICLESIZE/2, y*PARTICLESIZE-PARTICLESIZE/2, PARTICLESIZE, PARTICLESIZE);
  }
}
