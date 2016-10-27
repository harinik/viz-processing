/**
* Displays the composition with a curve for each line of the composition.
* @param ystart is the y coordinate for the first line.
* @param yband is the height of the band used to represent each line. 
* Examples are here:
* -- when yband = height: * http://www.harinik.com/Portfolio/Musical-Art/i-DDXzKBQ/A
* -- when yband = height / compostion length: http://www.harinik.com/Portfolio/Musical-Art/i-pS4V9nz/A
*/
void renderCurves(Composition comp, float ystart, float yband) {
  background(0);
  final float xband = width / (comp.numBeats * 4.0);
  float x = xband/2.0, y = 0;

  for (int l = 0; l < comp.compLines.length; l++) {
    color col = color(random(255), random(255), random(255));
    String[] cs = comp.compLines[l].split(" ");
    noFill();
    beginShape();
    for (int j = 1; j < cs.length; j++) {
      String c = cs[j];
      if (c == null || c.equals("")) {
        continue;
      }
      float val = nmap.get(c);
      float t = map(val, 0, 1, ystart, ystart + yband);
      y = 2 * ystart + yband - t;    
      drawCurve(x, y, col, 0);
      if (j == 1) {
        drawCurve(x, y, col, 0);
      }
      // draw circle for each note 
      drawCircle(x, y, 1, 128, 255);
      x = x + xband;
    }
    drawCurve(x, y, col, 0 /*alpha*/);
    endShape();
    x = xband/2.0;
    if (yband != height) {
      ystart = ystart + yband;
    }
    
    stroke(20);
    line(0, ystart, width, ystart);
  }
}