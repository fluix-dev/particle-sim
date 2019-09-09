class GrassParticle extends Particle {  
  GrassParticle(int x, int y, int xVel, int yVel) {
    super(x, y, xVel, yVel, color(random(0, 30), random(225, 255), random(0, 30)));
  }

  void update() {
    super.update();

    //If a certain random chance occurs, the particle may move to the right or left as if "floating"
    if (hasMoved) {
      int rand = int(random(30));
      if (rand < 5) {
        if (particleArray[x+1][y] == 0) {
          particleArray[x][y] = 0;
          particleArray[x+1][y] = col;
          x++;
        }
      } else if (rand < 10) {
        if (particleArray[x-1][y] == 0) {
          particleArray[x][y] = 0;
          particleArray[x-1][y] = col;
          x--;
        }
      } else {
        //Do nothing because
        //the algorithm
        //doesn't allow it
      }
    } else {
      //If falling on top of water or lava, remove itself
      if (particleArray[x][y+1] == color(0, 0, 255) || particleArray[x][y+1] == color(255, 100, 0)) {
        for (int i = 0; i < particleList.size(); i ++) {
          if (particleList.get(i).x == x && particleList.get(i).y == y) {
            particleArray[x][y] = 0;
            particleList.remove(i);
            break;
          }
        }
      }
    }
    
    //If lava is around, remove
    for (int a = -1; a < 2; a++) {
      for (int b = -1; b < 2; b++) {
        if (particleArray[x+a][y+b] == color(255, 100, 0)) {
          for (int i = 0; i < particleList.size(); i ++) {
            if (particleList.get(i).x == x && particleList.get(i).y == y) {
              particleArray[x][y] = 0;
              particleList.remove(i);
              break;
            }
          }
          particleList.add(new SmokeParticle(x, y, 1, 1));
        }
      }
    }
  }
}
