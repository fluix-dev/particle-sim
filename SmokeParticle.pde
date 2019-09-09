class SmokeParticle extends Particle {  
  SmokeParticle(int x, int y, int xVel, int yVel) {
    super(x, y, xVel, yVel, color(random(200, 255), random(200, 255), random(200, 255), 100));
  }

  void update() {
    //Remove all references to the particle so the garbage collector removes it
    if (y < 0) {
      for (int i = 0; i < particleList.size(); i ++) {
        if (particleList.get(i).x == x && particleList.get(i).y == y+1) {
          particleList.remove(i);
          return;
        }
      }
    }
  
    //Sometimes move upwards
    if (random(100) < 25) {
      y-=1;
      //If moved up, sometimes move sideways
      if (random(100) < 25) {
        if (random(100) < 50) {
          x-=1;
        } else {
          x+=1;
        }
      }
    }
    
    //Sometimes remove the particle
    if (random(100) < 1) {
      y = -10;
    }
  }
}
