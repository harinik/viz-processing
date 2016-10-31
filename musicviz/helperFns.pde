/**
 * Helper functions to visualize compositions.
 */

void drawCircle(float x, float y, float d, color c, int alpha) {
  stroke(c);
  ellipseMode(CENTER);
  fill(c, alpha);
  ellipse(x, y, d, d);
}

void drawLine(float sx, float sy, float ex, float ey, color c) {
  stroke(c);
  strokeWeight(1);
  strokeCap(ROUND);
  line(sx, sy, ex, ey);
}

void drawRect(float x, float y, float w, float h, color c, int alpha) {
  fill(c, alpha);
  noStroke();
  rect(x, y, w, h);
}

void saveToFile(String outFile) {
  File f = new File(outFile);
  if (f.exists()) {
    f.delete();
  }
  save(outFile);
}

void drawCurve(float nextX, float nextY, color col, float alpha) {
  fill(col, alpha);
  stroke(col);
  curveVertex(nextX, nextY);
}

color getColorFromBase(color base, float mult) {
  return color(int(red(base) * mult), int(green(base) * mult), int(blue(base) * mult));
}