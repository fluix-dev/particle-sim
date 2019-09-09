//The particle size as used for array size and drawing
final int PARTICLESIZE=3;

//All current information about the game in general
String type = "Sand";
String state = "Splash0";
PImage splashImage;

//List of particles and buttons
ArrayList<Particle> particleList = new ArrayList<Particle>();
ArrayList<Button> buttonList = new ArrayList<Button>();

//Array of particle locations for collision checks stored simply as their colours
int[][] particleArray;

void setup() {
  //set size, framrate, and initialize some values  
  size(1000, 800);
  frameRate(70);
  splashImage = loadImage("bg.jpg");
  particleArray = new int[int(width/PARTICLESIZE)][int(height/PARTICLESIZE)];
  createButtons();
}

void createButtons() {
  //Add buttons 
  buttonList.add(new MainMenuButton(-5, 200, width+10, 100, "Instructions"));
  buttonList.add(new MainMenuButton(-5, 400, width+10, 100, "Game"));
  buttonList.add(new MainMenuButton(-5, 600, width+10, 100, "Exit"));
  buttonList.add(new MainMenuButton(-5, 710, width/2, 100, "Back"));
  buttonList.add(new MainMenuButton(width/2, 710, width/2+5, 100, "Quit"));

  buttonList.add(new Button(-4 + width/6 * 0, -6, width/6, height/7, "Sand", loadImage("sand.png")));
  buttonList.add(new Button(-4 + width/6 * 1, -6, width/6, height/7, "Water", loadImage("water.png")));
  buttonList.add(new Button(-4 + width/6 * 2, -6, width/6, height/7, "Grass", loadImage("grass.png")));
  buttonList.add(new Button(-4 + width/6 * 3, -6, width/6, height/7, "Lava", loadImage("lava.png")));
  buttonList.add(new Button(-4 + width/6 * 4, -6, width/6, height/7, "Clear", loadImage("empty.png")));
  buttonList.add(new MainMenuButton(-4 + width/6 * 5, -6, width/6 + 8, height/7, "Main Menu"));
}

void title() {
  textSize(64);  
  textAlign(CENTER);
  text("Particle Simulator", width/2, 64);
}

void draw() {
  //Clear background
  background(splashImage);
  noStroke();
  fill(30, 30, 30, 99);
  rect(0, 0, width, height);
  fill(255, 255, 255, 255);

  //Check different states
  if (state == "Game") {
    background(50);
    //User input - Create particles
    if (mousePressed) {
      createParticles(mouseX, mouseY, 4);
    }
    display();
  } else if (state.startsWith("Splash")) {
    splashScreen();
    title();
    introduction();
  } else if (state == "Main Menu") {
    buttonList.get(0).drawButton();
    buttonList.get(0).checkCollisions();
    buttonList.get(1).drawButton();
    buttonList.get(1).checkCollisions();
    buttonList.get(2).drawButton();
    buttonList.get(2).checkCollisions();
  } else if (state == "Instructions") {
    title();
    textSize(32);
    textFont(loadFont("CourierNewPSMT-48.vlw"));
    text("To change particle type, click\non the particle you want, at the\ntop of the screen. To place\ndown particles, left click.\nTo clear particles, press\nClear, and to exit to main\nmenu, press Main Menu.", width/2, height/3);
    buttonList.get(3).drawButton();
    buttonList.get(3).checkCollisions();
  } else if (state == "Exit") {
    title();
    textSize(32);
    textFont(loadFont("CourierNewPSMT-48.vlw"));
    text("Thanks for playing the particle\nsimulator by TheAvidDev.\nI hope you enjoyed.", width/2, height/3);
    buttonList.get(3).drawButton();
    buttonList.get(3).checkCollisions();
    buttonList.get(4).drawButton();
    buttonList.get(4).checkCollisions();
  }
}

void splashScreen() {
  //Increment number at the end for condition later on
  state = "Splash" + (Float.parseFloat(state.substring(6))+2);

  //Fade in
  if (Float.parseFloat(state.substring(6)) < 100) {
    noStroke();
    fill(30, 30, 30, Float.parseFloat(state.substring(6)));
    rect(0, 0, width, height);
    fill(255, 255, 255, Float.parseFloat(state.substring(6))*3);
  } 
  //Solid
  else if (Float.parseFloat(state.substring(6)) < 500) {
    noStroke();
    fill(30, 30, 30, 99);
    rect(0, 0, width, height);
    fill(255, 255, 255, 255);
  }
  //Fade out
  else if (Float.parseFloat(state.substring(6)) < 600) {
    noStroke();
    fill(30, 30, 30, 90-(Float.parseFloat(state.substring(6))-500));
    rect(0, 0, width, height);
    fill(255, 255, 255, 255-(Float.parseFloat(state.substring(6))-500)*3);
  } 
  //Done fading out and went to main menu
  else {
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
  }
}

void introduction() {
  textSize(32);
  textFont(loadFont("CourierNewPSMT-48.vlw"));
  text("Welcome to the particle simulator\napplication. It allows you to\nplace down particles on the\nscreen and watch their\ninteractions.\n~Enjoy!\n\nPress any button to continue.", width/2, height/3);
}

void display() {
  //Draw and update the particles
  for (int i = 0; i < particleList.size(); i ++) {
    particleList.get(i).drawParticle();
    particleList.get(i).update();
  }

  //Draw and check buttons
  for (int i = 5; i < buttonList.size(); i ++) {
    buttonList.get(i).drawButton();
    buttonList.get(i).checkCollisions();
  }

  //Black border on everything
  fill(0, 0, 0, 0);
  stroke(0);
  strokeWeight(10);
  rect(0, -1, width, height);
}

void createParticles(float xPos, float yPos, int spread) {
  //Set two variables to the x and y of to-be-created particle
  int spawnX, spawnY;
  spawnX = int(xPos/PARTICLESIZE-xPos%PARTICLESIZE) + int(random(-spread, spread));
  spawnY = int(yPos/PARTICLESIZE-yPos%PARTICLESIZE) + int(random(-spread, spread));

  //I1f mouse off-screen, don't create particles
  if (spawnX < 2 || spawnX > int(width/PARTICLESIZE)-2 || spawnY < int(height/7/PARTICLESIZE) || spawnY > int(height/PARTICLESIZE)-2) {
    return;
  }
  //If creating particles in particles, don't
  if (particleArray[spawnX][spawnY] != 0) {
    return;
  }

  //Create the particle
  Particle newParticle = null;
  if (type == "Sand")
    newParticle = new SandParticle(spawnX, spawnY, 0, 2);
  else if (type =="Water")
    newParticle = new WaterParticle(spawnX, spawnY, 1, 2);
  else if (type == "Grass") 
    newParticle = new GrassParticle(spawnX, spawnY, 0, 1);
  else if (type == "Lava") 
    newParticle = new LavaParticle(spawnX, spawnY, 1, 1);

  //Add it to the list
  particleList.add(newParticle);
}

//Skip splash screen
void keyPressed() {
  if (state.startsWith("Splash")) {
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
  }
}
