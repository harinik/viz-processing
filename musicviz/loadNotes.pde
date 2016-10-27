HashMap<String, Float> nmap; // map representing the notes and their relative linear positions.
HashMap<String, Float> thetamap; // map representing the notes and their relative positions on a circle (in terms of the angle).
final String SCALE = "p,d1,d2,d3,n3,s,r1,r2,r3,g3,m1,m2,P,D1,D2,D3,N3,S,R1,R2,R3,G3,M1,M2";
/** 
 * Reads notes from the specified scale and stores state relevant to the rendering.
 * This implicitly assumes the Carnatic music scale.
 */
void loadNotes() {
  nmap = new HashMap<String, Float>();
  thetamap = new HashMap<String, Float>();
  String[] notes = SCALE.split(",");
  for (int i = 0; i < notes.length; i++) {
    float val = float(i) / notes.length;
    float theta = map(i, 0, notes.length, 0, 2 * PI);
    nmap.put(notes[i], val);
    thetamap.put(notes[i], theta);
  }
  nmap.put("g1", nmap.get("r2"));
  nmap.put("G1", nmap.get("R2"));
  nmap.put("g2", nmap.get("r3"));
  nmap.put("G2", nmap.get("R3"));
  nmap.put("n1", nmap.get("d2"));
  nmap.put("N1", nmap.get("D2"));
  nmap.put("n2", nmap.get("d3"));
  nmap.put("N2", nmap.get("D3"));

  thetamap.put("g1", thetamap.get("r2"));
  thetamap.put("G1", thetamap.get("R2"));
  thetamap.put("g2", thetamap.get("r3"));
  thetamap.put("G2", thetamap.get("R3"));
  thetamap.put("n1", thetamap.get("d2"));
  thetamap.put("N1", thetamap.get("D2"));
  thetamap.put("n2", thetamap.get("d3"));
  thetamap.put("N2", thetamap.get("D3"));
}