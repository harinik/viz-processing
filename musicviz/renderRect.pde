/**
* Displays the composition as a grid of rectangles. Each small rectangle represents a note,
* with the tone indicating the frequency. The darker the tone, the lower the frequency.
* The grid can be display with withGradient set to true, to display gradients within
* each rectangle representing the note.
* The size of the resulting image in indicative of its complexity. The width is dependent 
* on the number of beats of the composition and the height represents the number of lines.
* Example: http://www.harinik.com/Portfolio/Musical-Art/i-F6GK2M2/A
*/
void renderRect(Composition comp, boolean withGradient) { 
  background(128);
  final int steps = 4;
  float x = 0, y = 0;
  color base = color(255);
  color prevCol = 0;
  float xstep = width / (float) comp.numBeats;
  float ystep = height / (float) comp.compLines.length;
  for (int l = 0; l < comp.compLines.length; l++) {
    String[] cs = comp.compLines[l].split(" ");
    for (String c : cs) {
      if (c == null || c.equals("")) {
        continue;
      }
      color col = getColorFromBase(base, nmap.get(c));
      if (withGradient) {
        if (prevCol == 0) {
          prevCol = col;
        }
        for (int i = 0; i < steps; i++) {
          float t = map(i, 0, steps, 0.0, 1.0);
          color intCol = lerpColor(prevCol, col, t);
          drawRect(x, y, (xstep/steps), ystep, intCol, 128);
          prevCol = intCol;
          x = x + (xstep/steps);
        }
      } else {
        drawRect(x, y, xstep, ystep, col, 255);
        x = x + xstep;
      }
    }
    x = 0;
    y = y + ystep;
  }
}