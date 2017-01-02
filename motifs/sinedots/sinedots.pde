/** 
* Processing program to generate a sine curve with circles hugging the curve at the
* top and bottom.
*/
void setup() {
  size(790, 200);

  float a = PI/2;
  float inc = TWO_PI/25.0;

  noFill();
  strokeWeight(15);
  beginShape();
  for (int i = 10; i < 780; i=i+15) {
    float y = 100+sin(a)*40.0;
    vertex(i, y);
    a += inc;
  }
  endShape();

  fill(0);
  strokeWeight(1);
  a = PI/2;
  ellipseMode(CENTER);
  for (int i = 10; i < 780; i=i+15) {
    float y = 100+sin(a)*40.0;
    ellipse(i, y-22, 12, 12);
    ellipse(i, y+22, 12, 12);
    a += inc;
  }
}