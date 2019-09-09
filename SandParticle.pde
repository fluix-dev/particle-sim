class SandParticle extends Particle {  
  SandParticle(int x, int y, int xVel, int yVel) {
    super(x, y, xVel, yVel, color(255, random(220, 255), 0));
  }

  void update() {
    super.update();

    //Broken water-collision detection and updating
    if (!hasMoved) {
      if (particleArray[x][y+1] == color(0, 0, 255)) {
        col = color(random(80, 100), random(55, 75), random(10, 30));
        //col = color(90, 65, 20);
        particleArray[x][y+1] = col;
        particleArray[x][y] = color(0, 0, 255);
        for (int i = 0; i < particleList.size(); i ++) {
          if (particleList.get(i).x == x && particleList.get(i).y == y+1) {
            particleList.get(i).y -= 1;
            break;
          }
        }
        y+=1;
      }
    }

    //If water is around, turn to mud
    for (int a = -1; a < 2; a++) {
      for (int b = -1; b < 2; b++) {
        if (particleArray[x+a][y+b] == color(0, 0, 255)) {
          col = color(random(80, 100), random(55, 75), random(10, 30));
        }
      }
    }
  }
}
