/** Processing program to generate circles along concentric circles
*/
void setup() {
  size(640, 640);
  final float r = 30;
  final int numPoints = 5;
  for (float theta = 0; theta < 2 * PI - (PI/4); theta += PI/4) {
    float startX = width/2;
    float startY = height/2;
    stroke(255, 0, 0);
    noFill();
    float dist = 60;
    for (int i = 1; i < numPoints; i++) {
      float x = startX + dist * cos(theta);
      float y = startY + dist * sin(theta);
      ellipse(x, y, r, r);
      dist += 60;
    }
  }
  ellipse(width/2, height/2, r, r);
}