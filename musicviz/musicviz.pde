/**
 * Processing sketch to visualize an Indian classical music (Carnatic) composition.
 * The composition is represented as notes in a text file. 
 * There isn't really a standard notation for Carnatic music so I am using a format that is
 * specific to my purposes.  
 * 
 * Author: Harini K (github.com/harinik)
 * Date: October 2016
 *
 * DISCLAIMER: I am relatively new to Processing and am primarily interested in the resulting
 * visualizations. So, some of this code may be ugly and repetitive but the visualizations themselves, 
 * not so much, I hope! :)
 */
import java.util.Map;

/**
 * Class to represent a composition. 
 * Members include the file from which the notes are read, the number of beats and the lines 
 * in the composition. 
 */
class Composition {
  String compFileName;
  int numBeats;
  String[] compLines;

  Composition(String compFileName, int numBeats) {
    this.compFileName = compFileName;
    // Multiply by 4 since there are typically 4 notes per beat in Carnatic music.
    this.numBeats = numBeats * 4;
    parseComp();
  }

  /** Parses the notes for the composition from the file and populates the lines in the composition
   * in a format that the visualization code can render.
   * A line of the composition is expected to be in this format:
   * s , , , R2 , G3 M1 P D2 , , N3 , S , |
   * Notes are separated by spaces. A comma indicates that the previous note is repeated.
   * A | indicates the end of the segment or line.
   */
  void parseComp() {
    String[] lines = loadStrings(compFileName);
    compLines = new String[lines.length];
    String curr, prev = null;
    for (int l = 0; l < lines.length; l++) {
      String newLine = new String("");
      String[] cs = lines[l].split(" ");
      for (int c = 0; c < cs.length; c++) {
        curr = cs[c];
        if (curr.equals(",") && prev == null) {
          println("ERROR: composition cannot start with ,");
          exit();
        }
        if (curr.equals("|")) {
          continue;
        }
        if (curr.equals(",")) {
          curr =  prev;
        } else {
          prev = curr;
        }
        newLine = String.format("%s %s", newLine, curr);
      }
      compLines[l] = newLine;
    }
  }
};

Composition c;

void setup() {
  // use a fixed canvas size with 3:2 ratio so overlaying on digital images is easier.
  // TODO: calculate based on composition size.
  size(1200, 800);
  // load all the notes in the scale and store whatever state is necessary.
  loadNotes();
  background(0);
  c = new Composition("mohanavarnam1.txt", 8);
}

void draw() {
  // all code is in keyPressed - this is only here to ensure keyPressed
  // listens for key presses.
}

void keyPressed() {
  switch(key) {
  case 'h':
    renderHarmonicCurves(c);
    break;
  case 'c':
    renderConcentricCircles(c);
    break;
  case 'u':
    renderCurves(c, 0, height);
    break;
  case 'r':
    renderRect(c, false);
    break;
  case 'o':
    renderNotesOnCircle(c);
    break;
  case 'n':
    renderRandomCurves(c);
    break;
  }
}