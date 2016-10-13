
/**
 * Reads the notes of an Indian classical music composition stored in a text file (with a custom representation)
 * and plays the notes. The visualization for each note is generated as it is being played.
 * Example final image produced -
 * http://www.harinik.com/Portfolio/Musical-Art/i-mKh2nfx/A
 *
 * Author: Harini K (github.com/harinik)
 * Date: October 2016
 *
 * DISCLAIMER: I am relatively new to Processing and am primarily interested in the resulting
 * visualizations. So, some of this code may be ugly and repetitive but the visualizations themselves, 
 * not so much, I hope! :)
 */
import ddf.minim.*;
import ddf.minim.ugens.*;
import java.util.List;
import java.util.LinkedList;


Minim minim;
AudioOutput out;
int start; // used to keep track of time in draw()
int durationMs; // duration of a note.
final int TEMPO = 120; // in beats per minute
float startTime = 1.0; // start time for next note being played.
HashMap<String, Float> notesFreqMap;
String[] compLines;
boolean audioDone = false; // done playing audio ?
boolean vizDone = false; // done with visualization ?
int line = 0; // line being read from the file.
String prev = null; // previous note read from file.
int numBeats = 8; // number of beats in the composition.
float theta = 0; // starting angle of visualization in the circle.
LinkedList<Float> queue = new LinkedList<Float>(); // queue to communicate between the code playing audio and that for visual rendering.

void setup()
{
  size(600, 600, P3D);

  // load all the notes in the scale and associated state.
  loadNotesFreqMap();
  // load the composition.
  compLines = loadStrings("kamas1.txt");

  minim = new Minim(this);
  out = minim.getLineOut();

  // set the tempo of the sequencer
  out.setTempo( TEMPO );
  durationMs = int((60.0/TEMPO) * 1000);

  // initialize time
  start = millis();

  background(255);
}

void loadNotesFreqMap() {
  // notes spanning approx. 2 octaves
  String notesLn = "p,d1,d2,d3,n3,s,r1,r2,r3,g3,m1,m2,P,D1,D2,D3,N3,S,R1,R2,R3,G3,M1,M2";
  String[] notes = notesLn.split(",");
  notesFreqMap = new HashMap<String, Float>();
  // base freq
  float freq = 220;
  for (String note : notes) {
    notesFreqMap.put(note, freq);
    freq = freq * pow(2, 1/12.0);
  }
  notesFreqMap.put("g1", notesFreqMap.get("r2"));
  notesFreqMap.put("g2", notesFreqMap.get("r3"));
  notesFreqMap.put("G1", notesFreqMap.get("R2"));
  notesFreqMap.put("G2", notesFreqMap.get("R3"));
  notesFreqMap.put("n1", notesFreqMap.get("d2"));
  notesFreqMap.put("N1", notesFreqMap.get("D2"));
  notesFreqMap.put("n2", notesFreqMap.get("d3"));
  notesFreqMap.put("N2", notesFreqMap.get("D3"));

  println(notesFreqMap);
}

// Returns a list of strings representing notes from the given line of the composition.
List<String> readNotesFromLine(int ln) {
  String[] notes = compLines[ln].split(" ");
  ArrayList<String> notesList = new ArrayList<String>();
  String curr;
  for (String n : notes) {
    curr = n;
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
    notesList.add(curr);
  }
  return notesList;
}

void draw()
{
  if (audioDone && vizDone) {
    minim.stop();
    stop();
  }
  if (!audioDone) {
    // AudioOutput queues notes to play on a separate thread
    // So, the visualization is done separately below, using a queue
    // to synchronize the sound and visual.
    out.pauseNotes();
    List<String> notes = readNotesFromLine(line);
    for (String note : notes) {
      float n = notesFreqMap.get(note);
      // schedule note to be played.
      out.playNote(startTime, 1.5, n);
      // add note info to the queue so the visualization knows 
      // what it is dealing with.
      queue.add(n);
      startTime += 1.0;
    }
    out.resumeNotes();
  }
  // Perform the visualization separately.
  if (!vizDone) {
    int now = millis();
    // generate the visuals at the same interval that the notes are played
    // so the visual and sound are more or less synchronized.
    if (now - start  >= durationMs - 1) {
      try {
        // get next note from the queue
        Float c = queue.remove();
        float r = map(c, 220, 880, 0, width/2);
        float col = map(c, 220, 880, 0, 255);
        // Each note is represented by a spoke originating from the center of the canvas.
        // The length of the spoke corresponds to the frequency of the note (shorter = lower freq).
        stroke(0, 0, int(col));
        theta += 2 * PI / (compLines.length * numBeats * 4);
        float ex = width/2 + r * cos(theta);
        float ey = height/2 + r * sin(theta);
        line(width/2, height/2, ex, ey);
        start = now;
      } 
      catch(Exception e) { // nothing left in queue
        vizDone = true;
      }
    }
  }

  if (line < compLines.length - 1) {
    line++;
  } else {
    audioDone = true;
  }
}