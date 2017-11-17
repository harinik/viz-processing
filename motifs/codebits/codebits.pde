
import java.util.Arrays;
import java.util.List;
import java.util.Collections;
import java.util.Random;

//String[] gocode = {"package", "main", "import", "\"fmt\"", "func", "main()", "{",
// "fmt.Println", "(\"Hello World!\")", "}"};

String gocode = "package main import \"fmt\" func main() { fmt.Println(\"HelloWorld!\") }";

void setup() {
  size(1200, 800);
  PFont f = createFont("Helvetica", 16, true);
  textFont(f, 43);
  fill(0);
  StringBuilder sb = new StringBuilder();
  byte[] bytes = gocode.getBytes();
  for (byte b : bytes) {
    int val = b;
    for (int i = 0; i < 8; i++) {
      int set = (val & 128) == 0 ? 0 : 1;
      sb.append((val & 128) == 0 ? 0 : 1);
    /*  boolean unset = (val & 128) == 0;
      if (unset) {
         ellipse(random(width-10), random(height-10), 15, 20); 
      } else {
         rect(random(width-10), random(height-10), 7, 20); 
      } */
      text(set, random(width), random(height));
      val <<= 1;
    }
  }
 
// text(sb.toString(), 10, 10, width - 10, height);
 save("codebits3.jpg");
}