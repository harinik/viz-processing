/**
* Notes are placed as small circles randomly on the canvas.
* A curve connects notes in the same line. 
* Example: http://www.harinik.com/Portfolio/Musical-Art/i-MHbNVbj/A
*/
void renderRandomCurves(Composition comp) {
  background(255);
  drawRect(0, 0, width, height, 255);
  for (int l = 0; l < comp.compLines.length; l++) {
    beginShape();
    String[] notes = comp.compLines[l].split(" ");
    color base = color(random(255), random(255), random(255));
    for (String note : notes) {
      if (note == null || note.equals("")) {
        continue;
      }
      float x = random(width);
      float y = random(height);
      color col = getColorFromBase(base, nmap.get(note));
      drawCircle(x, y, 10, col, 255 /*alpha*/);
      drawCurve(x, y, base, 0 /*alpha*/);
    }
    endShape(CLOSE);
  }
}