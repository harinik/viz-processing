/**
 * Generates visualization of the melakarta ragas as a grid of 36 circles,
 * each representing two ragas that differ by a note.
 * Each slice within the circle is a note.
 * Example: http://www.harinik.com/Portfolio/Musical-Art/i-2h36RJQ/A
 */
void generateTriangles(List<String> ragas, color base) {
  background(50);
  final int rg = 6;
  final float sqw = width / (rg + 1);
  final float sqh = height / (rg + 1);
  float x = sqw;
  float y = sqh;

  for (int i = 0; i < ragas.size(); i++) {
    noStroke();
    String[] notes = ragas.get(i).split(" ");
    float theta = 0;
    for (int j = 0; j < notes.length; j++) {
      float end;
      float c = cmap.get(notes[j]);
      color col = color(int(red(base) * c), int(green(base) * c), int(blue(base) * c));
      fill(col);
      if (j / 8 >= 1) {
        // go counter clockwise for the second raga.
        if (j == 8) {
          theta = 2 * PI;
        }
        end = theta - (PI / 8);
      } else {
        end = theta + (PI / 8);
      }
      float vx1 = x + sqw/2 * cos(theta);
      float vy1 = y + sqw/2 * sin(theta);
      float vx2 = x + sqw/2 * cos(end);
      float vy2 = y + sqw/2 * sin(end);
      triangle(x, y, vx1, vy1, vx2, vy2);
      theta = end;
    }

    // move to the next line for the next 6.
    if ((i+1) % 6 == 0) {
      x = sqw;
      y += sqw;
    } else {
      x += sqw;
    }
  }
}