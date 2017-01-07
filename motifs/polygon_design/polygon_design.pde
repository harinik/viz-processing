/**
* Generates a series of V shaped polygons.
* The code is written to generate a specific pattern like this:
* http://www.harinik.com/Portfolio/Experimentswork-in-progress-/i-bqhcjwc/A
* and is not meant to be very generalizable.
*/
void setup() {
  size(640, 640);

  float cx = width/2;
  float cy = height/2;
  final float w = 20;
  // starting radius of circle to determine the size of the polygon.
  float r = 200;
  float startX = cx;
  float startY = cy;

  stroke(255, 0, 0);
  noFill();
  // Generate the polygons from inner to outer edge.
  // polygon reduce in size as we move away from the center.
  // increment by 2 since each polygon has 2 points on the same axis.
  for (int i = 1; i < 6; i += 2) {
    float lx = r * cos(PI/4);
    float ly = r * sin(PI/4);

    // polygon moving along the +X axis
    startX = cx + i * w;
    beginShape();
    vertex(startX, cy);
    vertex(startX + lx, cy + ly);
    vertex(startX + lx, cy + ly - w);
    vertex(startX + w, cy);
    vertex(startX + lx, cy - ly + w);
    vertex(startX + lx, cy - ly);
    endShape(CLOSE);

    // polygon moving along the -X axis
    startX = cx - i * w;
    beginShape();
    vertex(startX, cy);
    vertex(startX - lx, cy + ly);
    vertex(startX - lx, cy + ly - w);
    vertex(startX - w, cy);
    vertex(startX - lx, cy - ly + w);
    vertex(startX - lx, cy - ly);
    endShape(CLOSE);

    // polygon moving along the +Y axis
    startY = cy + i * w;
    beginShape();
    vertex(cx, startY);
    vertex(cx + lx, startY + ly);
    vertex(cx + lx - w, startY + ly);
    vertex(cx, startY + w);
    vertex(cx - lx + w, startY + ly);
    vertex(cx - lx, startY + ly);
    endShape(CLOSE);

    // polygon moving along the -Y axis
    startY = cy - i * w;
    beginShape();
    vertex(cx, startY);
    vertex(cx + lx, startY - ly);
    vertex(cx + lx - w, startY - ly);
    vertex(cx, startY - w);
    vertex(cx - lx + w, startY - ly);
    vertex(cx - lx, startY - ly);
    endShape(CLOSE);

    // reduce the size for the next set of polygons
    r = r - 60;
  }
}