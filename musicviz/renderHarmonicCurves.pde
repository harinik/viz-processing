/**
* Displays the composition as a harmonic curve starting from the center of the canvas
* and spreading outwards. Each circle represents a note and the tone represents
* its frequency (darker tones = lower frequency).
*/
void renderHarmonicCurves(Composition comp) {
  background(255);
  // number of notes
  final int nc = comp.compLines.length * comp.numBeats * 4;
  // draw the curve first
  color base = color(random(255), random(255), random(255));
  stroke(color(255 - red(base), 255 - green(base), 255 - blue(base)));
  beginShape();
  int l = 0;
  final int cx = width /2 ;
  final int cy = height / 2;
  while (l < nc + 1) {
    noFill();
    curveVertex(getX(cx, l), getY(cy, l));
    l++;
  }
  endShape(); 

  // draw the circles representing the notes
  int n = 0;
  for (int j = 0; j < comp.compLines.length; j++) {
    String[] notes = comp.compLines[j].split(" ");
    for (String note : notes) {
      if (note == null || note.equals("")) {
        continue;
      }
      color col = getColorFromBase(base, nmap.get(note));
      ellipseMode(CENTER);
      stroke(col);
      fill(col);
      ellipse(getX(cx, n), getY(cy, n), 10, 10);
      n++;
    }
  }
}

// Helper functions to calculate x and y.
// x and y are calculated using this formula:
//  x = originX + c1 * sin(t1)
//  y = originY + c2 * cos(t2)
//  c1 and c2 controls the "spread" along the X-axis and Y-axis respectively.
// (This also makes use of the noteNum and canvas size to try and constrain the image to the
// boundaries of the canvas)
//  t1 & t2 control the form of the generated curve and how close together 
// the points on the generated curve are. They are functions of noteNum.
// Example values of c1 and c2: 0.6 * noteNum * height/width and 0.4 * noteNum * height/width.
// Example values of t1 and t2: 
// t1 = noteNum/k, t2 = noteNum/k - spiral.
// t1 = noteNum/2k, t2 = noteNum/k - parabola-like curves.
// t1 = noteNum/3k, t2 = noteNum/k - some sort of harmonic curves.
// t1 = noteNum/4k, t2 = noteNum/k - more complex parabola-like curves.
// t1 = noteNum/k, t2 = noteNum/2k - cone-like curve.
// The higher the k above, the closer together points will be.
// Also, switching the sin(t1) and cos(t2) between x and y changes the orientation
// of the image.

// Returns the x coord on the spiral correspond to the note number.
float getX(int origX, int noteNum) {
  return origX + 0.6 * noteNum * (height / (float) width) * sin(noteNum/10.0);
}

// Returns the y coord on the spiral correspond to the note number.
float getY(int origY, int noteNum) {
  return origY + 0.4 * noteNum * (height / (float) width) * cos(noteNum/4.0);
}