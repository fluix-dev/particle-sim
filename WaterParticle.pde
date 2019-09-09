class WaterParticle extends Particle {
  //An additional variable that doesn't exist in Particle
  boolean moveRight;

  WaterParticle(int x, int y, int xVel, int yVel) {
    super(x, y, xVel, yVel, color(0, 0, 255));
  }


  void update() {
    super.update();

    //If the particle hasn't moved, start flowing
    if (!hasMoved) {
      if (moveRight) {
        if (particleArray[x+1][y] == 0) {
          particleArray[x][y] = 0;
          particleArray[x+1][y] = col;
          x+=xVel;
        } else if (particleArray[x-1][y] == 0) {
          moveRight = false;
        }
      } else {
        if (particleArray[x-1][y] == 0) { 
          particleArray[x][y] = 0;
          particleArray[x-1][y] = col;
          x-=xVel;
        } else if (particleArray[x+1][y] == 0) {
          moveRight = true;
        }
      }
    }
  }
}
