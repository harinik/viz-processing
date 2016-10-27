/**
* Notes on the scale are placed on a circle. A curve connects
* notes appearing in the same line in a composition.
* Example: http://www.harinik.com/Portfolio/Musical-Art/i-wNGNK95/A
*/
void renderNotesOnCircle(Composition comp) {
  background(0);
  float cx = width / 2;
  float cy = height / 2;
  float d = min(width, height);
  drawCircle(cx, cy, d, 255, 0 /*alpha*/);
  for (int l = 0; l < comp.compLines.length; l++) {
    String[] cs = comp.compLines[l].split(" ");
    color col = color(random(255), random(255), random(255));
    float x = 0, y = 0;
    noFill();
    beginShape();
    for (int j = 1; j < cs.length; j++) {
      String c = cs[j];
      if (c == null || c.equals("")) {
        continue;
      }
      float theta = thetamap.get(c);
      x = cx + (d/2) * cos(theta);
      y = cy + (d/2) * sin(theta);
      drawCurve(x, y, col, 20 /*alpha*/);
    }
    endShape();
  }

  // Draw a small circle for each note.
  for (Map.Entry<String, Float> e : thetamap.entrySet()) {
    float x = cx + (d/2) * cos(e.getValue());
    float y = cy + (d/2) * sin(e.getValue());
    float c = map(e.getValue(), 0, 2 * PI, 0, 255);
    drawCircle(x, y, 10, int(c), 255 /*alpha*/);    
  }
}