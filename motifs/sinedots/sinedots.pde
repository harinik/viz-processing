/** 
 * Processing program to generate a sine curve with circles hugging the curve at the
 * top and bottom.
 */
void setup() {
  size(790, 200);

  float a = PI/2;
  float inc = TWO_PI/25.0;

  // generate the sine curves parallel to each other
  noFill();
  stroke(255, 0, 0);
  int i = 0, j = 0;
  float y = 0;
  for (j = 90; j < 120; j += 20) {
    a = PI/2;
    beginShape();

    for (i = 10; i < 780; i=i+15) {
      y = j+sin(a)*40.0;
      vertex(i, y);
      a += inc;
    }
    endShape();
  }
  // connect the two sine curves with a line.
  line(10, 130, 10, 150);
  line(i - 15, y - 20, i - 15, y);  

  // generate dots hugging the curve above and below
  noFill();
  strokeWeight(1);
  a = PI/2;
  ellipseMode(CENTER);
  for (i = 10; i < 780; i=i+15) {
    y = 100+sin(a)*40.0;
    ellipse(i, y-25, 12, 12);
    ellipse(i, y+25, 12, 12);
    a += inc;
  }
}