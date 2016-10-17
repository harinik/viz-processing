/**
 * Processing sketch to visualize the 72 melakarta ragas in Carnatic music - this is
 * the foundation of Carnatic music and upon which all other compositions depend.
 * The code generates the notes for the melakarta ragas into a list of strings 
 * and the visualizations use this to render them.
 *
 * Author: Harini K (github.com/harinik)
 * Date: October 2016
 *
 * DISCLAIMER: I am relatively new to Processing and am primarily interested in the resulting
 * visualizations. So, some of this code may be ugly and repetitive but the visualizations themselves, 
 * not so much, I hope! :)
 */
import java.util.List;
HashMap<String, Float> cmap;

void setup() {
  size(640, 640);
  background(255);
  buildMap();
  final String outputFile = "melakarta-tri.jpg";
  List<String> ragas = generateRagas();
  File outFile = new File(sketchPath(outputFile));
  if (outFile.exists()) {
    outFile.delete();
  }

  float c = random(220, 255);
  color base = color(0, int(c), 0);
  // TODO: toggle these based on key pressed. For now, uncomment one of them.
  //generateRect(ragas, base, true);
  //generateCircles(ragas, base);

  generateTriangles(ragas, base);
}

// Store a map of the notes within an octave with their relative frequencies between 0 and 1.
void buildMap() {
  cmap = new HashMap<String, Float>();
  String[] notes = {"s", "R1", "R2", "R3", "G3", "M1", "M2", "P", "D1", "D2", "D3", "N3"};
  for (int i = 0; i < notes.length; i++) {
    float t = map(i, 0, notes.length, 0, 1);
    cmap.put(notes[i], t);
  }
  cmap.put("G1", cmap.get("R2"));
  cmap.put("G2", cmap.get("R3"));
  cmap.put("N1", cmap.get("D2"));
  cmap.put("N2", cmap.get("D3"));
  cmap.put("S", 1.0);
}

// Generate the melakarta ragas and return as a list of strings.
// TODO: clean up this code - I'm sure there is a nicer way of doing this.
// This table from the wikipedia entry for Melakarta ragas -
// https://en.wikipedia.org/wiki/Melakarta#Table_of_Melakarta_ragas
// explains how these are structured.
List<String> generateRagas() {
  List<String> ragas = new ArrayList<String>();
  // maximum number of variations of each note.
  final int maxNote = 3;
  int R = 1, G = 1;
  while (R <= maxNote) {
    G = R;
    while (G <= maxNote) {
      int D = 1, N = 1;
      while (D <= maxNote) {
        N = D;
        while (N <= maxNote) {
          // each string represents two ragas, varying only in the M note. The notes for the second (prati madhyama) raga
          // is written in descending order so we can get a nicer visualization.
          String s = "s R" + R + " G" + G + " M1 P D" + D + " N" + N + " S S N" + N + " D" + D + " P M2 G" + G + " R" + R + " s";
          ragas.add(s);
          N++;
        }
        D++;
      }
      G++;
    }
    R++;
  }
  return ragas;
}