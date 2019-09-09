class LavaParticle extends Particle {  
  //An additional variable that doesn't exist in Particle
  boolean moveRight;

  LavaParticle(int x, int y, int xVel, int yVel) {
    super(x, y, xVel, yVel, color(255, 100, 0));
  }

  void update() {
    super.update();

    //If a certain random chance occurs, cancel the downwards movement in super.update();
    if (hasMoved) {
      if (int(random(30)) < 15) {
        particleArray[x][y] = 0;
        particleArray[x][y-1] = col;
        y--;
      }
    } else {
      //On a certain random chance, flow either to the right or to the left
      if (random(100) > 90) {
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

    //If water is below, turn to obsidian AND remove the water
    if (particleArray[x][y+1] == color(0, 0, 255)) {
      col = color(random(1, 20), random(1, 20), random(1, 20));
      particleArray[x][y+1] = col;
      particleArray[x][y] = 0;
      for (int i = 0; i < particleList.size(); i ++) {
        if (particleList.get(i).x == x && particleList.get(i).y == y+1) {
          particleList.remove(i);
          break;
        }
      }
      particleList.add(new SmokeParticle(x, y, 1,1));
      y+=1;
    } else {
      //If water is around, turn to obsidian
      if (particleArray[x][y+1] == color(0, 0, 255) ||
        particleArray[x+1][y] == color(0, 0, 255) ||
        particleArray[x-1][y] == color(0, 0, 255) ||
        particleArray[x][y-1] == color(0, 0, 255)) {
        col = color(random(10, 30), random(1, 20), random(1, 20));
      }
    }
  }
}
