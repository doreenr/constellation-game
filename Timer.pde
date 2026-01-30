class Timer {
  int duration;
  int start;
  int remaining;
  boolean active;
  
  Timer(int duration) {
    this.duration = duration;
    this.active = false;
  }
  
  void start() {
    start = millis();
    active = true;
  }
  
  void update() {
    if (active) {
      int elapsed = (millis() - start) / 1000;
      remaining = duration - elapsed;
      if (remaining <= 0) {
        remaining = 0;
        active = false;
      }
    }
  }
  
  boolean isFinished() {
    return !active && remaining == 0;
  }
  
  void display(float x, float y) {
    fill(255);
    textAlign(RIGHT);
    textSize(12);
    text("Time: " + remaining + "s", x, y);
  }
}
