/**
* Processing program to generate diamonds oriented vertically, horizontally and
* diagonally.
*/
void setup() {
  size(640, 640);
  
  float cx = width/2;
  float cy = height/2;
  
  // draw diamonds along the regular x-y axes
  fill(0);
  // center
  diamond(cx, cy, 10, 20);
  // along X and Y axes
  diamond(cx, cy + 120, 30, 90);
  diamond(cx, cy - 120, 30, 90);
  diamond(cx + 120, cy, 90, 30);
  diamond(cx - 120, cy, 90, 30);
  
  // move the origin to the center and rotate the x-y axes by 45 degrees 
  // draw diamonds relative to the new orientation to get them diagonal
  translate(cx, cy);
  rotate(PI/4);
  diamond(0, 80, 15, 45);
  diamond(0, -80, 15, 45);
  diamond(80, 0, 45, 15);
  diamond(-80, 0, 45, 15);
}

// draw a diamond starting at (x, y) and having a width of xw along the X-axis
// and yw along the Y-axis.
void diamond(float x, float y, float xw, float yw) {
  beginShape();
  vertex(x - xw, y);
  vertex(x, y + yw);
  vertex(x + xw, y);
  vertex(x, y - yw);
  endShape();
}