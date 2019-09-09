class MainMenuButton extends Button {
  MainMenuButton(int _x, int _y, int _bWidth, int _bHeight, String _switchType) {
    super(_x, _y, _bWidth, _bHeight, _switchType,loadImage("empty.png"));
  }
  
  //Modification of the Button's onClick() method
  void onClick() {
    if (switchType == "Continue" || switchType == "Back" || switchType == "Main Menu") {
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
      state = "Main Menu";
    } else if (switchType == "Quit") {
      exit();
    } else {
      state = switchType;
    }
  }
}
