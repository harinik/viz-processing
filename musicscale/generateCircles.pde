/**
* Represents the melakartas in a circle.
* Notes are placed along the diameter of a large circle, representing two ragas
* differing in one note (M). 
* Example: http://www.harinik.com/Portfolio/Musical-Art/i-wX9DqwX/A
*/
void generateCircles(List<String> ragas, color base) {
  background(base);
  float cx = width/2;
  float cy = height/2;
  float r = width/2;
  float sz = Float.parseFloat(nf((width/15.0), 3, 2));
  println(sz);
  fill(base);
  ellipse(cx, cy, 2*r, 2*r);
  float theta = 0;
  for (String line : ragas) {
    float startx = cx + r * cos(theta);
    float starty = cy + r * sin(theta);
    float endx = cx + r * cos(PI + theta);
    float endy = cy + r * sin(PI + theta);
    float d = 0;
    float m = (endy - starty) / (endx - startx);

    String[] notes = line.split(" ");
    for (String note : notes) {
      float nx = startx;
      float ny = startx;
      float offset = d / sqrt(1+m*m);
      if (startx < endx) {
        nx = startx + offset;
        ny = starty + m * offset;
      } else {
        nx = startx - offset; 
        ny = starty - m * offset;
      }
      float c = cmap.get(note);
      color col = color(int(red(base) * c), int(green(base) * c), int(blue(base) * c));
      fill(col);
      noStroke();
      ellipseMode(CENTER);
      ellipse(nx, ny, sz, sz);
      d = d + sz;
    }
    theta = theta + PI/36;
  }
}