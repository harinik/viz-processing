/**
* Displays the composition as a spiral starting from the center of the canvas
* and spreading outwards. Each circle represents a note and the tone represents
* its frequency (darker tones = lower frequency).
*/
void renderSpiral(Composition comp) {
  background(255);
  // number of notes
  final int nc = comp.compLines.length * comp.numBeats * 4;
  // draw the spiral first
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
      ellipse(getX(cx, n), getY(cy, n), 15, 15);
      n++;
    }
  }
}

// Returns the x coord on the spiral correspond to the note number.
float getX(int origX, int noteNum) {
  return origX + noteNum * 0.4 * cos(noteNum/3.0);
}

// Returns the y coord on the spiral correspond to the note number.
float getY(int origY, int noteNum) {
  return origY + noteNum * 0.4 * sin(noteNum/3.0);
}