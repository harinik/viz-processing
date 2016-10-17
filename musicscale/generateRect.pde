/**
* Generates a visualization of the melakarta ragas as a rectangle.
* Each line represents two ragas, with each differing by exactly one note. 
* Each rectangle represents a note. The notes are in ascending order for the first raga 
* and in descending order for the 2nd raga. Optionally, a gradient can be used to make
* the transition between the notes smoother.
* Examples:
* http://www.harinik.com/Portfolio/Musical-Art/i-9kVsLsZ/A (no gradient)
* http://www.harinik.com/Portfolio/Musical-Art/i-HRxF2Hr/A (with gradient)
*/
void generateRect(List<String> ragas, color base, boolean withGradient) {
  int  y = 0, w = 40, ht = 20, steps = 10;
  for (String line : ragas) {
    color prevCol = 0;
    int x = 0;
    String[] notes = line.split(" ");
    for (String note : notes) {
      float c = cmap.get(note);
      color col = color(int(red(base) * c), int(green(base) *c), int(blue(base) * c));
      if (prevCol == 0) {
        prevCol = col;
      }
      rectMode(CORNER);
      noStroke();
          
      if (withGradient) {
        for (int i = 0; i < steps; i++) {
          float t = map(i, 0, steps, 0.0, 1.0);
          color intCol = lerpColor(prevCol, col, t);
          fill(intCol);
          rect(x, y, w/steps, ht);
          x = x + w/steps;
          prevCol = intCol;
        }
      } else {
        fill(col);
        rect(x, y, w, ht);
        x = x + w;
      }
    }
    y = y + ht;
  }
}