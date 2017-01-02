/**
* Processing program to generate a set of concentric diamond shapes.
*/
void setup() {
  size(640, 640);

  float cx = width/2;
  float cy = height/2;

  noFill();
  strokeWeight(20);
  float offset = 200;
  for (int i = 4; i > 0; i--) {
    if (i == 1) {
      fill(0); 
    }
    beginShape();
    vertex(cx - offset, cy);
    vertex(cx, cy + offset);
    vertex(cx + offset, cy);
    vertex(cx, cy - offset);
    endShape(CLOSE);
    offset -= 50;
  }
}