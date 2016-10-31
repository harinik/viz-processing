/**
 * Visualizes the composition in a series of concentric circles. 
 * Each concentric circle represents a line in the composition.
 * For an example, see: 
 * http://www.harinik.com/Portfolio/Musical-Art/i-kB3rjZQ/A
 */
void renderConcentricCircles(Composition comp) {
  background(255);
  float cx = width / 2;
  float cy = height / 2;
  // starting radius.
  float r = min(cx, cy) - 10;
  // dr indicates how much to change the radius for each line.
  float dr = r / comp.compLines.length;
  // choose a random base color
  color base = color(random(255), random(255), random(255));
  drawCircle(cx, cy, 2*r, base, 50 /*alpha*/);
  for (int l = 0; l < comp.compLines.length; l++) {
    drawCircle(cx, cy, 2*r, base, 0 /*alpha*/);
    float theta = PI;
    String[] notes = comp.compLines[l].split(" ");
    for (String note : notes) {
      if (note == null || note.equals("")) {
        continue;
      }
      // each note is represented as a little circle on the larger
      // circle.
      float nx = cx + r * cos(theta);
      float ny = cy + r * sin(theta);
      // calculate color of the note from the base color
      color col = getColorFromBase(base, nmap.get(note));
      drawCircle(nx, ny, 15, col, 255 /*alpha*/);
      theta = theta + (2 * PI) / (notes.length - 1);
    }
    // reduce the radius by dr for the next line.
    r = r - dr;
  }
}