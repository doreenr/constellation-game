class Star {
  float x;
  float y;
  float r;
  boolean selected;
  int index;
  
  Star(float x, float y, float r, int index) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.selected = false;
    this.index = index;
  }
  
  void display(float ox, float oy) {
    float sx = x - ox;
    float sy = y - oy;
    
    if (sx >= -20 && sx <= width + 20 && sy >= -20 && sy <= height + 20) {
      noStroke();
      fill(255);
      if (selected) {
        ellipse(sx, sy, r * 3, r * 3);
      } else {
        ellipse(sx, sy, r, r);
      }
    }
  }
  
  boolean isMouseOver(float mx, float my, float ox, float oy) {
    float sx = x - ox;
    float sy = y - oy;
    return dist(mx, my, sx, sy) <= max(r * 2, 15);
  }
  
  boolean isVisible(float ox, float oy) {
    float sx = x - ox;
    float sy = y - oy;
    return sx >= -20 && sx <= width + 20 && sy >= -20 && sy <= height + 20;
  }
  
  void select() {
    selected = true;
  }
  
  void unselect() {
    selected = false;
  }
}
