class GameManager {
  boolean active;
  boolean over;
  int points;
  Timer timer;
  
  GameManager() {
    active = false;
    over = false;
    points = 0;
    timer = new Timer(30);
  }
  
  void startGame() {
    active = true;
    over = false;
    points = 0;
    timer.start();
  }
  
  void update() {
    if (active) {
      timer.update();
      if (timer.isFinished()) {
        active = false;
        over = true;
      }
    }
  }
  
  void addPoints(int num) {
    int earned = calc(num);
    points += earned;
  }
  
  int calc(int num) {
    switch(num) {
      case 2: return 40;
      case 3: return 90;
      case 4: return 160;
      case 5: return 250;
      case 6: return 360;
      case 7: return 490;
      case 8: return 640;
      case 9: return 810;
      case 10: return 1000;
      default: return 0;
    }
  }
  
  void displayHUD() {
    timer.display(width - 10, 20);
    fill(255);
    textAlign(RIGHT);
    textSize(12);
    text("Points: " + points, width - 10, 35);
    
    textAlign(LEFT);
    textSize(12);
    text("Press Enter to save constellation", 10, height - 30);
    text("Press R to reset", 10, height - 15);
  }
  
  void displayStart() {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Star Connector", width/2, height/2 - 50);
    
    textSize(16);
    text("Connect stars to form constellations", width/2, height/2);
    text("You have 30 seconds!", width/2, height/2 + 30);
    
    noStroke();
    fill(200, 50, 50);
    rect(width/2 - 75, height/2 + 80, 150, 50, 10);
    fill(255);
    textSize(20);
    text("Start Game", width/2, height/2 + 105);
  }
  
  void displayEnd() {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Game Over!", width/2, height/2 - 50);
    
    textSize(24);
    text("Final Score: " + points, width/2, height/2);
    
    noStroke();
    fill(200, 50, 50);
    rect(width/2 - 75, height/2 + 80, 150, 50, 10);
    fill(255);
    textSize(20);
    text("Start Again", width/2, height/2 + 105);
  }
  
  boolean buttonClicked(float mx, float my) {
    return mx > width/2 - 75 && mx < width/2 + 75 && 
           my > height/2 + 80 && my < height/2 + 130;
  }
}
