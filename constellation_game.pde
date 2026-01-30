Star[] stars;
ArrayList<Star> selected = new ArrayList<Star>();
ArrayList<ArrayList<Star>> saved = new ArrayList<ArrayList<Star>>();
int total = 1500;

float offsetX = 0;
float offsetY = 0;
float speed = 0.8;
float skyW = 5000;
float skyH = 3000;

GameManager game;

void setup() {
  size(500, 500);
  game = new GameManager();
  initStars();
}

void initStars() {
  stars = new Star[total];
  for (int i = 0; i < total; i++) { 
    stars[i] = new Star(random(skyW), random(skyH), random(2, 6), i);
  }
}

void resetGame() {
  initStars();
  selected.clear();
  saved.clear();
  offsetX = 0;
  offsetY = 0;
  game.startGame();
}

void draw() {
  background(10, 10, 30);
  
  if (!game.active && !game.over) {
    game.displayStart();
  } else if (game.over) {
    game.displayEnd();
  } else {
    game.update();
    play();
    game.displayHUD();
  }
}

void play() {
  float p = game.timer.progress();          // 0..1 over the whole game
  float eased = p * p * (3 - 2 * p);        // smoothstep
  float currentSpeed = lerp(0.2, 1, eased);  // start 0, end 0.8 (tune end value)

  offsetX += currentSpeed;
  offsetY += currentSpeed * 0.3;
  
  if (selected.size() > 0) {
    for (Star s : selected) {
      if (touchingEdge(s)) {
        for (Star st : selected) st.unselect();
        selected.clear();
        break;
      }
    }
  }
  
  for (int i = saved.size() - 1; i >= 0; i--) {
    boolean allOut = true;
    for (Star s : saved.get(i)) {
      if (s.isVisible(offsetX, offsetY)) {
        allOut = false;
        break;
      }
    }
    if (allOut) saved.remove(i);
  }
  
  for (int i = 0; i < total; i++) {
    stars[i].display(offsetX, offsetY);
  }
  
  stroke(255);
  strokeWeight(2);
  for (ArrayList<Star> c : saved) {
    for (int i = 0; i < c.size() - 1; i++) {
      Star s1 = c.get(i);
      Star s2 = c.get(i + 1);
      line(s1.x - offsetX, s1.y - offsetY, s2.x - offsetX, s2.y - offsetY);
    }
  }
  
  stroke(255);
  strokeWeight(2);
  for (int i = 0; i < selected.size() - 1; i++) {
    Star s1 = selected.get(i);
    Star s2 = selected.get(i + 1);
    line(s1.x - offsetX, s1.y - offsetY, s2.x - offsetX, s2.y - offsetY);
  }
}

boolean touchingEdge(Star s) {
  float sx = s.x - offsetX;
  float sy = s.y - offsetY;
  return sx <= 0 || sx >= width || sy <= 0 || sy >= height;
}

void mousePressed() {
  if (!game.active && game.buttonClicked(mouseX, mouseY)) {
    resetGame();
    return;
  }
  
  if (game.active) {
    for (int i = 0; i < total; i++) {
      if (stars[i].isMouseOver(mouseX, mouseY, offsetX, offsetY) && 
          !stars[i].selected && stars[i].isVisible(offsetX, offsetY)) {
        stars[i].select();
        selected.add(stars[i]);
        break;
      }
    }
  }
}

void keyPressed() {
  if (!game.active) return;
  
  if (key == 'r' || key == 'R') {
    for (Star s : selected) s.unselect();
    selected.clear();
  }
  
  if (key == ENTER || key == RETURN) {
    if (selected.size() >= 2) {
      game.addPoints(selected.size());
      saved.add(new ArrayList<Star>(selected));
      selected.clear();
    }
  }
  
  if (key == ' ') {
    speed = (speed == 0) ? 0.8 : 0;
  }
}
